#Author: Abhijeet Dutt Srivastava
# Script to build raspberrypi image

#!/bin/sh

git submodule init
git submodule sync
git submodule update

source poky/oe-init-build-env

#Set machine as Raspberry Pi 3
CONFLINE="MACHINE = \" raspberrypi3 \""
#Create image of the type rpi-sdimg
IMAGE="IMAGE_FSTYPES= \" tar.bz2 ext3 wic.bz2 wic.bmap rpi-sdimg \""
#Set GPU memory as minimum
MEMORY="GPU_MEM = \" 16 \""
#Add any packages needed here
ADD_PACK="CORE_IMAGE_EXTRA_INSTALL += \" opencv libopencv-core-dev libopencv-highgui-dev libopencv-imgproc-dev libopencv-objdetect-dev libopencv-ml-dev opencv-dev opencv-apps mosquitto \""
#Add wifi support
DISTRO_F="DISTRO_FEATURES_append = \" bluez5 bluetooth wifi \""
#add firmware support 
IMAGE_ADD="IMAGE_INSTALL_append = \" linux-firmware-bcm43430 kernel-module-brcmfmac bluez5 i2c-tools bridge-utils hostapd dhcp-server networkmanager iptables wpa-supplicant \""			      

cat conf/local.conf | grep "${CONFLINE}" > /dev/null
local_conf_info=$?

cat conf/local.conf | grep "${IMAGE}" > /dev/null
local_image_info=$?

cat conf/local.conf | grep "${MEMORY}" > /dev/null
local_memory_info=$?

cat conf/local.conf | grep "${ADD_PACK}" > /dev/null
local_pack_info=$?

cat conf/local.conf | grep "${DISTRO_F}" > /dev/null
local_distro_info=$?

cat conf/local.conf | grep "${IMAGE_ADD}" > /dev/null
local_imgadd_info=$?

if [ $local_conf_info -ne 0 ];then
	echo "Append ${CONFLINE} in the local.conf file"
	echo ${CONFLINE} >> conf/local.conf	
else
	echo "${CONFLINE} already exists in the local.conf file"
fi

if [ $local_image_info -ne 0 ];then 
    echo "Append ${IMAGE} in the local.conf file"
	echo ${IMAGE} >> conf/local.conf
else
	echo "${IMAGE} already exists in the local.conf file"
fi

if [ $local_memory_info -ne 0 ];then
    echo "Append ${MEMORY} in the local.conf file"
	echo ${MEMORY} >> conf/local.conf
else
	echo "${MEMORY} already exists in the local.conf file"
fi


if [ $local_pack_info -ne 0 ];then
    echo "Append ${ADD_PACK} in the local.conf file"
	echo ${ADD_PACK} >> conf/local.conf
else
	echo "${ADD_PACK} already exists in the local.conf file"
fi


if [ $local_distro_info -ne 0 ];then
    echo "Append ${DISTRO_F} in the local.conf file"
	echo ${DISTRO_F} >> conf/local.conf
else
	echo "${DISTRO_F} already exists in the local.conf file"
fi

if [ $local_imgadd_info -ne 0 ];then
    echo "Append ${IMAGE_ADD} in the local.conf file"
	echo ${IMAGE_ADD} >> conf/local.conf
else
	echo "${IMAGE_ADD} already exists in the local.conf file"
fi

#Check for layers in bb file
bitbake-layers show-layers | grep "meta-raspberrypi" > /dev/null
layer_info=$?

bitbake-layers show-layers | grep "meta-python" > /dev/null
layer_python_info=$?

bitbake-layers show-layers | grep "meta-oe" > /dev/null
layer_metaoe_info=$?

bitbake-layers show-layers | grep "meta-networking" > /dev/null
layer_networking_info=$?

#bitbake layers needed 
if [ $layer_info -ne 0 ];then
	echo "Adding meta-raspberrypi layer"
	bitbake-layers add-layer ../meta-raspberrypi
else
	echo "layer meta-raspberrypi already exists"
fi


if [ layer_python_info -ne 0 ];then
    echo "Adding meta-python layer"
	bitbake-layers add-layer ../meta-openembedded/meta-python
else
	echo "layer meta-python already exists"
fi


if [ layer_metaoe_info -ne 0 ];then
    echo "Adding meta-oe layer"
	bitbake-layers add-layer ../meta-openembedded/meta-oe
else
	echo "layer meta-oe already exists"
fi

if [ layer_networking_info -ne 0 ];then
    echo "Adding meta-networking layer"
	bitbake-layers add-layer ../meta-openembedded/meta-networking
else
	echo "layer meta-networking already exists"
fi

set -e
bitbake core-image-base

