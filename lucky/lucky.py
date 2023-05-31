import pyautogui,win32gui,time,random


import cv2
import numpy as np

# def hold_W (hold_time):
#     import time, pyautogui
#     start = time.time()
#     while ti me.time() - start < hold_time:
#         pyautogui.press('w')
import random
import pyautogui
import time
import cv2
import numpy as np
from random import randrange
 
 
def py_nms(dets, thresh):
    """Pure Python NMS baseline."""
    # x1、y1、x2、y2、以及score赋值
    # （x1、y1）（x2、y2）为box的左上和右下角标
    x1 = dets[:, 0]
    y1 = dets[:, 1]
    x2 = dets[:, 2]
    y2 = dets[:, 3]
    scores = dets[:, 4]
    # 每一个候选框的面积
    areas = (x2 - x1 + 1) * (y2 - y1 + 1)
    # order是按照score降序排序的
    order = scores.argsort()[::-1]
    # print("order:",order)
 
    keep = []
    while order.size > 0:
        i = order[0]
        keep.append(i)
        # 计算当前概率最大矩形框与其他矩形框的相交框的坐标，会用到numpy的broadcast机制，得到的是向量
        xx1 = np.maximum(x1[i], x1[order[1:]])
        yy1 = np.maximum(y1[i], y1[order[1:]])
        xx2 = np.minimum(x2[i], x2[order[1:]])
        yy2 = np.minimum(y2[i], y2[order[1:]])
        # 计算相交框的面积,注意矩形框不相交时w或h算出来会是负数，用0代替
        w = np.maximum(0.0, xx2 - xx1 + 1)
        h = np.maximum(0.0, yy2 - yy1 + 1)
        inter = w * h
        # 计算重叠度IOU：重叠面积/（面积1+面积2-重叠面积）
        ovr = inter / (areas[i] + areas[order[1:]] - inter)
        # 找到重叠度不高于阈值的矩形框索引
        inds = np.where(ovr <= thresh)[0]
        # print("inds:",inds)
        # 将order序列更新，由于前面得到的矩形框索引要比矩形框在原order序列中的索引小1，所以要把这个1加回来
        order = order[inds + 1]
    return keep
 
 
def template(img_gray, template_img, template_threshold):
    '''
    img_gray:待检测的灰度图片格式
    template_img:模板小图，也是灰度化了
    template_threshold:模板匹配的置信度
    '''
 
    h, w = template_img.shape[:2]
    res = cv2.matchTemplate(img_gray, template_img, cv2.TM_CCOEFF_NORMED)
    #start_time = time.time()
    loc = np.where(res >= template_threshold)  # 大于模板阈值的目标坐标
    score = res[res >= template_threshold]  # 大于模板阈值的目标置信度
    # 将模板数据坐标进行处理成左上角、右下角的格式
    xmin = np.array(loc[1])
    ymin = np.array(loc[0])
    xmax = xmin + w
    ymax = ymin + h
    xmin = xmin.reshape(-1, 1)  # 变成n行1列维度
    xmax = xmax.reshape(-1, 1)  # 变成n行1列维度
    ymax = ymax.reshape(-1, 1)  # 变成n行1列维度
    ymin = ymin.reshape(-1, 1)  # 变成n行1列维度
    score = score.reshape(-1, 1)  # 变成n行1列维度
    data_hlist = []
    data_hlist.append(xmin)
    data_hlist.append(ymin)
    data_hlist.append(xmax)
    data_hlist.append(ymax)
    data_hlist.append(score)
    data_hstack = np.hstack(data_hlist)  # 将xmin、ymin、xmax、yamx、scores按照列进行拼接
    thresh = 0.3  # NMS里面的IOU交互比阈值
 
    keep_dets = py_nms(data_hstack, thresh)
    #print("nms time:", time.time() - start_time)  # 打印数据处理到nms运行时间
    dets = data_hstack[keep_dets]  # 最终的nms获得的矩形框
    return dets
 
