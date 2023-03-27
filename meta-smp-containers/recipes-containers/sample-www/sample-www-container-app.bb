SUMMARY = "Simple tcp server application and Sample WWW page"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

FILESEXTRAPATHS_prepend = "${THISDIR}/${BPN}:"

SRC_URI = " \
            file://host0.network \
            file://tcp-server-app.c \
            file://httprequest.js \
            file://index.html \  
            file://nginx-server.conf \
            "
S = "${WORKDIR}"

do_compile() {
         ${CC} tcp-server-app.c  -o tcp-server-app ${LDFLAGS}
}

do_configure() {
	touch ${WORKDIR}/enable-by-default
	touch ${WORKDIR}/use-last-parameters
}

do_install() {
        install -d ${D}/var/www
	    install -m 0644 ${WORKDIR}/index.html  ${D}/var/www/index.html
        
        install -d ${D}${sysconfdir}/nginx/sites-available
	    install -m 0644 ${WORKDIR}/nginx-server.conf 	${D}${sysconfdir}/nginx/sites-available/sample-www.conf

        install -d ${D}${sysconfdir}/nginx/sites-enabled
        ln -sf ../sites-available/sample-www.conf       ${D}${sysconfdir}/nginx/sites-enabled/sample-www.conf


        install -d ${D}${bindir}
        install -m 0755 tcp-server-app ${D}${bindir}

        install -d ${D}${sysconfdir}/systemd/network
	    install -m 0644 ${WORKDIR}/host0.network ${D}${sysconfdir}/systemd/network/50-host0.network

        install -d ${D}${prefix}/njserver/
        install -m 0755 ${WORKDIR}/httprequest.js ${D}${prefix}/njserver/
}

FILES_${PN} += " \
		${bindir} \
        ${prefix}/njserver/ \
        \
        /var/www/ \
        ${sysconfdir}/nginx/sites-available \
        ${sysconfdir}/nginx/sites-enabled \
        ${sysconfdir}/systemd/network \
"
RDEPENDS_${PN} += "nodejs"
