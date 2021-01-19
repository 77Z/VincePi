import tkinter as tk

w = tk.Tk()
w.attributes("-fullscreen", True)

mainFrame = tk.Frame(master=w, width=50, height=50, bg="#222222")
mainFrame.pack(fill=tk.BOTH, side=tk.LEFT, expand=True)

#padding
#paddingTop = tk.Frame(master=w, height=10, bg="#ffffff")
#paddingTop.pack(fill=tk.BOTH, side=tk.TOP, expand=True)

#Content
title = tk.Label(text="VincePI", fg="#ffffff", bg="#222222", master=mainFrame, font=("Sans Serif", 50), pady=20)
title.pack()

w.mainloop()
