IMAGE_CLASSES_append = " \
	image_type_smpc \
	image_conversion_sig \
"

IMAGE_FSTYPES = " \
	smpc \
	smpc.sig \
"
IMAGE_TYPEDEP_container = "smpc"

inherit image

NO_RECOMMENDATIONS = "1"
PREFERRED_PROVIDER_virtual/kernel = ""

ROOTFS_BOOTSTRAP_INSTALL = ""
EXCLUDE_FROM_SHLIBS = "1"
SKIP_FILEDEPS = "1"
INHIBIT_DEFAULT_DEPS = "1"

IMAGE_CONTAINER_NO_DUMMY = "1"
IMAGE_BOOT_FILES = ""
IMAGE_BUILDINFO_FILE = ""
IMAGE_LINGUAS = ""
IMAGE_NAME_SUFFIX = ""
IMAGE_FEATURES = " \
	read-only-rootfs \
	stateless-rootfs \
"

IMAGE_INSTALL_remove = " \
	kernel-image \
	kernel-devicetree \
"

LDCONFIGDEPEND = ""
REPRODUCIBLE_TIMESTAMP_ROOTFS = ""
COPY_LIC_MANIFEST = "0"

ROOTFS_POSTPROCESS_COMMAND = ""

rootfs_smpc_cleanup() {
	rm -f ${IMAGE_ROOTFS}/${sysconfdir}/version

	# Remove empty directories
	find ${IMAGE_ROOTFS} -type d -empty -delete
}

python do_rootfs_append() {
    from oe.utils import execute_pre_post_process
    execute_pre_post_process(d, "rootfs_smpc_cleanup")
}
