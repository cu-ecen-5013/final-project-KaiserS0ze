import datetime
import time
import cv2
import math
from imutils.video import VideoStream 
import paho.mqtt.publish as publish

MQTT_SERVER = "10.0.0.47"  #Write Server IP Address
MQTT_PATH = "Image"

cap = VideoStream(src=0).start()
x = datetime.datetime.now().replace(microsecond=0)
print("X : ",x)
n = 0;
flag = 0

while True:
	five=x + datetime.timedelta(0,5)
	current_time=datetime.datetime.now().replace(microsecond=0)
	if current_time==five:
		if flag==1:
			flag = 0
			print("MQTT send file")
			sendfile = "picture" + str(int(n)) + ".jpg" 
			print(sendfile)
			f=open(sendfile, "rb") #3.7kiB in same folder
			fileContent = f.read()
			byteArr = bytearray(fileContent)
			publish.single(MQTT_PATH, byteArr, hostname=MQTT_SERVER)
		n = n + 1
		time.sleep(2)
		x=datetime.datetime.now().replace(microsecond=0)
	else:
		if flag==0:
			print("Take photo")
			frame = cap.read()
			filename = "picture" + str(int(n)) + ".jpg"
			print(filename)
			cv2.imwrite(filename,frame)
			flag = 1
cap.release()