SUMMARY ?= "Sample container package"
LICENSE = "CLOSED"

inherit image_smpc

IMAGE_INSTALL = " \
 	${BPN}-container \
"
