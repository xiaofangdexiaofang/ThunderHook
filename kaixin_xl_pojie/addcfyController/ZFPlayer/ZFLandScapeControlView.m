//
//  ZFLandScapeControlView.m
//  ZFPlayer
//
// Copyright (c) 2016年 任子丰 ( http://github.com/renzifeng )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ZFLandScapeControlView.h"
#import "UIView+ZFFrame.h"
#import "ZFUtilities.h"
#import "ZFPlayer.h"
#import "ZFTVScreenView.h"
#import "ZFControlTVScreenView.h"

#define DefaultTryCount 3

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

#define CFYFile(path) @"/Library/PreferenceLoader/Preferences/cfyxunlei/ZFPlayer/" #path

@interface ZFLandScapeControlView () <ZFSliderViewDelegate,ZFTVScreenViewDelegate>
/// 顶部工具栏
@property (nonatomic, strong) UIView *topToolView;
/// 返回按钮
@property (nonatomic, strong) UIButton *backBtn;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 底部工具栏
@property (nonatomic, strong) UIView *bottomToolView;
/// 播放或暂停按钮
@property (nonatomic, strong) UIButton *playOrPauseBtn;
/// 播放的当前时间 
@property (nonatomic, strong) UILabel *currentTimeLabel;
/// 滑杆
@property (nonatomic, strong) ZFSliderView *slider;
/// 视频总时间
@property (nonatomic, strong) UILabel *totalTimeLabel;
/// 锁定屏幕按钮
@property (nonatomic, strong) UIButton *lockBtn;
/// 投屏按钮
@property (nonatomic, strong) UIButton *tvScreenBtn;
/// 缩小播放屏幕按钮
@property (nonatomic, strong) UIButton *minifyBtn;
/// MRDLNA投屏实例
//@property (nonatomic, strong) MRDLNA *dlnaManager;
/// 乐播投屏的搜索实例
//@property (nonatomic, strong) LBLelinkBrowser *lelinkBrowser;
/////乐播投屏的链接实例
//@property (nonatomic, strong) LBLelinkConnection *lelinkConnection;
//// 乐播投频的实例化播放器
//@property (nonatomic, strong) LBLelinkPlayer * lelinkPlayer;
/// 当前搜寻到设备的数组
@property (nonatomic, strong) NSMutableArray *services;
/// 查找当前的投屏电视的View
@property (nonatomic, strong) ZFTVScreenView *tvScreenView;
/// 控制投屏设备的View
@property (nonatomic, strong) ZFControlTVScreenView *controlTVScreenView;
/// 尝试开启的次数
@property (nonatomic, assign) NSInteger tryTestNum;

@property (nonatomic, assign) BOOL isShow;

@end

