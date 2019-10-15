//
//  iThunder_pojie_header.h
//  
//
//  Created by 陈方永 on 2019/8/26.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


//这个是造成闪退问题的类，目前不清楚是什么机制触发导致的闪退，先将其置为空
@interface XLCustomAlertView : UIScrollView
- (void)_init;
- (id)initWithFrame:(struct CGRect)arg1;
- (id)initWithCoder:(id)arg1;
- (void)awakeFromNib;
- (void)dealloc;
+ (void)load;
@end


//推荐模块相关的类
@interface TDSlideViewController : UIViewController
- (void)viewDidLoad;
- (void)btnDidClicked;
@end

@interface TDSlideHomeViewController : TDSlideViewController
- (void)viewDidLoad;
@end

//发现模块
@interface TDDiscoveryViewController : UIViewController
- (void)initView;
- (void)viewDidLoad;
@end

//我的模块
@interface PersonalCenterVC_new : UIViewController
- (void)viewDidLoad;
- (void)btnDidClicked;
@end



//下载列表页面，包括全部，下载中，和已完成
@interface TDSlideDownloadListVC : UIViewController
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)showTabBar;
- (void)hideTabBar;
- (void)viewDidDisappear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
//之所以增加这个函数是因为TDSlideDownloadListVC 找不到这个函数会报错闪退，所以给他添加一个方法
- (void)topViewController;
//
- (void)addtask:(id)arg1;

@end

@interface TDSlideSubTableViewController : UITableViewController
- (void)viewDidLoad;
@end

@interface HomePageVC : TDSlideSubTableViewController

@end

@interface TDDownloadListViewController : TDSlideSubTableViewController
- (void)cell:(id)arg1 downloadTask:(id)arg2 ControlButtonClicked:(id)arg3;
@end

@interface TDSubAllDownloadListVC : TDDownloadListViewController
- (void)viewDidLoad;
@end

//新建任务页面
@interface LinkInputController : UIViewController
- (void)createTaskWithURL:(id)arg1 userData:(id)arg2;
+ (id)presentForClipBoardNeedGotoTaskList:(_Bool)arg1;
+ (id)present;
+ (id)presentWithIsForClipBoard:(_Bool)arg1 needToGotoDownloadList:(_Bool)arg2;
+ (BOOL)instanseExist;
- (void)xViewDidUnload;
- (void)xViewWillUnload;
@end

//tabarController
@interface XL_TabBarController : UITabBarController
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidLoad;
- (void)onConfigTabBarItems;
@end

//
@interface XL_NavigationController : UINavigationController
@end

@interface MyNavigationController : XL_NavigationController
@end


@interface ZJHURLProtocol : NSURLProtocol
/// 开始监听
+ (void)startMonitor;

/// 停止监听
+ (void)stopMonitor;
@end

@interface ZJHSessionConfiguration : NSObject
@end

//下面是自定义弹出弹框的类和方法

@interface AppDelegate : UIResponder
- (void)downloadTasksCreate:(id)arg1 didCreateTasks:(id)arg2 failed:(id)arg3;
- (BOOL)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2;
@end

@interface AppDelegate_iPhone : AppDelegate
- (void)downloadTasksCreate:(id)arg1 didCreateTasks:(id)arg2 failed:(id)arg3;
@end

@interface TDAlertView : UIView
+ (id)viewWithContentView:(id)arg1 withTitle:(id)arg2 cancelButton:(id)arg3 otherButtons:(id)arg4 delegate:(id)arg5;
- (id)buttonWithTitle:(id)arg1 isCancel:(_Bool)arg2 longBtn:(_Bool)arg3;
+ (_Bool)needObserverKeyboard:(id)arg1;
- (void)setUserData:(id)arg1;
- (void)show;
- (void)showInView:(id)arg1;
- (void)showInView:(id)arg1 centerOffset:(struct CGSize)arg2;
@end

