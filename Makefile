export TARGET = appletv
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WiivampTV
WiivampTV_FILES = WiivampTV.xm

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 PineBoard"

clean::
	@rm -f packages/*.deb
