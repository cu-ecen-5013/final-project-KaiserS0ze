SUMMARY = "opencv based application"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "git://git@github.com/cu-ecen-5013/final-project-IMNG7.git;protocol=ssh;branch=master"

PV = "1.0+git${SRCPV}"
SRCREV = "e646335b0de38bc9830305e10d1d12d3d3351f58"

S = "${WORKDIR}/git"

FILES_${PN} += "${bindir}/pythonscript"

do_install () {
	install -d ${D}${bindir}
	install -m 0755 ${S}/people_detection.py ${D}${bindir}/
    install -m 0755 ${S}/MobileNetSSD_deploy.caffemodel ${D}${bindir}/
    install -m 0755 ${S}/MobileNetSSD_deploy.prototxt ${D}${bindir}/
}
