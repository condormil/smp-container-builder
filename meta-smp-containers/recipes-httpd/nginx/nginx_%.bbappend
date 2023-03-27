FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append += " \
	git://github.com/openresty/headers-more-nginx-module.git;protocol=https;nobranch=1;name=headers-more;destsuffix=headers-more \
	file://http-headers.conf \
	file://gzip.conf \
	file://log.conf \
	file://basic.conf \
	file://nginx.conf \
"

SRCREV_headers-more = "55fbdaba96be3d4e534201232f6b555f3415fbb9"

inherit systemd

PACKAGECONFIG += " \
	http-auth-request \
	http2 \
	ssl \
"
EXTRA_OECONF += " \
		--with-http_sub_module \
		--with-http_gunzip_module \
		--with-threads \	
		--add-module=${WORKDIR}/headers-more \
		--with-cc-opt="-I${STAGING_INCDIR} -L${STAGING_LIBDIR}" \
	"

do_install_append() {

	install -d ${D}${sysconfdir}/nginx
	install -m 0644 ${WORKDIR}/nginx.conf ${D}${sysconfdir}/nginx/

	install -d ${D}${sysconfdir}/nginx/conf.d/
	install -m 0644 ${WORKDIR}/gzip.conf ${D}${sysconfdir}/nginx/conf.d/50-gzip.conf
	install -m 0644 ${WORKDIR}/log.conf ${D}${sysconfdir}/nginx/conf.d/50-log.conf
	install -m 0644 ${WORKDIR}/http-headers.conf ${D}${sysconfdir}/nginx/conf.d/50-http-headers.conf
	install -m 0644 ${WORKDIR}/basic.conf ${D}${sysconfdir}/nginx/conf.d/50-basic.conf

	install -d ${D}${sysconfdir}/nginx/sites-available
	rm -f ${D}${sysconfdir}/nginx/sites-available/default_server

	install -d ${D}${sysconfdir}/nginx/sites-enabled
	rm -f ${D}${sysconfdir}/nginx/sites-enabled/default_server
	
	# Add the asp mime type.
	sed -i -e 's/html htm shtml;/html htm shtml asp;/g' 	${D}${sysconfdir}/nginx/mime.types
}

SYSTEMD_SERVICE_${PN} += " \
"

FILES_${PN} += " \
	${sysconfdir}/nginx \
	${sysconfdir}/nginx/conf.d \
	${sysconfdir}/nginx/sites-available \
	${sysconfdir}/nginx/sites-enabled \
"

# USERADD_PARAM_${PN} = " \
#     --system --no-create-home \
#     --home ${NGINX_WWWDIR} \
#     --groups www-data \
#     --user-group ${NGINX_USER}; \
# "
