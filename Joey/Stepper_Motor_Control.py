from gpiozero import LED, Button
from time import sleep
    

def moveright():
    DIR.on()
    PUL.blink(0.001,0.001)
    print("R")
    
def moveleft():
    DIR.off()
    PUL.blink(0.001,0.001)
    print("L")

PUL = LED(26)
DIR = LED(4)
ENA = LED(15)
LMR = Button(2)
LML = Button(3)

ENA.off()
DIR.on()
PUL.blink(0.001, 0.001)

LML.when_pressed = moveright
LMR.when_pressed = moveleft
