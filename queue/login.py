import subprocess
import win32gui
import win32con
import time 
import pyautogui
import win32api
import win32clipboard as w
import subprocess
import ctypes
from tqdm import tqdm

pyautogui.PAUSE = 1
def enter():
    win32api.keybd_event(13,0,0,0)
    win32api.keybd_event(13,0,win32con.KEYEVENTF_KEYUP,0)

# 定义一个回调函数，用于枚举所有窗口
def get_windows_with_title(title):
    windows = []

    def enum_windows_callback(hwnd, window_list):
        window_text = win32gui.GetWindowText(hwnd)
        if window_text == title:
            window_list.append(hwnd)

    win32gui.EnumWindows(enum_windows_callback, windows)

    return windows

#把文字放入剪贴板
def setText(aString):
    w.OpenClipboard()
    w.EmptyClipboard()
    w.SetClipboardData(win32con.CF_UNICODETEXT,aString)
    w.CloseClipboard()
    
#模拟ctrl+V
def ctrlV():
    win32api.keybd_event(17,0,0,0) #按下ctrl
    win32api.keybd_event(86,0,0,0) #按下V
    win32api.keybd_event(86,0,win32con.KEYEVENTF_KEYUP,0)#释放V
    win32api.keybd_event(17,0,win32con.KEYEVENTF_KEYUP,0)#释放ctrl

def ctrlA():
    # Simulate pressing the Ctrl key
    pyautogui.keyDown('ctrl')

    # Simulate pressing the A key
    pyautogui.press('a')

    # Release the Ctrl key
    pyautogui.keyUp('ctrl')


def loginBattleNet(hwnd, username, password):
        # Get the screen dimensions

        window_rect = win32gui.GetWindowRect(hwnd)
        left, top, right, bottom = window_rect

        # Target position within the window
        username_target_x = 204  # X-coordinate
        username_target_y = 285  # Y-coordinate

        pass_target_x = 140  # X-coordinate
        pass_target_y = 346  # Y-coordinate

        # Calculate the position on the screen
        screen_x = left + username_target_x
        screen_y = top + username_target_y

        # Move the cursor to the specified position
        pyautogui.moveTo(screen_x, screen_y)

        print("try to set username")
        print("absolute_x: " + str(screen_x) + " absolute_y: " + str(screen_y))

        # Perform a single click
        pyautogui.doubleClick()
        time.sleep(1)
        # pyautogui.click()
        # time.sleep(1)       
        ctrlA()
        time.sleep(1)
        setText(username)
        ctrlV()
        # password

        screen_x = left + pass_target_x
        screen_y = top + pass_target_y

        # Move the cursor to the specified position
        pyautogui.moveTo(screen_x, screen_y)

        time.sleep(1)
        print("try to set password")
        print("absolute_x: " + str(screen_x) + " absolute_y: " + str(screen_y))
        # Perform a single click
        pyautogui.doubleClick()
        time.sleep(1)
        setText(password)
        ctrlV()

# # Specify the command with arguments
# command = ["D:\\tools\\47\\gamecap.exe"]

# # Execute the command
# subprocess.run(command)
# # Window Class: TfrmLogin.UnicodeClass
# # Window Title: 47代理-国际版 3.9

time.sleep(3)

# time.sleep(3)
# Specify the window class and title
window_class = u"TfrmLogin.UnicodeClass"
window_title = u"47代理-国际版 3.9"
pyautogui.click(1580, 1411)
# Point(x=1580, y=1411)

time.sleep(3)
# Find the window by class and title
hwnd = win32gui.FindWindow(window_class, window_title)

if hwnd != 0:
    # Window found, bring it to the foreground
    # win32gui.ShowWindow(hwnd, win32con.SW_SHOW)
    win32gui.SetForegroundWindow(hwnd)
    print(hwnd)
    time.sleep(1)
    # win32gui.MoveWindow(hwnd, 0, 0, 1000, 700, True) 
    enter()
    
    # enter_key_code = 0x0D  # Enter key code
    # lparam = (1 << 24) | (win32api.MapVirtualKey(enter_key_code, 0) << 16)  # Construct the LPARAM for the key event
    # win32api.SendMessage(hwnd, win32con.WM_KEYDOWN, enter_key_code, lparam)
    # win32api.SendMessage(hwnd, win32con.WM_KEYUP, enter_key_code, lparam)

else:
    # Window not found
    print("Window not found.")

import json

# Read the JSON file and parse it as a Python object
with open('D:\\Repos\\wow\\queue\\user.json') as file:
    data = json.load(file)

length = len(data)
application_path = "D:\\tools\\Battle.net\\Battle.net.exe"
for i in range(0,length):
    subprocess.Popen(application_path)
    time.sleep(5)

window_title = "战网登录"
windows = get_windows_with_title(window_title)
# for hwnd in windows:
#     print("Window handle:", hwnd)

for t in tqdm(range(3)):
    # 每秒钟更新一次进度条
    time.sleep(1)
# window_list = []
# win32gui.EnumWindows(enum_windows_callback, window_list)

# 将每个窗口设置为当前活跃窗口
i = 0
for hwnd_battlenet in windows:
    time.sleep(3)
    win32gui.SetForegroundWindow(hwnd_battlenet)
    

    loginBattleNet(hwnd_battlenet, data[i]['username'], data[i]['password'])
    time.sleep(5)
    i = i + 1

