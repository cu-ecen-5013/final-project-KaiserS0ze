
SUMMARY = "IMAGE TRANSFER USING MQTT"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "git://git@github.com/cu-ecen-5013/final-project-KaiserS0ze.git;protocol=ssh;branch=master"
PV = "1.0+git${SRCPV}"
SRCREV = "b4c0230e5f95a01f7c7988cf83fa160fce732ee6"

S = "${WORKDIR}/git"

FILES_${PN} += "${bindir}/pythonscript"

do_install () {
	install -d ${D}${bindir}
	install -m 0755 ${S}/pub.py ${D}${bindir}/
}
