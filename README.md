# ThunderHook
thunder修改业务逻辑

##addcfyController

### category
保护数组和字典的安全相关的类

### PYSearch
一款不错的搜索控制器
   
    https://github.com/ko1o/PYSearch

### ZFPlayer
一款开源的播放器

    https://github.com/renzifeng/ZFPlayer

## ANYMethodLog
日志输出工具类，详细的使用方法参考一下链接

    https://github.com/qhd/ANYMethodLog

## fishhook
fishhook可以在模拟器和设备上的iOS上运行的Mach-O二进制文件中动态重新绑定符号
   
    https://github.com/facebook/fishhook

## HookSocket
基于fishhook去hook底层socket的相关方法，对底层不熟悉，先记录下，后续再分析

## layout
存放tweak中引用的图片

	tweak文件中引用图片
	#define CFYFile(path) @"/Library/PreferenceLoader/Preferences/cfyxunlei/" #path

## Makefile
编译的相关配置

    设备的IP地址
    export THEOS_DEVICE_IP = 192.168.0.152
    
    适配的设备架构
    ARCHS = arm64
    
    开启ARC
    kaixin_xl_pojie_CFLAGS += -fobjc-arc
    
    添加编译的文件
    kaixin_xl_pojie_FILES
    
    需要用到的框架
    kaixin_xl_pojie_FRAMEWORKS
    
    静态库的设置
    kaixin_xl_pojie_LDFLAGS
    
    #忽略OC警告，避免警告导致编译不过
    kaixin_xl_pojie_OBJCFLAGS
    

## Tweak.xm
tweak代码的编写，也可拆分为多个文件，这里是hook业务逻辑编写的地方

## 思路或者遇到的问题




