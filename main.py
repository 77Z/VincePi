import tkinter as tk
import Gamepad
import time
import asyncio

w = tk.Tk()
w.attributes("-fullscreen", True)

mainFrame = tk.Frame(master=w, width=50, height=50, bg="#222222", cursor='')
mainFrame.pack(fill=tk.BOTH, side=tk.LEFT, expand=True)

#padding
#paddingTop = tk.Frame(master=w, height=10, bg="#ffffff")
#paddingTop.pack(fill=tk.BOTH, side=tk.TOP, expand=True)

#Content
title = tk.Label(text="VincePI", fg="#ffffff", bg="#222222", master=mainFrame, font=("Sans Serif", 50), pady=20)
title.pack()


async def mainloop():
    w.mainloop() # this method basically hangs execution so don't put anything after it

"""

    GAMEPAD CODE

"""

# Who knows what people will do with this code in the future
# I've made sure to comment it well, and this section of code
# allows you to swap to a different controller such as an
# Xbox or PS4 controller, in fact, the bindings are already
# in the Controllers.py file.
gamepadType = Gamepad.VincePad

# Buttons
button0 = 'BUTTON0'
button1 = 'BUTTON1'
button2 = 'BUTTON2'
button3 = 'BUTTON3'
superButton = "SUPER"

# Time between grabbing the button states, 0.1 is plenty of time.
# If you're REALLY tight on resources, raise this number.
pollInterval = 0.1


if not Gamepad.available():
    print("Connect Gamepad") # Only shows in debug mode
    while not Gamepad.available():
        time.sleep(1.0)
gamepad = gamepadType()
print("Connected")

# Start async updates
gamepad.startBackgroundUpdates()

# Gamepad Events
async def gamepadLoopEvents():
    try:
        while gamepad.isConnected():
            if gamepad.beenPressed(superButton):
                print("Exiting")
                break # Exits the while loop, thus killing the program

            # Sleep for polling interval
            await asyncio.sleep(pollInterval)
            #time.sleep(pollInterval)
    finally:
        gamepad.disconnect()

loop = asyncio.get_event_loop()
cors = asyncio.wait([gamepadLoopEvents(), mainloop()])
loop.run_until_complete(cors)
