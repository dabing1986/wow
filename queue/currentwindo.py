import win32gui


def enum_windows_callback(hwnd, extra):
    class_name = win32gui.GetClassName(hwnd)
    window_title = win32gui.GetWindowText(hwnd)
    
    with open("window_info.txt", "a", encoding="utf-8") as file:
        file.write("Window Class: {}\n".format(class_name))
        file.write("Window Title: {}\n".format(window_title))
        file.write("----\n")

# Open the file in write mode to clear any previous content
with open("window_info.txt", "w", encoding="utf-8") as file:
    file.write("Window Information:\n")

# Enumerate windows and write information to the file
win32gui.EnumWindows(enum_windows_callback, None)
