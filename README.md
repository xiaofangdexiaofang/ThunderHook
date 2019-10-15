# ThunderHook
thunder修改业务逻辑

##addcfyController

### category
保护数组和字典的安全相关的类,在开发的过程中发现迅雷自身的代码未做处理，故添加分类放置崩溃

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
	
## ZJHURLProtocol
监控http层面的网络请求

    https://github.com/ZhangJingHao/ZJHURLProtocol

## Makefile
编译的相关配置，这里很多的设置都是根据编译出错的信息去解决掉的

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

    AppDelegate（监控网络请求和日志打印）
    - (BOOL)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2;

    TDDownloadListViewCell (添加云播按钮和获取当前资源的下载链接发送通知)
    - (void)refreshUI:(id)arg1;
    - (void)updateUI:(id)arg1;
    - (void)onVipBtnClick:(id)arg1;

    CFYHomePageViewController（点击cell创建下载任务）
    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

    TDSlideDownloadListVC (接受通知获取下载链接跳转到自定义播放器的页面)
    -(void)getClickYBBtnNotification:(NSNotification *) notification;
    
    XL_TabBarController (添加最新电影的页面)
    - (void)viewDidAppear:(BOOL)animated;
    

## 未解决的问题

 * 找到点击下载的按钮，也通过lldb动态调试了下载的过程，打印分析了寄存器和内存中的值，但是找不到想要的东西（如何让敏感资源也能下载）
 * 通过wireshark抓取到下载过程中的协议传输过程，看到大概过程是通过TCP建立连接，然后通过UDP去传输对应的数据，但是数据是乱码和加密，暂时也没有好的方法解决
 





