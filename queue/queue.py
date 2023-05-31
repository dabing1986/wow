
# *   -
# 思路：每分钟结束魔兽世界进程，切换到战网，点击[进入游戏]。不会对魔兽世界有任何操作，否则也许会被判定使用第三方程序。
# 扩展：朋友让我帮忙排队或者防暂离，需要多个战网切换点击[进入游戏]。
# 待扩展的：同一个战网下多个子账号登录，未写。因为不想对战网有更多的操作。
# 使用方法：
# 1、下载python，如果有请跳过。(这里建议使用python进行操作，我可以导出exe，但是担心会出问题。)
# 2、新建txt文件，将下方源码复制进去，将扩展名.txt改为.py，打开方式改为python。
# 3、登录战网并点击[进入游戏]
# 4、打开源码程序。
# 程序源码：
import time
import importlib
import cv2
import pyautogui
import win32gui
import random
import win32clipboard as w
import win32con
import win32api

try:
    from tqdm import tqdm
except ImportError:
    # 如果没有安装，则使用pip安装
    import subprocess
    subprocess.check_call(["pip", "install", "tqdm"])
    # 重新导入模块
    importlib.reload(tqdm)

try:
    import win32api
    import win32gui
    import win32con
except ImportError:
    # 如果没有安装，则使用pip安装
    import subprocess
    subprocess.check_call(["pip", "install", "pywin32"])
    # 重新导入模块
    importlib.reload(win32api)
    importlib.reload(win32gui)
    importlib.reload(win32con)

try:
    import psutil
except ImportError:
    # 如果没有安装，则使用pip安装
    import subprocess
    subprocess.check_call(["pip", "install", "psutil"])
    # 重新导入模块
    importlib.reload(psutil)



key_map = {
"1": 49, "2": 50, "3": 51, "4": 52, "5": 53, "6": 54, "7": 55, "8": 56, "9": 57, "0": 48,
'F1': 112, 'F2': 113, 'F3': 114, 'F4': 115, 'F5': 116, 'F6': 117, 'F7': 118, 'F8': 119,
'F9': 120, 'F10': 121, 'F11': 122, 'F12': 123, 'F13': 124, 'F14': 125, 'F15': 126, 'F16': 127,
"A": 65, "B": 66, "C": 67, "D": 68, "E": 69, "F": 70, "G": 71, "H": 72, "I": 73, "J": 74,
"K": 75, "L": 76, "M": 77, "N": 78, "O": 79, "P": 80, "Q": 81, "R": 82, "S": 83, "T": 84,
"U": 85, "V": 86, "W": 87, "X": 88, "Y": 89, "Z": 90,
'BACKSPACE': 8, 'TAB': 9, 'TABLE': 9, 'CLEAR': 12,
'ENTER': 13, 'SHIFT': 16, 'CTRL': 17,
'CONTROL': 17, 'ALT': 18, 'ALTER': 18, 'PAUSE': 19, 'BREAK': 19, 'CAPSLK': 20, 'CAPSLOCK': 20, 'ESC': 27,
'SPACE': 32, 'SPACEBAR': 32, 'PGUP': 33, 'PAGEUP': 33, 'PGDN': 34, 'PAGEDOWN': 34, 'END': 35, 'HOME': 36,
'LEFT': 37, 'UP': 38, 'RIGHT': 39, 'DOWN': 40, 'SELECT': 41, 'PRTSC': 42, 'PRINTSCREEN': 42, 'SYSRQ': 42,
'SYSTEMREQUEST': 42, 'EXECUTE': 43, 'SNAPSHOT': 44, 'INSERT': 45, 'DELETE': 46, 'HELP': 47, 'WIN': 91,
'WINDOWS': 91, 'NMLK': 144,
'NUMLK': 144, 'NUMLOCK': 144, 'SCRLK': 145}


def release_key(key_code):
    # 函数功能：抬起按键
    # 参数：key:按键值
    win32api.keybd_event(key_code, win32api.MapVirtualKey(key_code, 0), win32con.KEYEVENTF_KEYUP, 0)


def press_key(key_code):
    # 函数功能：按下按键
    # 参数：key:按键值
    win32api.keybd_event(key_code, win32api.MapVirtualKey(key_code, 0), 0, 0)


def press_and_release_key(key_code):
    # 按一下按键
    #:param key_code: 按键值，如91,代表WIN windows系统的系统按键，弹出开始菜单
    #:return:
    press_key(key_code)
    release_key(key_code)


def pressKey(key):
    # 点击按键(按下并抬起)
    #:param key: 按键,如:F5,ENTER
    #:return:
    if isinstance(key, str):
        press_and_release_key(key_map[key.upper()])
    elif isinstance(key, int):
        press_and_release_key(key)


# 定义一个回调函数，用于枚举所有窗口
def get_windows_with_title(title):
    windows = []

    def enum_windows_callback(hwnd, window_list):
        window_text = win32gui.GetWindowText(hwnd)
        if window_text == title:
            window_list.append(hwnd)

    win32gui.EnumWindows(enum_windows_callback, windows)

    return windows

