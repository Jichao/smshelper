export TARGET = iphone:clang:latest:7.0
THEOS_DEVICE_IP = iphone5c
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = imessagehelper
imessagehelper_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MobileSMS"
