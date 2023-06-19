import numpy as np
import datetime as dt
import csv
import matplotlib.pyplot as plt
import serial
from time import sleep


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

#-----Additional Value-----##
Kp = 0 #Stiffness Around Goal Point
Kd = 1 #Damping of the Motor

##-----Goal Position-----##
x_r = 0.275
y_r = 0.24

##-----Log File Name-----##
filename = 'log4'

##-----Initial Condition-----##
#Plant
pos1 = 0
pos2 = 0

vel1 = 0
vel2 = 0

acc1 = 0
acc2 = 0

#Time
t = 0
dT = 0
duration = 20

#Estimator
ex1_M1 = 0
ex2_M1 = 0
ex3_M1 = 0

ex1_M2 = 0
ex2_M2 = 0
ex3_M2 = 0

##-----Parameter-----##
#Impedence
Dt = 0.8
Kt = 20

#Feedback
Kx = np.array([[-53.9808, -16.2723]])
Ky = np.array([[-54.0252, -16.2948]])

#Forward
Nx = 53.9506
Ny = 54.0252

#Plant
M = 0.5
I1 = 0.043
I2 = 0.234
l1 = 0.275
l2 = 0.24

kx = 0
ky = 0

#Observer
B1 = 27.9018
B2 = 259.5033
B3 = 804.5119
a = 1

#Safety Parameter
T_limit = 1 #Nm
End_Pos_tor = 0.02 #rad


def unpack(data):
    id = data[0]
    pos = ((data[1]*(P_MAX-P_MIN))/(pow(2,16)-1)) + P_MIN
    vel = ((data[2]*(V_MAX-V_MIN))/(pow(2,12)-1)) + V_MIN
    tor = ((data[3]*(T_MAX-T_MIN))/(pow(2,12)-1)) + T_MIN
    return id, pos, vel, tor

def receive():
    global dT, pos1_old, pos2_old
    # Read the response from the serial port
    received = ser.readline().decode().split()      

    # Print the received bytes
    # print("Received:", received)

    try:
        test = int(received[0])
        response = [int(x) for x in received]
        [id, p, v, t] = unpack(response)

        if id == 1:
            p = -round(p,3)
            if dT == 0:
                v = 0
            else:
                v = round((p - pos1_old)/dT,2)
        
        else:
            p = round(p,3)
            if dT == 0:
                v = 0
            else:
                v = round((p-pos2_old)/dT,2)

        # print the response from the Arduino
        # print([id, p, v, t])

    except (IndexError, ValueError):
        id = None
        p = 0
        v = 0
    return id, p, v

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