@implementation ZFLandScapeControlView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.controlTVScreenView];
        self.controlTVScreenView.hidden = YES;
        
        [self addSubview:self.topToolView];
        [self.topToolView addSubview:self.backBtn];
        [self.topToolView addSubview:self.titleLabel];
        [self addSubview:self.bottomToolView];
        [self.bottomToolView addSubview:self.playOrPauseBtn];
        [self.bottomToolView addSubview:self.currentTimeLabel];
        
        [self.bottomToolView addSubview:self.slider];
        [self.bottomToolView addSubview:self.totalTimeLabel];
        [self.bottomToolView addSubview:self.tvScreenBtn];
        [self.bottomToolView addSubview:self.minifyBtn];
        [self addSubview:self.lockBtn];
        
        [self addSubview:self.tvScreenView];
        self.tvScreenView.hidden = YES;
        
        // 设置子控件的响应事件
        [self makeSubViewsAction];
        [self resetControlView];
        
        //搜索电视TV的设置
        [self addTVScreenSetting];
        
        /// statusBarFrame changed
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layOutControllerViews) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    CGFloat min_view_w = self.bounds.size.width;
    CGFloat min_view_h = self.bounds.size.height;

    
    min_x = 0;
    min_y = 0;
    min_w = min_view_w;
    min_h = min_view_h;
    self.controlTVScreenView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = 0;
    min_y = 0;
    min_w = min_view_w;
    min_h = iPhoneX ? 74 : 44;
    self.topToolView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = (iPhoneX && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) ? 44: 0;
    min_y = (iPhoneX && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) ? 24: (iPhoneX ? 24 : 24);
    min_w = 44;
    min_h = 44;
    self.backBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = self.backBtn.zf_right;
    min_y = 10;
    min_w = min_view_w - min_x - 15 ;
    min_h = 24;
    self.titleLabel.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.titleLabel.zf_centerY = self.backBtn.zf_centerY;
    
    min_h = iPhoneX ? 70 : 44;
    min_x = 0;
    min_y = min_view_h - min_h;
    min_w = min_view_w;
    self.bottomToolView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = (iPhoneX && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) ? 44: 9;
    min_y = 8;
    min_w = 28;
    min_h = 28;
    self.playOrPauseBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = self.playOrPauseBtn.zf_right + 20;
    min_y = 12;
    min_w = 62;
    min_h = 20;
    self.currentTimeLabel.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.currentTimeLabel.zf_centerY = self.playOrPauseBtn.zf_centerY;
    
    min_w = 62;
    min_x = self.currentTimeLabel.zf_right;
    min_y = 12;
    min_h = 20;
    self.totalTimeLabel.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.totalTimeLabel.zf_centerY = self.playOrPauseBtn.zf_centerY;
    
    min_w = 20;
    min_h = 20;
    min_x = min_view_w - 16 - 20 - 20 - 20;
    min_y = 12;
    self.tvScreenBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.tvScreenBtn.zf_centerY = self.playOrPauseBtn.zf_centerY;
    
    min_w = 20;
    min_h = 20;
    min_x = min_view_w - 16 - 20;
    min_y = 12;
    self.minifyBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.minifyBtn.zf_centerY = self.playOrPauseBtn.zf_centerY;
    
    min_x = 16;
    min_y = 0;
    min_w = min_view_w-32;
    min_h = 2;
    self.slider.frame = CGRectMake(min_x, min_y, min_w, min_h);
//    self.slider.zf_centerY = self.playOrPauseBtn.zf_centerY;
    
    min_x = (iPhoneX && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) ? 50: 18;
    min_y = 0;
    min_w = 40;
    min_h = 40;
    self.lockBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.lockBtn.zf_centerY = self.zf_centerY;
    
    min_x = 0;
    min_y = 0;
    min_w = kScreenWidth;
    min_h = kScreenHeight;
    self.tvScreenView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    
    if (!self.isShow) {
        self.topToolView.zf_y = -self.topToolView.zf_height;
        self.bottomToolView.zf_y = self.zf_height;
    } else {
        if (self.player.isLockedScreen) {
            self.topToolView.zf_y = -self.topToolView.zf_height;
            self.bottomToolView.zf_y = self.zf_height;
        } else {
            self.topToolView.zf_y = 0;
            self.bottomToolView.zf_y = self.zf_height - self.bottomToolView.zf_height;
        }
    }
}

