ARCHS = arm64e arm64
TARGET = iphone:clang:13.2:13.2

GO_EASY_ON_ME = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Wiivamp
Wiivamp_FILES = Wiivamp.xm
Wiivamp_FRAMEWORKS = UIKit
Wiivamp_LIBRARIES = sparkapplist
Wiivamp_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += yeet
include $(THEOS_MAKE_PATH)/aggregate.mk

