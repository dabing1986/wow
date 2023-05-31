import time
import importlib
import cv2
import pyautogui
import win32gui
import random
import win32clipboard as w
import win32con
import win32api
import uiautomation as auto

# pyautogui.PAUSE = 1 

# print(pyautogui.position()) # 打印坐标，Point(x=148, y=879)
# icon_position = pyautogui.position() # Point(x=148, y=879) Point(x=359, y=1414)
# Point(x=359, y=1414)


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
    
#模拟alt+s
def altS():
    win32api.keybd_event(18,0,0,0)
    win32api.keybd_event(83,0,0,0)
    win32api.keybd_event(83,0,win32con.KEYEVENTF_KEYUP,0)
    win32api.keybd_event(18,0,win32con.KEYEVENTF_KEYUP,0)
# 模拟enter
def enter():
    win32api.keybd_event(13,0,0,0)
    win32api.keybd_event(13,0,win32con.KEYEVENTF_KEYUP,0)
#模拟鼠标单击
def click():
    win32api.mouse_event(win32con.MOUSEEVENTF_LEFTDOWN,0,0,0,0)
    win32api.mouse_event(win32con.MOUSEEVENTF_LEFTUP,0,0,0,0)
#移动鼠标的位置
def movePos(x,y):
    win32api.SetCursorPos((x,y))

def send_messages_to_contacts(name_list, send_content):

    # wechatWindow = auto.WindowControl(searchDepth=1, Name="微信", ClassName='WeChatMainWndForPC')
    # wechatWindow.SetActive()
    # txl_btn = wechatWindow.ButtonControl(Name='通讯录')
    # txl_btn.Click()
    pyautogui.click(359, 1414)
    hwnd_chat = win32gui.FindWindow(None, '微信')  # Returns the handle of the WeChat window
    win32gui.SetForegroundWindow(hwnd_chat)  # Activate and show the WeChat window
    win32gui.MoveWindow(hwnd_chat, 0, 0, 1000, 700, True)  # Move the WeChat window to the specified position and size
    time.sleep(1)
    
    for name in name_list:
        movePos(28, 147)
        click()
        movePos(148, 35)
        click()
        time.sleep(1)
        setText(name)
        ctrlV()
        time.sleep(1)  # Wait for contact search to succeed
        enter()
        time.sleep(1)
        setText(send_content)
        ctrlV()
        time.sleep(1)
        altS()
        time.sleep(1)

    win32gui.PostMessage(hwnd_chat, win32con.WM_CLOSE, 0, 0)

name_list = ["文件传输助手"]
send_content = "你挂了！！"
send_messages_to_contacts(name_list, send_content)