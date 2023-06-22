from gpiozero import Button

button = Button(3)
while True:
    button.wait_for_press()
    print("The button was pressed!")