def get_img():
    # 获取屏幕截图
    # imgLocation = pyautogui.locateOnScreen('out.png')
    # pyautogui.screenshot("sc.png",region=(imgLocation[0],imgLocation[1], imgLocation[2], imgLocation[3]))
    pyautogui.screenshot("sc.png",region=(1226,650, 106, 108))
    # pyautogui.screenshot("sc.png")
    #以灰度加载图片
    img_rgb = cv2.imread("sc.png")
    return img_rgb

def get_imggray(img_rgb):
    img_gray = cv2.cvtColor(img_rgb, cv2.COLOR_BGR2GRAY)
    return img_gray
 
def imgclick(t_img,template_address,shift_x = 0,shift_y = 0,random_number = 20,template_shreshold = 0.8):
    '''
    img待检测图片
    template_address模版图地址
    shift_x横坐标偏移
    shift_y纵坐标偏移0
    random坐标随机数范围-random，random
    template_shreshold模版识别率
    '''
    # 模板相似度
    temp_shreshold = template_shreshold
    img_template = cv2.imread(template_address, 0)
    img_rgb = t_img
    img_gray = get_imggray(img_rgb)
    r = random.uniform(-random_number, random_number)
    tim = random.uniform(0,0.1)
    result = 0
    try:
        dets = template(img_gray, img_template, temp_shreshold)
        for coord in dets:
            #print((int(coord[0])+(int(coord[2])))/2,(int(coord[1])+(int(coord[3])))/2)
            np.any(dets >= 0)
            x = (int(coord[0]) + (int(coord[2]))) / 2
            y = (int(coord[1]) + (int(coord[3]))) / 2
            # X轴偏移加随机
            sx = shift_x + r
            # Y轴偏移加随机
            sy = shift_y + r
            nx = x + sx
            ny = y + sy
            pyautogui.moveTo(nx, ny, tim)
            time.sleep(tim)
            pyautogui.mouseDown(nx, ny)
            time.sleep(tim)
            pyautogui.mouseUp(nx, ny)
            st = template_address.strip('.png').strip('/img')
            print("在", (x,y), "检测到",st,"已点击", ('%.1f' % nx, '%.1f' % ny))
 
            result = 1
            #time.sleep(0.1)
            #识别区画红框
            #cv2.rectangle(img_rgb, (int(coord[0]), int(coord[1])), (int(coord[2]), int(coord[3])), (0, 0, 255), 2)
            #随机取单次结果
            break
        #打开测试窗口
        # cv2.imshow('img_rgb', img_rgb)
        # cv2.waitKey(0)
    except:
        pass
    return result
 
def imgcheck(t_img,template_address,template_shreshold = 0.8):
    '''
    img颜色检测
    img待检测图片
    template_address模版图地址
    template_shreshold模版识别率
    返回BGR值
    '''
    # 模板相似度
    temp_shreshold = template_shreshold
    img_template = cv2.imread(template_address, 0)
    img_rgb = t_img
    img_gray = get_imggray(img_rgb)
    b = 0
    g = 0
    r = 0
    try:
        dets = template(img_gray, img_template, temp_shreshold)
        for coord in dets:
            np.any(dets >= 0)
            x = int((coord[0] + coord[2]) / 2)
            y = int((coord[1] + coord[3]) / 2)
            st = template_address.strip('.png')
            print("在", (x,y), "检测到",st)
            b = img_rgb[y,x,0]
            g = img_rgb[y,x,1]
            r = img_rgb[y,x,2]
            # 随机取单次结果
            break
        #打开测试窗口
        #cv2.imshow('img_rgb', img_rgb)
        #cv2.waitKey(0)
    except:
        pass
    return b,g,r
 
def mouse_position():
    #显示鼠标当前位置坐标
    while True:
        x,y = pyautogui.position()   #获取当前鼠标的位置
        posStr = str(x).rjust(4)+','+str(y).rjust(4)
        print(posStr)
        time.sleep(1)
    
	
