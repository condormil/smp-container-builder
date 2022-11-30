PACKAGECONFIG_append = " \
	iptc \
	myhostname \
	networkd \
	nss \
	nss-mymachines \
	nss-resolve \
	resolved \
"

PACKAGECONFIG_remove = " \
	backlight \
	firstboot \
	hibernate \
	localed \
	logind \
	polkit \
	quotacheck \
	randomseed \	
	timedated \
	timesyncd \	
	utmp \
"

RDEPENDS_${PN}_append = " \
	libnss-myhostname \
	libnss-mymachines \
	libnss-resolve \
	libnss-systemd \
"

pkg_postinst_${PN}_libc-glibc_append () {
	sed -e '/^hosts:/s/\s*\<resolve\>//' \
		-e 's/\(^hosts:.*\)\(\<files\>\)\(.*\)\(\<dns\>\)\(.*\)/\1\2 resolve \3\4\5/' \
		-i $D${sysconfdir}/nsswitch.conf

	sed -e '/^hosts:/s/\s*\<mymachines\>//' \
		-e 's/\(^hosts:.*\)\(\<files\>\)\(.*\)\(\<dns\>\)\(.*\)/\1\2 mymachines \3\4\5/' \
		-i $D${sysconfdir}/nsswitch.conf
}

pkg_prerm_${PN}_libc-glibc_append () {
	sed -e '/^hosts:/s/\s*\<resolve\>//' \
		-e '/^hosts:/s/\s*resolve//' \
		-i $D${sysconfdir}/nsswitch.conf

	sed -e '/^hosts:/s/\s*\<mymachines\>//' \
		-e '/^hosts:/s/\s*mymachines//' \
		-i $D${sysconfdir}/nsswitch.conf
}
