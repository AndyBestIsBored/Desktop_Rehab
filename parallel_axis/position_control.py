import serial
import datetime as dt


ENTER = bytes([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFC])
EXIT = bytes([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFD])
ZERO = bytes([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE])

# AK80-9 48V Motor Limit
P_MIN = -12.5
P_MAX = 12.5
V_MIN = -50.0
V_MAX = 50.0
T_MIN = -18.0
T_MAX = 18.0
KP_MIN = 0
KP_MAX = 500
KD_MIN = 0
KD_MAX = 5

p_in = 0.0
v_in = 0.0
t_in = 0.0
kp_in = 0.0
kd_in = 0.0
logs = []
move_angle = 0.26


def unpack(data):
    id = data[0]
    pos = ((data[1] * (P_MAX - P_MIN)) / (pow(2, 16) - 1)) + P_MIN
    vel = ((data[2] * (V_MAX - V_MIN)) / (pow(2, 12) - 1)) + V_MIN
    tor = ((data[3] * (T_MAX - T_MIN)) / (pow(2, 12) - 1)) + T_MIN

    return id, pos, vel, tor


def Motor_receive():
    # Read the response from the serial port
    received = Motor_ser.readline().decode().split()

    # Print the received bytes
    # print("Received:", received)

    try:
        test = int(received[0])
        response = [int(x) for x in received]
        [read_id, read_p, read_v, read_t] = unpack(response)

        # print the response from the Arduino
        # if len([read_id, read_p, read_v, read_t, read_clockwise]) != 0:
        #     print([read_id, read_p, read_v, read_t, read_clockwise])

    except (IndexError, ValueError):
        # print(received)
        # pass
        read_id, read_p, read_v, read_t = [0, 0, 0, 0]
    return read_id, read_p, read_v, read_t


def pack_cmd(p_des, v_des, t_ff, kp, kd):
    bufs = []

    def float_to_uint(val, val_min, val_max, bits):
        val_norm = (val - val_min) / (val_max - val_min)
        val_int = int(round(val_norm * ((1 << bits) - 1)))
        return val_int

    p_int = float_to_uint(p_des, P_MIN, P_MAX, 16)
    v_int = float_to_uint(v_des, V_MIN, V_MAX, 12)
    t_int = float_to_uint(t_ff, T_MIN, T_MAX, 12)
    kp_int = float_to_uint(kp, KP_MIN, KP_MAX, 12)
    kd_int = float_to_uint(kd, KD_MIN, KD_MAX, 12)

    bufs.append((p_int >> 8) & 0xFF)
    bufs.append(p_int & 0xFF)
    bufs.append((v_int >> 4) & 0xFF)
    bufs.append(((v_int & 0xF) << 4) | ((kp_int >> 8) & 0xF))
    bufs.append(kp_int & 0xFF)
    bufs.append((kd_int >> 4) & 0xFF)
    bufs.append(((kd_int & 0xF) << 4) | ((t_int >> 8) & 0xF))
    bufs.append(t_int & 0xFF)

    return bufs


def update_p(current_p, minus_val):
    if (current_p - minus_val) < P_MIN:
        over_P_MIN = abs((current_p - minus_val)) - P_MIN
        new_P = P_MAX - over_P_MIN
    else:
        new_P = current_p - minus_val
    return new_P


def constrain(val, min_val, max_val):
    return min(max_val, max(min_val, val))

# Set zero before enter motor to set current position to be zero
# Enter motor mode -> then set zero -> motor first move to zero position


if __name__ == "__main__":
    # open the Motor_serial port
    Motor_ser = serial.Serial('COM4', 115200, timeout=1)

    print("Begin")
    Motor_receive()

    start_zero = dt.datetime.today().timestamp()
    t0 = 0

    print("Setting zero to motor")
    while t0 < 3:
        # M1
        Motor_ser.write(bytes([0x01]) + ZERO)
        motor_id, zero_p, zero_v, zero_t = Motor_receive()

        # Time for setting zero
        t0 = dt.datetime.today().timestamp() - start_zero

    start_enter = dt.datetime.today().timestamp()

    t_enter = 0
    print("Entering Motor Mode")
    while t_enter < 3:
        enter_log = []
        # M1
        Motor_ser.write(bytes([0x01]) + ENTER)
        motor_id, enter_p, enter_v, enter_t = Motor_receive()
        enter_log.extend([motor_id, enter_p, enter_v, enter_t])
        logs.append(enter_log)
        # Time for entering motor mode
        t_enter = dt.datetime.today().timestamp() - start_enter

    # n_iteration = 4
    print("Entering main loop")

    # Read current pos
    motor_id, p, v, t = Motor_receive()

    start_backward = dt.datetime.today().timestamp()
    t_backward = 0
    while t_backward < 15:
        print("Going backward")
        backward_log = []
        # Move p backward 15 degree
        # Edit value here for each trial
        p_in = p + move_angle
        p_in = constrain(p_in, P_MIN, P_MAX)
        kp_in = 1.5
        kd_in = 0.2

        t_backward = dt.datetime.today().timestamp() - start_backward
        command = bytes(pack_cmd(p_in, v_in, t_in, kp_in, kd_in))
        Motor_ser.write(bytes([0x01]) + command)
        motor_id, p_back_receive, v, t = Motor_receive()
        backward_log.extend([t_backward, motor_id, p_back_receive, v, t])
        print(backward_log)
        logs.append(backward_log)

    # Exit motor mode
    Motor_ser.write(bytes([0x01]) + EXIT)
    Motor_receive()

    # close the Motor_serial port
    Motor_ser.close()

# Save logs as csv
# with open("motor_logs.csv", "w", newline="") as csvfile:
#     writer = csv.writer(csvfile)
#     writer.writerows(logs[:])