- (void)makeSubViewsAction {
    [self.backBtn addTarget:self action:@selector(backBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.playOrPauseBtn addTarget:self action:@selector(playPauseButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.lockBtn addTarget:self action:@selector(lockButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tvScreenBtn addTarget:self action:@selector(tvScreenBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.minifyBtn addTarget:self action:@selector(minifyBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    __weak __typeof__(self) weakSelf = self;
    _controlTVScreenView.block = ^(NSInteger selectIndex) {
        if (selectIndex == 100) {
            [weakSelf exitTVScreenView];
        }else if (selectIndex == 200){
            //切换设备
            //                [kShowLable setText:@"暂无可切换的设备" position:-1];
            //                weakSelf.tvScreenView.hidden = NO;
        }
    };
    
    
    UITapGestureRecognizer *removeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTVScreenView:)];
    [_tvScreenView addGestureRecognizer:removeTap];
}

- (void)layOutControllerViews {
    [self layoutIfNeeded];
    [self setNeedsLayout];
}

- (void)addTVScreenSetting{
//    //设置好代理
//    self.dlnaManager = [MRDLNA sharedMRDLNAManager];
//    self.dlnaManager.delegate = self;
    
    ////乐播投屏代码
//    self.lelinkBrowser = [[LBLelinkBrowser alloc] init];
//    self.lelinkBrowser.delegate = self;
}

#pragma mark - ZFSliderViewDelegate

- (void)sliderTouchBegan:(float)value {
    self.slider.isdragging = YES;
}

- (void)sliderTouchEnded:(float)value {
    if (self.player.totalTime > 0) {
        @weakify(self)
        [self.player seekToTime:self.player.totalTime*value completionHandler:^(BOOL finished) {
            @strongify(self)
            if (finished) {
                self.slider.isdragging = NO;
            }
        }];
        if (self.seekToPlay) {
            [self.player.currentPlayerManager play];
        }
    } else {
        self.slider.isdragging = NO;
    }
    if (self.sliderValueChanged) self.sliderValueChanged(value);
}

- (void)sliderValueChanged:(float)value {
    if (self.player.totalTime == 0) {
        self.slider.value = 0;
        return;
    }
    self.slider.isdragging = YES;
    NSString *currentTimeString = [ZFUtilities convertTimeSecond:self.player.totalTime*value];
    self.currentTimeLabel.text = currentTimeString;
    if (self.sliderValueChanging) self.sliderValueChanging(value,self.slider.isForward);
}

- (void)sliderTapped:(float)value {
    if (self.player.totalTime > 0) {
        self.slider.isdragging = YES;
        @weakify(self)
        [self.player seekToTime:self.player.totalTime*value completionHandler:^(BOOL finished) {
            @strongify(self)
            if (finished) {
                self.slider.isdragging = NO;
                [self.player.currentPlayerManager play];
            }
        }];
    } else {
        self.slider.isdragging = NO;
        self.slider.value = 0;
    }
}

#pragma mark -

/// 重置ControlView
- (void)resetControlView {
    self.slider.value                = 0;
    self.slider.bufferValue          = 0;
    self.currentTimeLabel.text       = @"00:00";
    self.totalTimeLabel.text         = @"00:00";
    self.backgroundColor             = [UIColor clearColor];
    self.playOrPauseBtn.selected     = YES;
    self.titleLabel.text             = @"";
    self.topToolView.alpha           = 1;
    self.bottomToolView.alpha        = 1;
    self.isShow                      = NO;
}

- (void)showControlView {
    self.lockBtn.alpha               = 1;
    self.isShow                      = YES;
    if (self.player.isLockedScreen) {
        self.topToolView.zf_y        = -self.topToolView.zf_height;
        self.bottomToolView.zf_y     = self.zf_height;
    } else {
        self.topToolView.zf_y        = 0;
        self.bottomToolView.zf_y     = self.zf_height - self.bottomToolView.zf_height;
    }
    self.lockBtn.zf_left             = iPhoneX ? 50: 18;
    self.player.statusBarHidden      = NO;
    if (self.player.isLockedScreen) {
        self.topToolView.alpha       = 0;
        self.bottomToolView.alpha    = 0;
    } else {
        self.topToolView.alpha       = 1;
        self.bottomToolView.alpha    = 1;
    }
}

- (void)hideControlView {
    self.isShow                      = NO;
    self.topToolView.zf_y            = -self.topToolView.zf_height;
    self.bottomToolView.zf_y         = self.zf_height;
    self.lockBtn.zf_left             = iPhoneX ? -82: -47;
    self.player.statusBarHidden      = YES;
    self.topToolView.alpha           = 0;
    self.bottomToolView.alpha        = 0;
    self.lockBtn.alpha               = 0;
}

- (BOOL)shouldResponseGestureWithPoint:(CGPoint)point withGestureType:(ZFPlayerGestureType)type touch:(nonnull UITouch *)touch {
    CGRect sliderRect = [self.bottomToolView convertRect:self.slider.frame toView:self];
    if (CGRectContainsPoint(sliderRect, point)) {
        return NO;
    }
    if (self.player.isLockedScreen && type != ZFPlayerGestureTypeSingleTap) { // 锁定屏幕方向后只相应tap手势
        return NO;
    }
    return YES;
}

- (void)videoPlayer:(ZFPlayerController *)videoPlayer presentationSizeChanged:(CGSize)size {
    self.lockBtn.hidden = self.player.orientationObserver.fullScreenMode == ZFFullScreenModePortrait;
}

- (void)videoPlayer:(ZFPlayerController *)videoPlayer currentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime {
    if (!self.slider.isdragging) {
        NSString *currentTimeString = [ZFUtilities convertTimeSecond:currentTime];
        self.currentTimeLabel.text = currentTimeString;
        NSString *totalTimeString = [ZFUtilities convertTimeSecond:totalTime];
        self.totalTimeLabel.text = totalTimeString;
        self.slider.value = videoPlayer.progress;
    }
}

- (void)videoPlayer:(ZFPlayerController *)videoPlayer bufferTime:(NSTimeInterval)bufferTime {
    self.slider.bufferValue = videoPlayer.bufferProgress;
}

- (void)showTitle:(NSString *)title fullScreenMode:(ZFFullScreenMode)fullScreenMode {
    self.titleLabel.text = title;
    self.player.orientationObserver.fullScreenMode = fullScreenMode;
    self.lockBtn.hidden = fullScreenMode == ZFFullScreenModePortrait;
}

/// 调节播放进度slider和当前时间更新
- (void)sliderValueChanged:(CGFloat)value currentTimeString:(NSString *)timeString {
    self.slider.value = value;
    self.currentTimeLabel.text = timeString;
    self.slider.isdragging = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.slider.sliderBtn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }];
}

/// 滑杆结束滑动
- (void)sliderChangeEnded {
    self.slider.isdragging = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.slider.sliderBtn.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - action

- (void)backBtnClickAction:(UIButton *)sender {
    self.lockBtn.selected = NO;
    self.player.lockedScreen = NO;
    self.lockBtn.selected = NO;
    if (self.player.orientationObserver.supportInterfaceOrientation & ZFInterfaceOrientationMaskPortrait) {
        [self.player enterFullScreen:NO animated:YES];
    }
    if (self.backBtnClickCallback) {
        self.backBtnClickCallback();
    }
}

- (void)playPauseButtonClickAction:(UIButton *)sender {
    [self playOrPause];
}

/// 根据当前播放状态取反
- (void)playOrPause {
    self.playOrPauseBtn.selected = !self.playOrPauseBtn.isSelected;
    self.playOrPauseBtn.isSelected? [self.player.currentPlayerManager play]: [self.player.currentPlayerManager pause];
    
    //根据当前播放的暂停或者开始
//    self.playOrPauseBtn.isSelected? [self.dlnaManager dlnaPlay]: [self.dlnaManager dlnaPause];
    
    //乐播代码--根据当前播放的暂停或者开始
//    self.playOrPauseBtn.isSelected? [self.lelinkPlayer resumePlay]: [self.lelinkPlayer pause];
}

- (void)playBtnSelectedState:(BOOL)selected {
    self.playOrPauseBtn.selected = selected;
}

- (void)lockButtonClickAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.player.lockedScreen = sender.selected;
}

//此处是点击投屏的按钮
- (void)tvScreenBtnClickAction:(UIButton *)sender{
    //调用开始搜索后就会搜索整个局域网中支持投视频的设备
//    [self.dlnaManager startSearch];
    
//    self.services = [NSMutableArray array];
//
//    //乐播投屏代码
//    [LBLelinkBrowser reportAPPTVButtonAction];
//
//    //开始搜索
//    [self.lelinkBrowser searchForLelinkService];
    
    //应该在点击搜索的时候，就把这个视图展示出来，然后显示加载的状态，在后面如果找到的话，就显示，否则就一直加载
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.tvScreenView.hidden = NO;
//        self.tvScreenView.showHUD = YES;
//    });
}

//点击缩小视频的按钮
- (void)minifyBtnClickAction:(UIButton *)sender{
    self.lockBtn.selected = NO;
    self.player.lockedScreen = NO;
    self.lockBtn.selected = NO;
    if (self.player.orientationObserver.supportInterfaceOrientation & ZFInterfaceOrientationMaskPortrait) {
        [self.player enterFullScreen:NO animated:YES];
    }
    if (self.backBtnClickCallback) {
        self.backBtnClickCallback();
    }
}

//#pragma mark -- DLNADelegate
//-(void)searchDLNAResult:(NSArray *)devicesArray{
//    NSLog(@"Find devices");
//    NSLog(@"%@",devicesArray);
//
//    self.playOrPauseBtn.selected = NO;
//    [self.player.currentPlayerManager pause];
//
//    if ([devicesArray count]>0) {
//
//        self.tryTestNum = 0;
//        CLUPnPDevice *model = devicesArray[0];
//
//        NSString *testUrl = [NSString stringWithFormat:@"%@",self.player.assetURL];//@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
//        self.dlnaManager.device = model;
//        self.dlnaManager.playUrl = testUrl;
//        [self.dlnaManager startDLNA];
//
//        //开始投屏之后，先暂停当前的播放,这句代码好像没用，那么就先暂停了
////        [self.dlnaManager dlnaPause];
//    }else {
//        self.tryTestNum ++;
//        if (self.tryTestNum < DefaultTryCount) {
//            [self.dlnaManager startSearch];
//        } else {
//            self.tryTestNum = 0;
//        }
//    }
//}
//
//-(void)dlnaStartPlay{
//    NSLog(@"DLNA Success Start Play");
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.controlTVScreenView.hidden = NO;
//        self.tvScreenBtn.hidden = YES;
//    });
//}

#pragma mark - ZFTVScreenViewDelegate
-(void)zf_tvScreenViewAtIndexPath:(NSInteger)indexPath{
    //此处点击当前已经找到的电视机，然后执行的点击事件
    //此处应当点击当前展示的tableViewcell的按钮,再执行下列的函数
    
//    self.lelinkConnection = [[LBLelinkConnection alloc] init];
//    self.lelinkConnection.delegate = self;
//    self.lelinkConnection.lelinkService = self.services[indexPath];
//    [self.lelinkConnection connect];
    
    //此处需要将电视的名字设置在controller的页面
//    self.controlTVScreenView.tvScreenViewTitle = self.lelinkConnection.lelinkService.lelinkServiceName;
}

#pragma mark - LBLelinkBrowserDelegate

//// 方便调试，错误信息会在此代理方法中回调出来
//- (void)lelinkBrowser:(LBLelinkBrowser *)browser onError:(NSError *)error {
//    NSLog(@"lelinkBrowser onError error = %@",error);
//}

//// 搜索到服务时，会调用此代理方法，将设备列表在此方法中回调出来
//// 注意：如果不调用stop，则当有服务信息和状态更新以及新服务加入网络或服务退出网络时，会调用此代理，将新的设备列表回调出来
//- (void)lelinkBrowser:(LBLelinkBrowser *)browser didFindLelinkServices:(NSArray<LBLelinkService *> *)services {
//    NSLog(@"搜索到设备数 %zd", services.count);
//
//    // 更新UI
//    dispatch_async(dispatch_get_main_queue(), ^{
//            self.tvScreenView.dataSource = [NSMutableArray arrayWithArray:services];
//            self.services = [NSMutableArray arrayWithArray:services];
//    });
//}

//#pragma mark - LBLelinkConnectionDelegate
//- (void)lelinkConnection:(LBLelinkConnection *)connection onError:(NSError *)error {
//    if (error) {
//        NSLog(@"%@",error);
//    }
//}

//- (void)lelinkConnection:(LBLelinkConnection *)connection didConnectToService:(LBLelinkService *)service {
//    NSLog(@"已连接到服务：%@",service.lelinkServiceName);
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //当连接到服务器的时候，需要将tvScreenView列表页面隐藏
//        self.tvScreenView.hidden = YES;
//
//        //当连接到服务器的时候，应该此时显示controlView
//        self.controlTVScreenView.hidden = NO;
//    });
//
//    self.lelinkPlayer = [[LBLelinkPlayer alloc] init];
//    self.lelinkPlayer.delegate = self;
//    self.lelinkPlayer.lelinkConnection = self.lelinkConnection;
//
//    // 实例化媒体对象
//    LBLelinkPlayerItem * item = [[LBLelinkPlayerItem alloc] init];
//    // 设置媒体类型
//    item.mediaType = LBLelinkMediaTypeVideoOnline;
//    // 设置媒体的URL
//    item.mediaURLString = [NSString stringWithFormat:@"%@",self.player.assetURL];
//    // 设置开始播放位置
//    item.startPosition = 0;
//    // 推送
//    [self.lelinkPlayer playWithItem:item];
//}

//- (void)lelinkConnection:(LBLelinkConnection *)connection disConnectToService:(LBLelinkService *)service {
//    NSLog(@"已断开服务连接：%@",service.lelinkServiceName);
//}

//#pragma mark - LBLelinkPlayerDelegate
//// 播放错误代理回调，根据错误信息进行相关的处理
//- (void)lelinkPlayer:(LBLelinkPlayer *)player onError:(NSError *)error {
//    if (error) {
//        NSLog(@"%@",error);
//    }
//}

//// 播放状态代理回调
//- (void)lelinkPlayer:(LBLelinkPlayer *)player playStatus:(LBLelinkPlayStatus)playStatus {
//    NSLog(@"%ld",playStatus);
//    // 根据状态设置播放器的UI
////    ...
//
//    if (playStatus == LBLelinkPlayStatusPlaying) {
//        //正在播放的状态
//        [self.player.currentPlayerManager play];
//    }else if (playStatus == LBLelinkPlayStatusPause){
//        //暂停的状态
//        [self.player.currentPlayerManager pause];
//    }
//}

//// 播放进度信息回调
//- (void)lelinkPlayer:(LBLelinkPlayer *)player progressInfo:(LBLelinkProgressInfo *)progressInfo {
//    NSLog(@"current time = %ld, duration = %ld",progressInfo.currentTime,progressInfo.duration);
//
//    // 设置当前播放时间
////    self.currentTimeLabel.text = [NSString stringWithFormat:@"%ld",(long)progressInfo.currentTime];
//    // 设置总时间
////    self.totalTimeLabel.text = [NSString stringWithFormat:@"%ld",(long)progressInfo.duration];
//
//    // 设置进度条
////    self.progressInfo.minimumValue = 0;
////    self.progressInfo.maximumValue = progressInfo.duration;
////    self.slider.value = progressInfo.currentTime;
//}

#pragma mark - getter
- (UIView *)topToolView {
    if (!_topToolView) {
        _topToolView = [[UIView alloc] init];
        UIImage *image = [UIImage imageWithContentsOfFile:CFYFile(ZFPlayer_top_shadow.png)];
        _topToolView.layer.contents = (id)image.CGImage;
    }
    return _topToolView;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageWithContentsOfFile:CFYFile(ZFPlayer_back_full.png)] forState:UIControlStateNormal];
        _backBtn.backgroundColor = [UIColor cyanColor];
    }
    return _backBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _titleLabel;
}