def loginBattleNet(hwnd):
        # Get the screen dimensions

        window_rect = win32gui.GetWindowRect(hwnd)
        left, top, right, bottom = window_rect

        # Target position within the window
        login_target_x = 207  # X-coordinate
        login_target_y = 642  # Y-coordinate

        # Calculate the position on the screen
        screen_x = left + login_target_x
        screen_y = top + login_target_y

        # Move the cursor to the specified position
        pyautogui.moveTo(screen_x, screen_y)

        print("try to click login")
        print("absolute_x: " + str(screen_x) + " absolute_y: " + str(screen_y))

        # Perform a single click
        pyautogui.click()
        time.sleep(3)


def find_and_click_image(image_path):
    # Get the current window handle
    current_window = win32gui.GetForegroundWindow()

    # Set the new width and height values
    new_width = 800
    new_height = 600

    # Resize the window
    # win32gui.MoveWindow(current_window, 0, 0, new_width, new_height, True)
    time.sleep(1)
    # Get the window coordinates
    window_rect = win32gui.GetWindowRect(current_window)
    window_left, window_top, window_right, window_bottom = window_rect

    # Calculate the region based on window coordinates
    region = (window_left, window_top, window_right - window_left, window_bottom - window_top)

    # Search for the image within the window region
    location = pyautogui.locateOnScreen(image_path, region=region)
    if location is not None:
        # Image found within the window
        center_x = location.left + location.width // 2
        center_y = location.top + location.height // 2

        # Move the mouse to the center of the image and perform a click
        pyautogui.moveTo(center_x, center_y)
        pyautogui.click()
        time.sleep(0.5)
        pyautogui.moveTo(center_x + 100, center_y + 100)
        return True
    else:
        # Image not found within the window
        return False


# send wechat 
# 作者：山鸟与鱼
# 链接：https://www.zhihu.com/question/577002572/answer/2831978193
# 来源：知乎
# 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

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


def distribute_windows(hwnd1, hwnd2, screen_width, screen_height):
    # Calculate the new width and height for each window
    new_width = screen_width // 2
    new_height = screen_height

    # Calculate the new positions for each window
    left1 = 0
    top1 = 0
    left2 = new_width
    top2 = 0

    # Set the new positions and dimensions for each window
    win32gui.SetWindowPos(hwnd1, None, left1, top1, new_width, new_height, 0)
    win32gui.SetWindowPos(hwnd2, None, left2, top2, new_width, new_height, 0)

try:
    # Code that may raise an exception
    # ...
    # ...
    if __name__ == '__main__':
        while True:
            #
            # 设置60秒等待时间
            # print("倒计时60秒，即将执行关闭魔兽世界进程，并打开战网重新登录。")
            # window_title_01 = "魔兽世界"
            # windows_01 = get_windows_with_title(window_title_01)
                

            # if len(windows_01) == 2:
            #     screen_width = 1920  # Replace with the actual screen width
            #     screen_height = 1080  # Replace with the actual screen height

            #     distribute_windows(windows_01[0], windows_01[1], screen_width, screen_height)

            time.sleep(0.5)
            countdown_time = int(random.uniform(60, 80))
            # 使用tqdm模块创建进度条
            for t in tqdm(range(countdown_time)):
                # 每秒钟更新一次进度条
                time.sleep(1)
            
            #
            # 逐个关闭魔兽世界进程
            for proc in psutil.process_iter():
                try:
                    # 获取进程名称
                    process_name = proc.name()
            
                    # 如果进程名称包含指定的字符串，则终止该进程
                    if "WowClassic.exe" in process_name:
                        proc.terminate()
                except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                    pass
            
            #
            # 逐个登录魔兽世界
            # 枚举所有窗口，并将符合条件的窗口句柄添加到列表中


            window_title = "战网"
            windows = get_windows_with_title(window_title)
            # for hwnd in windows:
            #     print("Window handle:", hwnd)


            # window_list = []
            # win32gui.EnumWindows(enum_windows_callback, window_list)
            
            # 将每个窗口设置为当前活跃窗口
            i = 1
            for hwnd in windows:
                
                # win32gui.SetForegroundWindow(hwnd)
                # time.sleep(3)
                # loginBattleNet(hwnd)
                # if i == 2:
                #     raise ValueError("Invalid value provided.")
                if i != 1:

                    countdown_time = int(random.uniform(20, 25))
                    # 使用tqdm模块创建进度条
                    print("倒计时20秒后切换到第" + str(i) + "个战网")
                    for t in tqdm(range(countdown_time)):
                        # 每秒钟更新一次进度条
                        time.sleep(1)
            
                # print(str(hwnd))
                print("打开第" + str(i) + "个战网，并执行Enter按键")
                time.sleep(1)
                win32gui.SetForegroundWindow(hwnd)
                time.sleep(1)
                loginBattleNet(hwnd)

                # image_path = "D:\Repos\wow\queue\image\login.png"  # Replace with the path to your image file
                # if find_and_click_image(image_path):

                #     print("Image found and clicked within the current window")
                # else:
                #     print("Image not found within the current window")

                i = i + 1
except Exception as e:
    name_list = ["文件传输助手"]
    send_content = "服务器重启了！！请联系一下天照看看是否一切安好"
    send_messages_to_contacts(name_list, send_content)

