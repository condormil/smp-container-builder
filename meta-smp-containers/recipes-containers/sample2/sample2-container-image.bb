SUMMARY = "A minimal test container image"
LICENSE = "CLOSED"

inherit image image-container

PREFERRED_PROVIDER_virtual/kernel = "linux-dummy"
IMAGE_FSTYPES = "container"
IMAGE_TYPEDEP_container = "squashfs"

IMAGE_BOOT_FILES = ""
IMAGE_LINGUAS = "en-us"
IMAGE_NAME_SUFFIX = ""
IMAGE_FEATURES = " \
	read-only-rootfs \	
	empty-root-password \
	allow-empty-password \
	allow-root-login \
"

NO_RECOMMENDATIONS = "1"
PREFERRED_PROVIDER_virtual/kernel = "linux-dummy"

IMAGE_INSTALL_remove = " \
	kernel-image \
	kernel-devicetree \
"

IMAGE_INSTALL_append += " \
	bash \
	coreutils \
	inetutils \
	inetutils-ifconfig \
	inetutils-ping \
	inetutils-telnet \
	iproute2 \
	net-tools \
	netbase \
	nginx \
	os-release \
	systemd \
	systemd-conf \
	systemd-initramfs \
"

CORE_IMAGE_EXTRA_INSTALL_append = " \
	packagegroup-self-hosted-sdk \
	packagegroup-self-hosted-extended \
"
