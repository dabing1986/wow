import pyautogui,win32gui,time,random



# def hold_W (hold_time):
#     import time, pyautogui
#     start = time.time()
#     while ti me.time() - start < hold_time:
#         pyautogui.press('w')

def press_button(button_name, time_of_button_press):

    pyautogui.keyDown(button_name)
    time.sleep(time_of_button_press)
    pyautogui.keyUp(button_name)


time.sleep(3)

window = win32gui.FindWindow(None,"魔兽世界") 
win32gui.SetForegroundWindow(window)

while True:
	val = random.randint(1,10)
	
	# pyautogui.press("up")
	# hold_W(2000)
	# pyautogui.keyDown("left") 
	# press_button("left",4)
	# time.sleep(5)
	# pyautogui.keyUp("left") 
	# pyautogui.press("a") 1
	# press_button("w",0.5)
	# press_button("a",0.2)
	# press_button("s",0.5)
	# press_button("d",0.2)
	# press_button("space",0.5)
	# press_button("1",0.5)
	# time.sleep(1)
	press_button("r",0.5)
	# press_button("2",0.5)
	# time.sleep(1)
	# press_button("e",0.5)
	# time.sleep(random.randint(1,3))
	# pyautogui.keyDown('alt') 
	# time.sleep(.2)
	# pyautogui.press('tab')
	# time.sleep(.2)
	# pyautogui.keyUp('alt')
	time.sleep(2)
	# time.sleep(random.randint(5,8))


# while True:
# 	val = random.randint(1,10)
	
# 	# pyautogui.press("up")
# 	# hold_W(2000) 1