from gpiozero import LED

PUL = LED(26)
DIR = LED(4)
ENA = LED(15)

step = 0.0005



    

ENA.off()
DIR.on()
PUL.blink(step,step,2000)
print("M")



