IMAGE_TYPES_append = " smpc"
IMAGE_CMD_smpc = "mksquashfs ${IMAGE_ROOTFS} ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.smpc ${EXTRA_IMAGECMD} -noappend"

do_image_smpc[depends] += "squashfs-tools-native:do_populate_sysroot"
