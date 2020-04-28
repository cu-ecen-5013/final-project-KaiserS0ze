#script to startup imagesend.py at boottime 
#Abhijeet Dutt Srivastava
#!/bin/sh

ifup wlan0 
ntpd -bq
pip3 install --upgrade imutils
python3 /usr/bin/imagesend.py