- (UIView *)bottomToolView {
    if (!_bottomToolView) {
        _bottomToolView = [[UIView alloc] init];
        UIImage *image = [UIImage imageWithContentsOfFile:CFYFile(ZFPlayer_bottom_shadow.png)];
        _bottomToolView.layer.contents = (id)image.CGImage;
    }
    return _bottomToolView;
}

- (UIButton *)playOrPauseBtn {
    if (!_playOrPauseBtn) {
        _playOrPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playOrPauseBtn setImage:[UIImage imageWithContentsOfFile:CFYFile(ZFPlayer_play.png)] forState:UIControlStateNormal];
        [_playOrPauseBtn setImage:[UIImage imageWithContentsOfFile:CFYFile(ZFPlayer_pause.png)] forState:UIControlStateSelected];
    }
    return _playOrPauseBtn;
}

- (UILabel *)currentTimeLabel {
    if (!_currentTimeLabel) {
        _currentTimeLabel = [[UILabel alloc] init];
        _currentTimeLabel.textColor = [UIColor whiteColor];
        _currentTimeLabel.font = [UIFont systemFontOfSize:14.0f];
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _currentTimeLabel;
}

- (ZFSliderView *)slider {
    if (!_slider) {
        _slider = [[ZFSliderView alloc] init];
        _slider.delegate = self;
        _slider.maximumTrackTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.8];
        _slider.bufferTrackTintColor  = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
//        _slider.minimumTrackTintColor = [UIColor colorWithHexString:@"#F62E0A"];//[UIColor whiteColor]
        [_slider setThumbImage:[UIImage imageWithContentsOfFile:CFYFile(ZFPlayer_slider.png)] forState:UIControlStateNormal];
        _slider.sliderHeight = 2;
    }
    return _slider;
}