@interface XLObserverHoster : NSObject

@end

@interface DLDownloadManager : XLObserverHoster
- (void)startDownloadTasks:(id)arg1;
@end

@interface DLTaskCopyrightInfo : NSObject
@property long long queryError;
@property long long state;
@end

@interface DLDownloadTask : XLObserverHoster
@property(copy, nonatomic) NSString *downloadPlayUrl;
@property(readonly, nonatomic) NSString *filePath;
@property(copy, nonatomic) NSString *downloadPath;
@property(readonly) int hash;
@property(readonly, nonatomic) NSString *identifier;
@property(copy, nonatomic) NSDictionary *userData;
- (id)getDownloadUrl:(_Bool)arg1;
- (id)taskInfoItems;
@property(retain, nonatomic) NSMutableArray *observerList;
@property(readonly, copy) NSString *description;
- (id)reportStatus;
- (id)recordInfosForVodPlay;
- (id)recordInfosForLocalPlay;
- (id)statisticsBaseInfo;
@property(nonatomic) int state;
@property(nonatomic) int errorCode;


//这个是查看是否能找到版权信息
@property(retain) DLTaskCopyrightInfo *copyright;

//下面这些方法都是任务验证版权以及查询资源的方法
+ (BOOL)shouldShowSpeedVip:(id)arg1;
+ (BOOL)autoLiXianEnabled;
+ (BOOL)canCreadLixianTask;
+ (BOOL)autoHighSpeedEnabled;
- (BOOL)canDownloadingPlay;
- (BOOL)isCreated;
- (BOOL)isTaskContainCookie;
- (BOOL)checkIsNotThundermTaskOrHasInfoHash;
- (BOOL)forbidden;
- (void)doCopyrightLogic;
- (void)_dealUnallowed;
- (void)_handleCopyrightState:(long long)arg1 results:(id)arg2 error:(id)arg3;
- (void)_queryCopyright;
- (BOOL)needQuery;
- (void)_copyrightInit;
- (BOOL)isDownloadSuccess;
- (BOOL)isTryHighSpeeding;
- (BOOL)willHighSpeeding;
- (BOOL)isHighSpeeding;
- (BOOL)canHighspeedByTry;
- (BOOL)canHighspeed;
- (id)creeatFailReason;
- (id)taskSpeedUpFailedTips;
- (id)taskFailedTips;
@end

//我也不知道这个是什么几把玩意
@interface DLXTDownloadTask : DLDownloadTask

@end

@interface DLCopyrightQuery : NSObject
+ (id)queryWithDownloadTask:(id)arg1;
@end


//自定义首页的这个页面
@interface CFYHomePageViewController : UIViewController
@property (nonatomic,strong) NSMutableArray *dataSource;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

//这个是广告的cell,这里要屏蔽这个cell有两种方法
//1.initWithStyle 返回nil
//2.cellHeightWithData 返回 0
@interface TDDownloadListADCell : UITableViewCell
- (double)cellHeightWithData:(id)arg1 cellWidth:(double)arg2;
- (id)initWithStyle:(long long)arg1 reuseIdentifier:(id)arg2;
@end

//这个是任务的Cell,当这个任务出现下载失败或者任务异常，那么就需要将云播显示出来，然后点击云播跳转到播放的页面
//1.这里的云播的地址是magnet协议
//2.这里的云播的地址是正常的http或者https的协议
@interface TDDownloadListViewCell : UITableViewCell
- (void)onVipBtnClick:(id)arg1;
@property(retain, nonatomic) DLDownloadTask *downloadTask;
@property(retain, nonatomic) UIButton *vipBtn;
- (void)refreshUI:(id)arg1;
- (void)updateUI:(id)arg1;
@end


@interface CFYCustomPlayerController : UIViewController
- (void)showTabBar;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
@end


@interface ZFFullScreenViewController : UIViewController

@end

@interface UIWebViewController : UIViewController

@end





