export ARCHS = arm64
export TARGET = appletv:clang:11.3:11.3
export SYSROOT = $(THEOS)/sdks/AppleTVOS11.3.sdk
export THEOS_DEVICE_IP=192.168.1.137
export FINALPACKAGE = 1
export DEBUG = 0
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WiivampTV
WiivampTV_FILES = WiivampTV.xm
WiivampTV_CFLAGS = -fobjc-arc
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 PineBoard"

clean::
	@rm -f packages/*.deb