- (UILabel *)totalTimeLabel {
    if (!_totalTimeLabel) {
        _totalTimeLabel = [[UILabel alloc] init];
        _totalTimeLabel.textColor = [UIColor whiteColor];
        _totalTimeLabel.font = [UIFont systemFontOfSize:14.0f];
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalTimeLabel;
}

- (UIButton *)lockBtn {
    if (!_lockBtn) {
        _lockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lockBtn setImage:[UIImage imageWithContentsOfFile:CFYFile(ZFPlayer_unlock-nor.png)] forState:UIControlStateNormal];
        [_lockBtn setImage:[UIImage imageWithContentsOfFile:CFYFile(ZFPlayer_lock-nor.png)] forState:UIControlStateSelected];
    }
    return _lockBtn;
}

- (UIButton *)tvScreenBtn{
    if (!_tvScreenBtn) {
        _tvScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tvScreenBtn setImage:[UIImage imageWithContentsOfFile:CFYFile(player_icon_mapping.png)] forState:UIControlStateNormal];
    }
    return _tvScreenBtn;
}

- (UIButton *)minifyBtn{
    if (!_minifyBtn) {
        _minifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_minifyBtn setImage:[UIImage imageNamed:@"zfplayer_landscape_full"] forState:UIControlStateNormal];
    }
    return _minifyBtn;
}