def press_button(button_name, time_of_button_press):

    pyautogui.keyDown(button_name)
    time.sleep(time_of_button_press)
    pyautogui.keyUp(button_name)


# time.sleep(10)
window = win32gui.FindWindow(None,"魔兽世界") 
win32gui.SetForegroundWindow(window)

time.sleep(2)
# press_button("s",10)
while True:
    t_i mg = get_img()
    if imgcheck(t_img,'out.png')[0] >= 30:
        print("touch this")
        time.sleep(1)
        press_button("3",.5) # 重置
        time.sleep(1)
        press_button("s",10)
    elif imgcheck(t_img,'logout.png')[0] >= 30:
        print("logout this")
        time.sleep(1)
        press_button("1",.5) #下线
        time.sleep(20)
    elif imgcheck(t_img,'loginss.png')[0] >= 25:
        print("login this")
        # time.sleep(2)
        pyautogui.click(1254, 1276)
        time.sleep(10)
        press_button("4",0.5) #占卜
    elif imgcheck(t_img,'getout.png')[0] >= 30:
        print("getout this")
        time.sleep(2)
        press_button("s",8)
        time.sleep(2)
    elif imgcheck(t_img,'stay.png')[0] >= 30:
        print("stay this")
        time.sleep(2)
        while True:
            press_button("a",0.2)
            time.sleep(random.randint(1,3))
	# press_button("s",0.5)
            press_button("d",0.2)
            time.sleep(2)
            press_button("space",0.5)
            press_button("2",0.5) #在线宏
            time.sleep(2)
        # press_button("s",8)
        # time.sleep(2)
#     time.sleep(1)
# try:
#     imgLocation = pyautogui.locateOnScreen('out.png')
#     print(imgLocation)
#     # x, y = pyautogui.locateCenterOnScreen('2.png')
#     # pyautogui.click(x, y)
# except pyautogui.ImageNotFoundException :
#     print("A TypeError has been occured!")

# while True:

#     time.sleep(5)
#     button7location = pyautogui.locateOnScreen('login.png')
#     button7point = pyautogui.center(button7location)
#     print(button7location[0])
#     button7x, button7y = button7point
#     pyautogui.click(button7x, button7y) 
    # t_img = get_img()
    # if imgcheck(t_img,'img/login.png')[0] == 60:
    #     imgclick(t_img, 'img/login.png')
    #     time.sleep(1)

	# val = random.randint(1,10)
	
	# # pyautogui.press("up")
	# # hold_W(2000)
	# # pyautogui.keyDown("left") 
	# # press_button("left",4)
	# # time.sleep(5)
	# # pyautogui.keyUp("left") 
	# # pyautogui.press("a") 1
	# # press_button("w",0.5)
	# press_button("a",0.2)
	# # press_button("s",0.5)
	# press_button("d",0.2)
	# press_button("space",0.5)
	# press_button("1",0.5)
	# time.sleep(random.randint(1,3))
	# pyautogui.keyDown('alt')
	# time.sleep(.2)
	# pyautogui.press('tab')
	# time.sleep(.2)
	# pyautogui.keyUp('alt')

	# time.sleep(random.randint(5,8))


# while True:
# 	val = random.randint(1,10)
	
# 	# pyautogui.press("up")
# 	# hold_W(2000) 1


# import autotouch
# import time
# def siji():
#     while True:
#         t_img = get_img()
#         autotouch.imgclick(t_img,'img/1.png',109,-37)
#         if autotouch.imgcheck(t_img,'img/2.png')[0] == 60:
#             autotouch.imgclick(t_img, 'img/2.png')
#             time.sleep(1)
#         autotouch.imgclick(t_img,'img/3.png', 1000, 0, 20, 0.9)
#         autotouch.imgclick(t_img, 'img/4.png', 560, 40)
