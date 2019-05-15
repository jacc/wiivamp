FINALPACKAGE = 1
GO_EASY_ON_ME = 0
export ARCHS = arm64e arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Wiivamp
Wiivamp_FILES = Tweak.xm
Wiivamp_LIBRARIES = sparkapplist
Wiivamp_CFLAGS = -fobjc-arc
Wiivamp_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += yeet
include $(THEOS_MAKE_PATH)/aggregate.mk