- (ZFTVScreenView *)tvScreenView{
    if (!_tvScreenView) {
        _tvScreenView = [[ZFTVScreenView alloc] init];
        _tvScreenView.userInteractionEnabled = YES;
        _tvScreenView.delegate = self;
    }
    
    return _tvScreenView;
}

- (ZFControlTVScreenView *)controlTVScreenView{
    if (!_controlTVScreenView) {
        _controlTVScreenView = [[ZFControlTVScreenView alloc] initWithFrame:CGRectZero];
        _controlTVScreenView.backgroundColor = [UIColor blackColor];
    }
    return _controlTVScreenView;
}

#pragma mark 点击图片
- (void)clickTVScreenView:(UITapGestureRecognizer *)tap{
    _tvScreenView.hidden = YES;
}

#pragma mark -Play Control

- (void)exitTVScreenView{
//    [self.dlnaManager endDLNA];
    
    //这边一般APP的设置的退出投屏都不是真正的退出投屏，电视屏幕上依然会展示电影画面
//    [self.lelinkPlayer stop];
    
    self.controlTVScreenView.hidden = YES;
    self.tvScreenBtn.hidden = NO;
}

///**
// Quit
// */
//- (IBAction)closeAction:(id)sender {
//    [self.dlnaManager endDLNA];
//}
//
//
///**
// Play/Pause
// */
//- (IBAction)playOrPause:(id)sender {
//    if (_isPlaying) {
//        [self.dlnaManager dlnaPause];
//    }else{
//        [self.dlnaManager dlnaPlay];
//    }
//    _isPlaying = !_isPlaying;
//}
//
//
///**
// SeekChange
// */
//- (IBAction)seekChanged:(UISlider *)sender{
//    NSInteger sec = sender.value * 60 * 60;
//    NSLog(@"播放进度条======>: %zd",sec);
//    [self.dlnaManager seekChanged:sec];
//}
//
///**
// VolumeChange
// */
//- (IBAction)volumeChange:(UISlider *)sender {
//    NSString *vol = [NSString stringWithFormat:@"%.f",sender.value * 100];
//    NSLog(@"音量========>: %@",vol);
//    [self.dlnaManager volumeChanged:vol];
//}
//
//
///**
// PlayNextMovie
// */
//- (IBAction)playNext:(id)sender {
//    NSString *testVideo = @"http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4";
//    [self.dlnaManager playTheURL:testVideo];
//}

@end
