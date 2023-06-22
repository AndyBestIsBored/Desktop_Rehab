import serial
import datetime as dt
from time import sleep


##-----Motor-----##

ENTER = bytes([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFC])
EXIT = bytes([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFD])
ZERO = bytes([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE])


# AK70-10 24V Motor Limit
P_MIN = -12.5
P_MAX = 12.5
V_MIN = -50  
V_MAX = 50
T_MIN = -25 
T_MAX = 25
KP_MIN = 0
KP_MAX = 500
KD_MIN = 0
KD_MAX = 5

def unpack(data):
    id = data[0]
    pos = ((data[1]*(P_MAX-P_MIN))/(pow(2,16)-1)) + P_MIN
    vel = ((data[2]*(V_MAX-V_MIN))/(pow(2,12)-1)) + V_MIN
    tor = ((data[3]*(T_MAX-T_MIN))/(pow(2,12)-1)) + T_MIN
    return id, pos, vel, tor

def Motor_receive():
    # Read the response from the serial port
    received = Motor_ser.readline().decode().split()      

    # Print the received bytes
    # print("Received:", received)

    try:
        test = int(received[0])
        response = [int(x) for x in received]
        [id, p, v, t] = unpack(response)

        # print the response from the Arduino
        if len([id, p, v, t]) != 0:
            print([id, p, v, t])

    except (IndexError, ValueError):
        # print(received)
        pass
    return

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


##-----Stepper Motor-----##
def Stepper_receive():
    # Read the response from the serial port
    received = STP_ser.readline().decode().split()      

    # Print the received bytes
    # print("Received:", received)

    try:
        test = int(received[0])
        response = [int(x) for x in received]
        [id, p, v, t] = unpack(response)

        # print the response from the Arduino
        if len([id, p, v, t]) != 0:
            print([id, p, v, t])

    except (IndexError, ValueError):
        # print(received)
        pass
    return

if __name__ == "__main__":
    # open the Motor_serial port
    Motor_ser = serial.Serial('/dev/ttyUSB0', 115200, timeout=1)
    STP_ser = serial.Serial('/dev/ttyUSB1', 115200, timeout=1)
    print("Begin")
    start_zero = dt.datetime.today().timestamp()

    #Motor
    t0 = 0
    count = 0

    print("Setting zero to both motor")
    while t0 < 3:
        #M1
        Motor_ser.write(bytes([0x01])+ZERO)
        Motor_receive()

        #M2
        Motor_ser.write(bytes([0x02])+ZERO)
        Motor_receive()

        t0 = dt.datetime.today().timestamp() - start_zero
    
    sleep(3)
    start_enter = dt.datetime.today().timestamp()
    t_enter = 0
    while t_enter < 2:
        #M1
        Motor_ser.write(bytes([0x01])+ENTER)
        Motor_receive()

        #M2
        Motor_ser.write(bytes([0x02])+ENTER)
        Motor_receive()

        t_enter = dt.datetime.today().timestamp() - start_enter

    start_time = dt.datetime.today().timestamp()
    t = 0


    #Stepper
    

    while t < 5:

        command = bytes(pack_cmd(0,1,0,0,1)) #(pos,vel,torque,kp,kd)
        #M1
        Motor_ser.write(bytes([0x01])+command)
        Motor_receive()

        #M2
        Motor_ser.write(bytes([0x02])+command)
        Motor_receive()
     

        count+=1
        t = dt.datetime.today().timestamp() - start_time
    
    Motor_ser.write(bytes([0x01])+EXIT)
    Motor_receive()

    #M2
    Motor_ser.write(bytes([0x02])+EXIT)
    Motor_receive()

# close the Motor_serial port
Motor_ser.close()
print(t/count)
