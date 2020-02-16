THEOS_DEVICE_IP=192.168.1.55


include $(THEOS)/makefiles/common.mk

SUBPROJECTS += Tweak Prefs

include $(THEOS_MAKE_PATH)/aggregate.mk
