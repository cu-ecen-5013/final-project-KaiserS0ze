#Author: Abhijeet Dutt Srivastava
# Script to build raspberrypi image
#set -e

git submodule init
git submodule sync
git submodule update

source poky/oe-init-build-env

CONFLINE="MACHINE = \"raspberrypi3\""
IMAGE = "IMAGE_FSTYPES=\"tar.bz2 ext3 wic.bz2 wic.bmap rpi-sdimg\""
MEMORY="GPU_MEM = \"16\""

cat conf/local.conf | grep "${CONFLINE}" > /dev/null
local_conf_info=$?

cat conf/local.conf | grep "${IMAGE}" > /dev/null
local_image_info=$?

cat conf/local.conf | grep "${MEMORY}" > /dev/null
local_memory_info=$?

if [ $local_conf_info -ne 0 ];then
	echo "Append ${CONFLINE} in the local.conf file"
	echo ${CONFLINE} >> conf/local.conf	
elif [ $local_image_info -ne 0 ];then 
    echo "Append ${IMAGE} in the local.conf file"
	echo ${IMAGE} >> conf/local.conf
elif [ $local_memory_info -ne 0 ];then
    echo "Append ${MEMORY} in the local.conf file"
	echo ${MEMORY} >> conf/local.conf
else
	echo "${CONFLINE} or ${IMAGE} or ${MEMORY} already exists in the local.conf file"
fi

bitbake-layers show-layers | grep "meta-raspberrypi" > /dev/null
layer_info=$?

if [ $layer_info -ne 0 ];then
	echo "Adding meta-raspberrypi layer"
	bitbake-layers add-layer ../meta-raspberrypi
else
	echo "meta-aesd layer already exists"
fi

set -e
bitbake rpi-basic-image