if __name__ == "__main__":
    print("Begining")
    # open the serial port
    ser = serial.Serial('/dev/cu.usbserial-14110', 115200, timeout=1)

    
    pos1_old = 0
    pos2_old = 0
    
    #M1
    print("Starting Zero Position M1")
    ser.write(bytes([0x01])+ZERO)
    sleep(3)
    [id, p, v] = receive()
    p = 5
    while abs(p) >= 0.001:
        ser.write(bytes([0x01])+ZERO)
        sleep(3)
        [id, p, v] = receive()

    

    #M2
    print("Starting Zero Position M2")
    ser.write(bytes([0x02])+ZERO)
    sleep(3)
    [id, p, v] = receive()
    p = 5
    while abs(p) >= 0.001:
        ser.write(bytes([0x02])+ZERO)
        sleep(3)
        [id, p, v] = receive()
    
    print("Finishing Zero Position")
    sleep(5)


    
    #M1
    print("Starting Enter Motors")
    ser.write(bytes([0x01])+ENTER)
    [id, p, v] = receive()
    if id == 1:
        pos1 = p
        vel1 = v
    
    elif id == 2:
        pos2 = p
        vel2 = v

    #M2
    ser.write(bytes([0x02])+ENTER)
    [id, p, v] = receive()

    if id == 1:
        pos1 = p
        vel1 = v
    
    elif id == 2:
        pos2 = p
        vel2 = v

    pos1_old = pos1
    pos2_old = pos2


    start_time = dt.datetime.today().timestamp()
    t = 0

    Time_log = list()
    ex3_M1_log = list()
    ex3_M2_log = list()
    Theta1_log = list()
    Theta2_log = list()
    T1_log = list()
    T2_log = list()
    vel1_log = list()
    vel2_log = list()

    # file = open(f'{filename}.csv', 'w', newline='')
    # # Create a writer object
    # writer = csv.writer(file)

    # # Write the header row
    # writer.writerow(['Time', 'x_r', 'y_r', 'Pos1_r', 'Pos2_r', 'T1', 'T2', 'vel1', 'vel2', 'pos1', 'pos2', 'x', 'y', 'RF1', 'RF2'])

    ##-----Inverse Kinematics-----##
    pos1_r = np.arctan((x_r * -1.92e+4 + y_r * 2.2e+4 - ((x_r * 1.92e+4 - np.sqrt(-(x_r**2 * 4.0e+4 + y_r**2 * 4.0e+4 - 4.9e+1) * (x_r**2 * 4.0e+4 + y_r**2 * 4.0e+4 - 1.0609e+4))) * 7.21e+2) / (y_r * 1.92e+4 + x_r**2 * 4.0e+4 + y_r**2 * 4.0e+4 - 7.21e+2) + (x_r**2 * (x_r * 1.92e+4 - np.sqrt(-(x_r**2 * 4.0e+4 + y_r**2 * 4.0e+4 - 4.9e+1) * (x_r**2 * 4.0e+4 + y_r**2 * 4.0e+4 - 1.0609e+4))) * 4.0e+4) / (y_r * 1.92e+4 + x_r**2 * 4.0e+4 + y_r**2 * 4.0e+4 - 7.21e+2) + (y_r**2 * (x_r * 1.92e+4 - np.sqrt(-(x_r**2 * 4.0e+4 + y_r**2 * 4.0e+4 - 4.9e+1) * (x_r**2 * 4.0e+4 + y_r**2 * 4.0e+4 - 1.0609e+4))) * 4.0e+4) / (y_r * 1.92e+4 + x_r**2 * 4.0e+4 + y_r**2 * 4.0e+4 - 7.21e+2) + (y_r * (x_r * 1.92e+4 - np.sqrt(-(x_r**2 * 4.0e+4 + y_r**2 * 4.0e+4 - 4.9e+1) * (x_r**2 * 4.0e+4 + y_r**2 * 4.0e+4 - 1.0609e+4))) * 1.92e+4) / (y_r * 1.92e+4 + x_r**2 * 4.0e+4 + y_r**2 * 4.0e+4 - 7.21e+2)) / (x_r * 2.2e+4 + x_r**2 * 4.0e+4 + y_r**2 * 4.0e+4 + 7.21e+2)) * 2.0
    pos2_r = np.arctan((x_r * 1.92e+4 - np.sqrt(-(x_r**2 * 4.0e+4 + y_r**2 * 4.0e+4 - 4.9e+1) * (x_r**2 * 4.0e+4 + y_r**2 * 4.0e+4 - 1.0609e+4))) / (y_r * 1.92e+4 + x_r**2 * 4.0e+4 + y_r**2 * 4.0e+4 - 7.21e+2)) * -2.0

    print("T1_r", pos1_r)
    print("T2_r", pos2_r)

    print("Start Controling")
    while t < duration:
        start_time = dt.datetime.today().timestamp()

        log = list()
        log.append(t)
        Time_log.append(t)
        log.append(x_r)
        log.append(y_r)
        log.append(pos1_r)
        log.append(pos2_r)
        Theta1_log.append(pos1)
        Theta2_log.append(pos2)
        pos1_old = pos1
        pos2_old = pos2

        if dT < 0.02:

            ##-----Impedence Control-----##
            Torque1_raw = -Dt*vel1 + Kt*(pos1_r-pos1)
            Torque2_raw = -Dt*vel2 + Kt*(pos2_r-pos2)

            ##-----Summation-----##
            Torque1 = Nx*pos1_r + np.matmul(Kx,np.array([[pos1],[vel1]])).item() - Torque1_raw
            Torque2 = Ny*pos2_r + np.matmul(Ky,np.array([[pos2],[vel2]])).item() - Torque2_raw

            
            ##-----Torque Limit-----##
            if np.isfinite(Torque1):
                if Torque1 > T_limit:
                    T1 = T_limit
                
                elif Torque1 < - T_limit:
                    T1 = -T_limit
                
                else:
                    T1 = Torque1
            else:
                T1 = 0

            if np.isfinite(Torque2):
                if Torque2 > T_limit:
                    T2 = T_limit
                
                elif Torque2 < - T_limit:
                    T2 = -T_limit
                
                else:
                    T2 = Torque2
            else:
                T2 = 0
            
            if abs(pos1_r-pos1) < End_Pos_tor:
                T1 = 0
            
            if abs(pos2_r-pos2) < End_Pos_tor:
                T2 = 0
            
            log.append(T1)
            log.append(T2)


            command1 = bytes(pack_cmd(pos1_r,0,-T1,Kp,Kd)) #(pos,vel,torque,kp,kd)
            command2 = bytes(pack_cmd(pos2_r,0,T2,Kp,Kd)) #(pos,vel,torque,kp,kd)
            #M1
            ser.write(bytes([0x01])+command1)
            [id, p, v] = receive()

            if id == 1:
                pos1 = p
                vel1 = v
            
            elif id == 2:
                pos2 = p
                vel2 = v

            #M2
            ser.write(bytes([0x02])+command2)
            [id, p, v] = receive()

            if id == 1:
                pos1 = p
                vel1 = v
            
            elif id == 2:
                pos2 = p
                vel2 = v

        else:

            T1 = 0
            T2 = 0

            log.append(T1)
            log.append(T2)


            command1 = bytes(pack_cmd(0,0,-T1,0,1)) #(pos,vel,torque,kp,kd)
            command2 = bytes(pack_cmd(0,0,T2,0,1)) #(pos,vel,torque,kp,kd)
            #M1
            ser.write(bytes([0x01])+command1)
            [id, p, v] = receive()

            if id == 1:
                pos1 = p
                vel1 = v
            
            elif id == 2:
                pos2 = p
                vel2 = v

            #M2
            ser.write(bytes([0x02])+command2)
            [id, p, v] = receive()

            if id == 1:
                pos1 = p
                vel1 = v
            
            elif id == 2:
                pos2 = p
                vel2 = v


        
        log.append(vel1)
        log.append(vel2)

        log.append(pos1)
        log.append(pos2)

        x = l1*np.cos(pos1) - l2*np.sin(pos2)
        y = l1*np.sin(pos1) + l2*np.cos(pos2)

        log.append(x)
        log.append(y)

        ##-----Observer-----##
        #Motor1
        ex1_M1+= (ex2_M1+B1*(pos1-ex1_M1))*dT
        ex2_M1+= (ex3_M1+B2*(pos1-ex1_M1)+a*T1)*dT
        ex3_M1+= (B3*(pos1-ex1_M1))*dT

        #Motor2
        ex1_M2+= (ex2_M2+B1*(pos2-ex1_M2))*dT
        ex2_M2+= (ex3_M2+B2*(pos2-ex1_M2)+a*T2)*dT
        ex3_M2+= (B3*(pos2-ex1_M2))*dT

        log.append(ex3_M1)
        log.append(ex3_M2)

        ex3_M1_log.append(-ex3_M1)
        ex3_M2_log.append(-ex3_M2)

        T1_log.append(T1)
        T2_log.append(T2)

        vel1_log.append(vel1)
        vel2_log.append(vel2)

        # writer.writerow(log)

        print("Progress", f'{round(t/duration*100,3)}%')
        dT = dt.datetime.today().timestamp()-start_time
        t+= dT
    
    ser.write(bytes([0x01])+EXIT)
    receive()

    #M2
    ser.write(bytes([0x02])+EXIT)
    receive()

    # close the serial port
    ser.close()
        
    
    print("finish")
    # file.close()

    # Create a figure with two subplots
    fig, ((ax1, ax2, ax3, ax4), (ax5, ax6, ax7, ax8)) = plt.subplots(2, 4, figsize=(15, 7))

    # Plot the first graph on the left subplot
    ax1.plot(Time_log, ex3_M1_log, color='blue')
    ax1.set_title('RF1')

    # Plot the second graph on the right subplot
    ax2.plot(Time_log, ex3_M2_log, color='green')
    ax2.set_title('RF2')

    ax3.plot(Time_log, Theta1_log, color='blue')
    ax3.plot(Time_log, pos1_r*np.ones((len(Time_log),)), color='black')
    ax3.set_title('Theta 1')

    ax4.plot(Time_log, Theta2_log, color='green')
    ax4.plot(Time_log, pos2_r*np.ones((len(Time_log),)), color='black')
    ax4.set_title('Theta 2')

    ax5.plot(Time_log, vel1_log, color='blue')
    ax5.set_title('Vel1')

    ax6.plot(Time_log, vel2_log, color='green')
    ax6.set_title('Vel2')

    ax7.plot(Time_log, T1_log, color='blue')
    ax7.set_title('T1')

    # Plot the second graph on the right subplot
    ax8.plot(Time_log, T2_log, color='green')
    ax8.set_title('T2')

    # Display the plot
    plt.subplots_adjust(hspace=0.5)
    plt.show()

        