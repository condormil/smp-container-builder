FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
	file://aliases.sh \
	file://profile.sh \
"
dirs755 += " ${sysconfdir}/profile.d"

dirs755_remove = "${localstatedir}/volatile/log"
volatiles_remove = "log"

do_install_append () {

	echo "${DISTRO_NAME} READY" > "${D}${sysconfdir}/motd"

	install -d ${D}${sysconfdir}/profile.d/
	install -m 0755 ${WORKDIR}/aliases.sh ${D}${sysconfdir}/profile.d/aliases.sh
	install -m 0755 ${WORKDIR}/profile.sh ${D}${sysconfdir}/profile.d/profile.sh
}
