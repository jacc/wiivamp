include $(THEOS)/makefiles/common.mk
export DEBUG = 0
export FOR_RELEASE = 1
export FINALPACKAGE = 1
export TARGET = iphone:12.1.2:11.0

TWEAK_NAME = Wiivamp
Wiivamp_FILES = Tweak.xm
Wiivamp_LIBRARIES = sparkapplist
Wiivamp_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += yeet
include $(THEOS_MAKE_PATH)/aggregate.mk


