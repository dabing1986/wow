import pyautogui
import time
import win32gui
import win32api
time.sleep(5)

pyautogui.PAUSE = 1


# Get the handle of the target window
hwnd = win32gui.GetForegroundWindow()

# Get the window position and dimensions
window_rect = win32gui.GetWindowRect(hwnd)
window_left, window_top, window_right, window_bottom = window_rect

# Get the cursor position on the screen
cursor_x, cursor_y = win32api.GetCursorPos()

# Calculate the cursor position within the window
window_cursor_x = cursor_x - window_left
window_cursor_y = cursor_y - window_top

print("Cursor position within the window:")
print("X:", window_cursor_x)
print("Y:", window_cursor_y)

import win32gui

def set_window_size(hwnd, width, height):
    # Calculate the new width and height to maintain a 16:9 aspect ratio
    aspect_ratio = 16 / 9
    new_width = int(height * aspect_ratio)
    new_height = int(width / aspect_ratio)

    # Adjust the width or height to fit within the specified dimensions
    if new_width > width:
        new_width = width
    else:
        new_height = height

    # Calculate the position of the top-left corner to center the window
    left = (width - new_width) // 2
    top = (height - new_height) // 2

    # Set the new window size and position
    win32gui.SetWindowPos(hwnd, None, left, top, new_width, new_height, 0)

# Example usage:
def get_windows_with_title(title):
    windows = []

    def enum_windows_callback(hwnd, window_list):
        window_text = win32gui.GetWindowText(hwnd)
        if window_text == title:
            window_list.append(hwnd)

    win32gui.EnumWindows(enum_windows_callback, windows)

    return windows

window_title = "魔兽世界"
windows = get_windows_with_title(window_title)
    

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

screen_width = 1920  # Replace with the actual screen width
screen_height = 1080  # Replace with the actual screen height

distribute_windows(windows[0], windows[1], screen_width, screen_height)


