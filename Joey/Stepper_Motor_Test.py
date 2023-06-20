from gpiozero import LED

PUL = LED(26)
DIR = LED(4)
ENA = LED(15)

ENA.on()
DIR.on()
PUL.blink(0.00001,0.00001,5000)
