CONVERSIONTYPES_append = " sig"
CONVERSION_CMD_sig = " \
	openssl dgst -sha256 -binary -sign ${SMPC_SIG_KEY} -out ${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.${type}.sig ${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.${type} ; \
"
CONVERSION_DEPENDS_sig = "openssl-native"
