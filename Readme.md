AESD Spring 2020 - Group Overview Wiki
https://github.com/cu-ecen-5013/final-project-IMNG7/wiki/Project-Overview

Run build.sh to create image 

Flash sdcard using: 
sudo dd if=PATH/poky/build/tmp/deploy/images/raspberrypi3/rpi-basic-image-raspberrypi3.rpi-sdimg of=/dev/sdx(sdx is address of sdcard) conv=sync bs=1M
