import serial
import datetime as dt
from time import sleep

# Open the serial port
ser = serial.Serial('/dev/ttyUSB1', 115200)  # Replace 'COM3' with the appropriate port name

start_time = dt.datetime.today().timestamp()
t = 0

freq = 500 #ms
while t < 10:
    t = dt.datetime.today().timestamp() - start_time
    while t < 5:
        t = dt.datetime.today().timestamp() - start_time
        DIR = 1


        # Send data to Arduino
        data = f"{DIR},{freq}"
        
        ser.write(data.encode())

        # Read data from Arduino

        response = ser.readline().decode()
        print(response)
    

    
    DIR = 0

    # Send data to Arduino
    data = f"{DIR},{freq}"
    ser.write(data.encode())

    # Read data from Arduino
   
    response = ser.readline().decode()
    print(response)
    t = dt.datetime.today().timestamp() - start_time
    
    

# Close the serial port
ser.close()
