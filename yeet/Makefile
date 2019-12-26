ARCHS = arm64 arm64e
TARGET = iphone:clang:11.2:11.2

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = WiiVampPref
WiiVampPref_FILES = XXXRootListController.m
WiiVampPref_INSTALL_PATH = /Library/PreferenceBundles
WiiVampPref_FRAMEWORKS = UIKit
WiiVampPref_PRIVATE_FRAMEWORKS = Preferences
WiiVampPref_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
WiiVampPref_LIBRARIES = sparkapplist

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/yeet.plist$(ECHO_END)
