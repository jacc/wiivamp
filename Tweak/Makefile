ARCHS = arm64 arm64e
TARGET = iphone:clang:13.2:13.2

GO_EASY_ON_ME = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Wiivamp
$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_FRAMEWORKS = UIKit Foundation AVFoundation
$(TWEAK_NAME)_EXTRA_FRAMEWORKS += Cephei
$(TWEAK_NAME)_LIBRARIES = sparkapplist

include $(THEOS_MAKE_PATH)/tweak.mk