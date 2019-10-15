export THEOS_DEVICE_IP = 192.168.0.152

include /opt/theos/makefiles/common.mk

ARCHS = arm64

TWEAK_NAME = kaixin_xl_pojie
# 开启arc
kaixin_xl_pojie_CFLAGS += -fobjc-arc
kaixin_xl_pojie_FILES = addcfyController/PYSearch/UIView+PYSearchExtension.m addcfyController/PYSearch/UIColor+PYSearchExtension.m addcfyController/PYSearch/PYSearchViewController.m addcfyController/PYSearch/PYSearchSuggestionViewController.m addcfyController/PYSearch/PYSearchConst.m addcfyController/PYSearch/NSBundle+PYSearchExtension.m addcfyController/CFYSearchViewController.m HookSocket.m addcfyController/UIWebViewController.m Tweak.xm ANYMethodLog.m fishhook.c NSArray+Beyond.m  addcfyController/CFYHomePageTableViewCell.m addcfyController/CFYHomePageViewController.m addcfyController/CFYCustomPlayerController.m addcfyController/SDWebImage/*.m addcfyController/ZFFullScreenViewController.m addcfyController/ZFPlayer/ZFAVPlayerManager.m addcfyController/ZFPlayer/ZFPlayerControlView.m addcfyController/ZFPlayer/ZFPlayerController.m addcfyController/ZFPlayer/KSMediaPlayerManager.m addcfyController/ZFPlayer/ZFFloatView.m addcfyController/ZFPlayer/ZFKVOController.m addcfyController/ZFPlayer/ZFLandScapeControlView.m addcfyController/ZFPlayer/ZFOrientationObserver.m addcfyController/ZFPlayer/ZFPlayerGestureControl.m addcfyController/ZFPlayer/ZFPlayerNotification.m addcfyController/ZFPlayer/ZFPlayerView.m addcfyController/ZFPlayer/ZFPlayerView.m addcfyController/ZFPlayer/ZFPortraitControlView.m addcfyController/ZFPlayer/ZFReachabilityManager.m addcfyController/ZFPlayer/ZFSliderView.m addcfyController/ZFPlayer/ZFSmallFloatControlView.m addcfyController/ZFPlayer/ZFSpeedLoadingView.m addcfyController/ZFPlayer/ZFUtilities.m addcfyController/ZFPlayer/ZFVolumeBrightnessView.m addcfyController/ZFPlayer/ZFControlTVScreenView.m addcfyController/ZFPlayer/ZFLoadingView.m addcfyController/ZFPlayer/ZFNetworkSpeedMonitor.m addcfyController/ZFPlayer/ZFTVScreenView.m addcfyController/ZFPlayer/ZFPlayerLogManager.m addcfyController/ZFPlayer/UIScrollView+ZFPlayer.m addcfyController/ZFPlayer/UIView+ZFFrame.m addcfyController/ZFPlayer/UIImageView+ZFCache.m          



#需要用到的框架
kaixin_xl_pojie_FRAMEWORKS = UIKit Foundation CoreGraphics AVFoundation QuartzCore OpenGLES CoreMedia CoreVideo MediaPlayer AVKit AudioToolbox VideoToolbox MobileCoreServices

kaixin_xl_pojie_LDFLAGS += -lz -lc++ -lbz2

kaixin_xl_pojie_LDFLAGS += -std=gnu99 -std=gnu++98
kaixin_xl_pojie_LDFLAGS += -all_load -licucore

#显示webp格式的图片 libSDWebImage+WebP.a

#忽略OC警告，避免警告导致编译不过
kaixin_xl_pojie_OBJCFLAGS += -Wno-deprecated-declarations -Wno-unused-variable -Wno-incomplete-implementation -Wno-undeclared-selector -Wno-format -Wno-deprecated-declarations -Wno-unreachable-code -Wno-missing-braces -Wno-unused-property-ivar -Wno-#warnings
 

include /opt/theos/makefiles/tweak.mk

after-install::
	install.exec "killall -9 iThunder"
