//
//  ZFFullScreenViewController.m
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2018/8/29.
//  Copyright © 2018年 紫枫. All rights reserved.
//

#import "ZFFullScreenViewController.h"
#import "ZFPlayer/ZFPlayer.h"
#import "ZFPlayer/ZFAVPlayerManager.h"
#import "ZFPlayer/ZFIJKPlayerManager.h"
#import "ZFPlayer/KSMediaPlayerManager.h"
#import "ZFPlayer/ZFPlayerControlView.h"
#import "ZFPlayer/ZFPlayerController.h"
#import <WebKit/WebKit.h>

static NSString *kVideoCover = @"https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";

#define CFYFile(path) @"/Library/PreferenceLoader/Preferences/cfyxunlei/" #path

@interface ZFFullScreenViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) ZFPlayerControlView *controlView;

@property (nonatomic, strong) UIWebView *myWebView;
@property (nonatomic, strong) NSString *onlinePlayUrl;

@property (nonatomic, assign) int refreshDetailNumber;
@property (nonatomic, assign) int refreshPlayerNumber;
@end

@implementation ZFFullScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.refreshDetailNumber = 0;
//    self.refreshPlayerNumber = 0;
//
//    NSLog(@"cfy------test-----%@",@"ZFPlayerControlView");
//
//    NSLog(@"cfy------test-----%@",@"ZFPlayerControlView");
//
//    UIWebView *webView =  [[UIWebView alloc] initWithFrame:CGRectMake(0,64,self.view.frame.size.width,self.view.frame.size.height-64)];
//
//
//    NSString *origin = @"https://www.yunbtv.com/vodsearch/-------------.html?wd=死侍2";
//    origin =  [origin stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:origin]];//https://www.yunbtv.com/vodsearch/-------------.html?wd=死侍2
//    [webView loadRequest:request];
//    webView.delegate = self; //记得遵循代理 UIWebViewDelegate
//    [self.view addSubview:webView];
//    self.myWebView = webView;
    
    [self playerConfig];
    
}

- (void)playerConfig{
    
    self.view.backgroundColor = [UIColor whiteColor];
    @weakify(self)
    self.controlView.backBtnClickCallback = ^{
        @strongify(self)
        [self.player enterFullScreen:NO animated:NO];
        [self.player stop];
        [self.navigationController popViewControllerAnimated:NO];
    };
    
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    /// 播放器相关
    self.player = [[ZFPlayerController alloc] initWithPlayerManager:playerManager containerView:[UIApplication sharedApplication].keyWindow];
    self.player.controlView = self.controlView;
    self.player.orientationObserver.supportInterfaceOrientation = ZFInterfaceOrientationMaskLandscape;
    [self.player enterFullScreen:YES animated:NO];
    playerManager.assetURL = [NSURL URLWithString:@"http://youku.com-www-163.com/20180506/576_bf997390/index.m3u8"];
    
    // http://youku.com-www-163.com/20180506/576_bf997390/index.m3u8
    
    // https://iqiyi.com-l-iqiyi.com/20190125/21294_36849822/index.m3u8
    
    // https://hls.ted.com/talks/2639.m3u8?preroll=Thousands
}


#pragma mark - UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"网页加载完成才能获取---%@",webView.request.URL);
    
    NSString *webViewUrl = [NSString stringWithFormat:@"%@",webView.request.URL];
    
    
    self.refreshDetailNumber++;
    self.refreshPlayerNumber++;
    
    NSLog(@"cfy---这个是详细页面的加载次数----%ld",self.refreshDetailNumber);
    NSLog(@"cfy---这个是播放页面的加载次数%ld",self.refreshPlayerNumber);
    
    //
    //    NSString *doc     = @"document.body.outerHTML";
    //    NSString *htmlStr = [webView stringByEvaluatingJavaScriptFromString:doc];
    //    NSLog(@"cfy---这个是第二种方法-%@",htmlStr);
    
    if ([webViewUrl containsString:@"vodsearch"] && self.refreshDetailNumber == 1) {
        //获取当前的视频元素的a标签的herf
        NSString *hrefJS     = @"document.getElementsByClassName('media-wrapper')[0].getElementsByTagName('a')[0].pathname";
        NSString *hrefStr = [webView stringByEvaluatingJavaScriptFromString:hrefJS];
        NSLog(@"cfy---这个是获取a标签的href--%@",hrefStr);
        //  /voddetail/sishi2woaiwojia.html
        
        if ([hrefStr containsString:@"voddetail"]) {
            //这里表示进入的是详情页面
            //        NSString *detailStr = [NSString stringWithFormat:@"https://www.yunbtv.com%@",hrefStr];
            
            //https://www.yunbtv.com/vodplay/sishi2woaiwojia-1-1.html
            NSString *playStr = [NSString stringWithFormat:@"%@",@"https://www.yunbtv.com/vodplay/sishi2woaiwojia-1-1.html"];
            
            //这里拿到这个地址以后，再次请求详情页面获取下一个播放页面的a标签
            NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:playStr]];
            [self.myWebView loadRequest:request];
        }
    }
    
    
    if ([webViewUrl containsString:@"vodplay"] && self.refreshPlayerNumber == 12) {
        //获取播放页面的播放地址
        NSString *playUrlJS     = @"document.getElementsByClassName('MacPlayer')[0].getElementsByTagName('table')[0].getElementsByTagName('td')[0].getElementsByTagName('iframe')[0].src";
        NSString *playUrlStr = [webView stringByEvaluatingJavaScriptFromString:playUrlJS];
        NSLog(@"cfy---这个是播放页面的播放地址--%@",playUrlStr); // https://player.yunbtv.com/m3u8/index.php?url=https://iqiyi.com-l-iqiyi.com/20190125/21294_36849822/index.m3u8
        
        self.onlinePlayUrl = [playUrlStr componentsSeparatedByString:@"?url="][1];
        
        [self playerConfig];
    }
    
}


//这里当前的页面销毁的时候，要将这个webView也释放掉
-(void)dealloc{
    [self.myWebView removeFromSuperview];
    self.myWebView = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.player.viewControllerDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.player.viewControllerDisappear = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
        _controlView.effectViewShow = NO;
        _controlView.prepareShowLoading = YES;
    }
    return _controlView;
}

@end
