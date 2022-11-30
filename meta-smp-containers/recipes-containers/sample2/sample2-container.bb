SUMMARY = "install test-container-image-helloworld as package"
LICENSE = "CLOSED"

FILESEXTRAPATHS_prepend = "${THISDIR}/${BPN}:"

CONTAINER_NAME = "sample2"

SRC_URI = " \
	file://firewall-rules.sh \
	file://settings.nspawn \
	file://service.conf \
	file://smp-log.conf \
	file://ve.network \
"

DEPENDS += " \
	${PN}-image \
"

EXCLUDE_FROM_SHLIBS = "1"
INHIBIT_DEFAULT_DEPS = "1"
SKIP_FILEDEPS = "1"
REPRODUCIBLE_TIMESTAMP_ROOTFS = ""

do_copy_images() {
	install -m 0644 ${DEPLOY_DIR_IMAGE}/${BPN}-image-${MACHINE}.squashfs ${WORKDIR}/${CONTAINER_NAME}.squashfs 
}

do_copy_images[depends] += " ${PN}-image:do_image_complete"
do_install[depends] += "${PN}:do_copy_images"

addtask do_copy_images before do_install

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
	echo todo
	install -d ${D}${datadir}/machines/
	install -m 0644 ${WORKDIR}/${CONTAINER_NAME}.squashfs  ${D}${datadir}/machines/${CONTAINER_NAME}.squashfs

	install -m 0700 -d ${D}${sysconfdir}/firewall.d/
	install -m 0700 ${WORKDIR}/firewall-rules.sh ${D}${sysconfdir}/firewall.d/50-${BPN}.sh

	install -d ${D}${sysconfdir}/smp-log/definitions
	install -m 0644 ${WORKDIR}/smp-log.conf ${D}${sysconfdir}/smp-log/definitions/60-${BPN}.conf
	
	install -d ${D}${sysconfdir}/systemd/network
	install -m 0644 ${WORKDIR}/ve.network ${D}${sysconfdir}/systemd/network/50-${CONTAINER_NAME}.network

	install -d ${D}${sysconfdir}/systemd/nspawn
	install -m 0644 ${WORKDIR}/settings.nspawn ${D}${sysconfdir}/systemd/nspawn/${CONTAINER_NAME}.nspawn

	install -d ${D}${sysconfdir}/systemd/system/systemd-nspawn@${CONTAINER_NAME}.service.d/
	install -m 0644 ${WORKDIR}/service.conf ${D}${sysconfdir}/systemd/system/systemd-nspawn@${CONTAINER_NAME}.service.d/service.conf

	install -d ${D}${sysconfdir}/systemd/system/machines.target.wants
	ln -s ${systemd_system_unitdir}/systemd-nspawn@.service ${D}${sysconfdir}/systemd/system/machines.target.wants/systemd-nspawn@${CONTAINER_NAME}.service
}

FILES_${PN}_append = " \
	${sysconfdir}/firewall.d/50-${BPN}.sh \
	${sysconfdir}/systemd/nspawn/${CONTAINER_NAME}.nspawn \	
	${sysconfdir}/systemd/system/machines.target.wants/systemd-nspawn@${CONTAINER_NAME}.service \
	${sysconfdir}/systemd/system/systemd-nspawn@${CONTAINER_NAME}.service.d/service.conf \
	${datadir}/machines/${CONTAINER_NAME}.squashfs \
"

ALLOW_EMPTY_${PN} = "1"
