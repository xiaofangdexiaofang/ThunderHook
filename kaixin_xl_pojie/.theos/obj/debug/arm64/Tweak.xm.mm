#line 1 "Tweak.xm"
#import <UIKit/UIKit.h>
#import "kaixin_iThunder_pojie_header.h"
#import <sys/socket.h>
#import <dlfcn.h>
#import <substrate.h>
#import "NSArray+Beyond.h"
#import "fishhook.h"
#import "ANYMethodLog.h"
#import "HookSocket.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define CFYFile(path) @"/Library/PreferenceLoader/Preferences/cfyxunlei/" #path

static LinkInputController *inputVC;



























#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class XL_TabBarController; @class TDSlideHomeViewController; @class HomePageVC; @class ORDownloadDetailViewController; @class DLCopyrightQuery; @class XLCustomAlertView; @class PersonalCenterVC_new; @class DLDownloadManager; @class MyNavigationController; @class TDDownloadListViewCell; @class ZFFullScreenViewController; @class UINavigationController; @class DLDownloadTask; @class CFYHomePageViewController; @class CFYCustomPlayerController; @class AppDelegate; @class XTFileListController; @class TDSlideDownloadListVC; @class TDDownloadListADCell; @class TDSlideViewController; @class LinkInputController; @class TDDiscoveryViewController; 
static BOOL (*_logos_orig$_ungrouped$AppDelegate$application$didFinishLaunchingWithOptions$)(_LOGOS_SELF_TYPE_NORMAL AppDelegate* _LOGOS_SELF_CONST, SEL, id, id); static BOOL _logos_method$_ungrouped$AppDelegate$application$didFinishLaunchingWithOptions$(_LOGOS_SELF_TYPE_NORMAL AppDelegate* _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_orig$_ungrouped$AppDelegate$downloadTasksCreate$didCreateTasks$failed$)(_LOGOS_SELF_TYPE_NORMAL AppDelegate* _LOGOS_SELF_CONST, SEL, id, id, id); static void _logos_method$_ungrouped$AppDelegate$downloadTasksCreate$didCreateTasks$failed$(_LOGOS_SELF_TYPE_NORMAL AppDelegate* _LOGOS_SELF_CONST, SEL, id, id, id); static void (*_logos_orig$_ungrouped$TDSlideViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL TDSlideViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$TDSlideViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL TDSlideViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$TDSlideViewController$btnDidClicked(_LOGOS_SELF_TYPE_NORMAL TDSlideViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$TDSlideHomeViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL TDSlideHomeViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$TDSlideHomeViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL TDSlideHomeViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$HomePageVC$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL HomePageVC* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$HomePageVC$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL HomePageVC* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$TDDiscoveryViewController$initView)(_LOGOS_SELF_TYPE_NORMAL TDDiscoveryViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$TDDiscoveryViewController$initView(_LOGOS_SELF_TYPE_NORMAL TDDiscoveryViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$PersonalCenterVC_new$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL PersonalCenterVC_new* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$PersonalCenterVC_new$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL PersonalCenterVC_new* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$PersonalCenterVC_new$btnDidClicked(_LOGOS_SELF_TYPE_NORMAL PersonalCenterVC_new* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$ORDownloadDetailViewController$playButtonClicked$)(_LOGOS_SELF_TYPE_NORMAL ORDownloadDetailViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$ORDownloadDetailViewController$playButtonClicked$(_LOGOS_SELF_TYPE_NORMAL ORDownloadDetailViewController* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$XTFileListController$buttonAction$)(_LOGOS_SELF_TYPE_NORMAL XTFileListController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$XTFileListController$buttonAction$(_LOGOS_SELF_TYPE_NORMAL XTFileListController* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$XTFileListController$downloadTask$ControlButtonClicked$)(_LOGOS_SELF_TYPE_NORMAL XTFileListController* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$XTFileListController$downloadTask$ControlButtonClicked$(_LOGOS_SELF_TYPE_NORMAL XTFileListController* _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_orig$_ungrouped$LinkInputController$createTaskWithURL$userData$)(_LOGOS_SELF_TYPE_NORMAL LinkInputController* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$LinkInputController$createTaskWithURL$userData$(_LOGOS_SELF_TYPE_NORMAL LinkInputController* _LOGOS_SELF_CONST, SEL, id, id); static BOOL (*_logos_meta_orig$_ungrouped$LinkInputController$instanseExist)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static BOOL _logos_meta_method$_ungrouped$LinkInputController$instanseExist(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$XL_TabBarController$viewWillAppear$)(_LOGOS_SELF_TYPE_NORMAL XL_TabBarController* _LOGOS_SELF_CONST, SEL, BOOL); static void _logos_method$_ungrouped$XL_TabBarController$viewWillAppear$(_LOGOS_SELF_TYPE_NORMAL XL_TabBarController* _LOGOS_SELF_CONST, SEL, BOOL); static void (*_logos_orig$_ungrouped$XL_TabBarController$viewDidAppear$)(_LOGOS_SELF_TYPE_NORMAL XL_TabBarController* _LOGOS_SELF_CONST, SEL, BOOL); static void _logos_method$_ungrouped$XL_TabBarController$viewDidAppear$(_LOGOS_SELF_TYPE_NORMAL XL_TabBarController* _LOGOS_SELF_CONST, SEL, BOOL); static void (*_logos_orig$_ungrouped$XL_TabBarController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL XL_TabBarController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$XL_TabBarController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL XL_TabBarController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$TDSlideDownloadListVC$viewDidAppear$)(_LOGOS_SELF_TYPE_NORMAL TDSlideDownloadListVC* _LOGOS_SELF_CONST, SEL, BOOL); static void _logos_method$_ungrouped$TDSlideDownloadListVC$viewDidAppear$(_LOGOS_SELF_TYPE_NORMAL TDSlideDownloadListVC* _LOGOS_SELF_CONST, SEL, BOOL); static void (*_logos_orig$_ungrouped$TDSlideDownloadListVC$viewDidDisappear$)(_LOGOS_SELF_TYPE_NORMAL TDSlideDownloadListVC* _LOGOS_SELF_CONST, SEL, BOOL); static void _logos_method$_ungrouped$TDSlideDownloadListVC$viewDidDisappear$(_LOGOS_SELF_TYPE_NORMAL TDSlideDownloadListVC* _LOGOS_SELF_CONST, SEL, BOOL); static void (*_logos_orig$_ungrouped$TDSlideDownloadListVC$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL TDSlideDownloadListVC* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$TDSlideDownloadListVC$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL TDSlideDownloadListVC* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$TDSlideDownloadListVC$getClickYBBtnNotification$(_LOGOS_SELF_TYPE_NORMAL TDSlideDownloadListVC* _LOGOS_SELF_CONST, SEL, NSNotification *); static void _logos_method$_ungrouped$TDSlideDownloadListVC$topViewController(_LOGOS_SELF_TYPE_NORMAL TDSlideDownloadListVC* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$TDSlideDownloadListVC$showTabBar(_LOGOS_SELF_TYPE_NORMAL TDSlideDownloadListVC* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$TDSlideDownloadListVC$hideTabBar(_LOGOS_SELF_TYPE_NORMAL TDSlideDownloadListVC* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$CFYHomePageViewController$tableView$didSelectRowAtIndexPath$)(_LOGOS_SELF_TYPE_NORMAL CFYHomePageViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static void _logos_method$_ungrouped$CFYHomePageViewController$tableView$didSelectRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL CFYHomePageViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static void _logos_method$_ungrouped$CFYHomePageViewController$btnDidClicked(_LOGOS_SELF_TYPE_NORMAL CFYHomePageViewController* _LOGOS_SELF_CONST, SEL); static double (*_logos_orig$_ungrouped$TDDownloadListADCell$cellHeightWithData$cellWidth$)(_LOGOS_SELF_TYPE_NORMAL TDDownloadListADCell* _LOGOS_SELF_CONST, SEL, id, double); static double _logos_method$_ungrouped$TDDownloadListADCell$cellHeightWithData$cellWidth$(_LOGOS_SELF_TYPE_NORMAL TDDownloadListADCell* _LOGOS_SELF_CONST, SEL, id, double); static void (*_logos_orig$_ungrouped$TDDownloadListViewCell$refreshUI$)(_LOGOS_SELF_TYPE_NORMAL TDDownloadListViewCell* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$TDDownloadListViewCell$refreshUI$(_LOGOS_SELF_TYPE_NORMAL TDDownloadListViewCell* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$TDDownloadListViewCell$updateUI$)(_LOGOS_SELF_TYPE_NORMAL TDDownloadListViewCell* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$TDDownloadListViewCell$updateUI$(_LOGOS_SELF_TYPE_NORMAL TDDownloadListViewCell* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$TDDownloadListViewCell$onVipBtnClick$)(_LOGOS_SELF_TYPE_NORMAL TDDownloadListViewCell* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$TDDownloadListViewCell$onVipBtnClick$(_LOGOS_SELF_TYPE_NORMAL TDDownloadListViewCell* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_meta_orig$_ungrouped$DLCopyrightQuery$queryWithDownloadTask$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static id _logos_meta_method$_ungrouped$DLCopyrightQuery$queryWithDownloadTask$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$ZFFullScreenViewController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("ZFFullScreenViewController"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$MyNavigationController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("MyNavigationController"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$CFYHomePageViewController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("CFYHomePageViewController"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$UINavigationController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("UINavigationController"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$TDSlideDownloadListVC(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("TDSlideDownloadListVC"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$LinkInputController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("LinkInputController"); } return _klass; }
#line 42 "Tweak.xm"


static BOOL _logos_method$_ungrouped$AppDelegate$application$didFinishLaunchingWithOptions$(_LOGOS_SELF_TYPE_NORMAL AppDelegate* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2){

	
        

	
	

	
	
	

	

























	
	return _logos_orig$_ungrouped$AppDelegate$application$didFinishLaunchingWithOptions$(self, _cmd, arg1, arg2);
}

static void _logos_method$_ungrouped$AppDelegate$downloadTasksCreate$didCreateTasks$failed$(_LOGOS_SELF_TYPE_NORMAL AppDelegate* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, id arg3){

	

	NSLog(@"------------cfy--------AppDelegate-downloadTasksCreate-arg1 ==%@", arg1);
	NSLog(@"------------cfy--------AppDelegate-downloadTasksCreate-arg2 ==%@", arg2);
	
}




static void _logos_method$_ungrouped$TDSlideViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL TDSlideViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	_logos_orig$_ungrouped$TDSlideViewController$viewDidLoad(self, _cmd);

    












}


static void _logos_method$_ungrouped$TDSlideViewController$btnDidClicked(_LOGOS_SELF_TYPE_NORMAL TDSlideViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	
	



}




static void _logos_method$_ungrouped$TDSlideHomeViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL TDSlideHomeViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    _logos_orig$_ungrouped$TDSlideHomeViewController$viewDidLoad(self, _cmd);
}




static void _logos_method$_ungrouped$HomePageVC$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL HomePageVC* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){

}




static void _logos_method$_ungrouped$TDDiscoveryViewController$initView(_LOGOS_SELF_TYPE_NORMAL TDDiscoveryViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	_logos_orig$_ungrouped$TDDiscoveryViewController$initView(self, _cmd);
	UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-64-49)];
	testView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:testView];
}




static void _logos_method$_ungrouped$PersonalCenterVC_new$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL PersonalCenterVC_new* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	_logos_orig$_ungrouped$PersonalCenterVC_new$viewDidLoad(self, _cmd);
	UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth,kScreenHeight-64-49)];
	testView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:testView];

	UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100,100,100,100)];
        btn.backgroundColor = [UIColor redColor];
	[btn addTarget:self action:@selector(btnDidClicked) 					forControlEvents:UIControlEventTouchUpInside];
	[testView addSubview:btn];
	[btn setTitle:@"迅雷边下边播" forState:UIControlStateNormal];
	[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	btn.center = testView.center;
}


static void _logos_method$_ungrouped$PersonalCenterVC_new$btnDidClicked(_LOGOS_SELF_TYPE_NORMAL PersonalCenterVC_new* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	
	TDSlideDownloadListVC *dlVC = [[_logos_static_class_lookup$TDSlideDownloadListVC() alloc] init];
	[self.navigationController pushViewController:dlVC animated:YES];
}




static void _logos_method$_ungrouped$ORDownloadDetailViewController$playButtonClicked$(_LOGOS_SELF_TYPE_NORMAL ORDownloadDetailViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
	_logos_orig$_ungrouped$ORDownloadDetailViewController$playButtonClicked$(self, _cmd, arg1);

	
	NSLog(@"------------cfy--------ORDownloadDetailViewController-playButtonClicked-	arg1==%@", arg1);
}





static void _logos_method$_ungrouped$XTFileListController$buttonAction$(_LOGOS_SELF_TYPE_NORMAL XTFileListController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
	_logos_orig$_ungrouped$XTFileListController$buttonAction$(self, _cmd, arg1);
	NSLog(@"------------cfy--------XTFileListController-buttonAction-arg1==%@", arg1);
}
static void _logos_method$_ungrouped$XTFileListController$downloadTask$ControlButtonClicked$(_LOGOS_SELF_TYPE_NORMAL XTFileListController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2){
	_logos_orig$_ungrouped$XTFileListController$downloadTask$ControlButtonClicked$(self, _cmd, arg1, arg2);
	NSLog(@"------------cfy--------XTFileListController-downloadTask-arg1==%@", arg1);
	NSLog(@"------------cfy--------XTFileListController-downloadTask-arg2==%@", arg2);
}




static void _logos_method$_ungrouped$LinkInputController$createTaskWithURL$userData$(_LOGOS_SELF_TYPE_NORMAL LinkInputController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2){
    _logos_orig$_ungrouped$LinkInputController$createTaskWithURL$userData$(self, _cmd, arg1, arg2);
    NSLog(@"------------cfy--------LinkInputController-createTaskWithURL-arg1==%@", arg1);
    NSLog(@"------------cfy--------LinkInputController-createTaskWithURL-arg2==%@", arg2);
}

static BOOL _logos_meta_method$_ungrouped$LinkInputController$instanseExist(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    _logos_meta_orig$_ungrouped$LinkInputController$instanseExist(self, _cmd);
    return 0;
}





static void _logos_method$_ungrouped$XL_TabBarController$viewWillAppear$(_LOGOS_SELF_TYPE_NORMAL XL_TabBarController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL animated){
    _logos_orig$_ungrouped$XL_TabBarController$viewWillAppear$(self, _cmd, animated);
    NSLog(@"------------cfy--------XL_TabBarController-self.viewControllers-viewWillAppear==%@", [self viewControllers]);
}


static void _logos_method$_ungrouped$XL_TabBarController$viewDidAppear$(_LOGOS_SELF_TYPE_NORMAL XL_TabBarController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL animated){
    _logos_orig$_ungrouped$XL_TabBarController$viewDidAppear$(self, _cmd, animated);
    NSLog(@"------------cfy--------XL_TabBarController-self.viewControllers-viewDidAppear==%@", [self viewControllers]);
    if(self.viewControllers.count >= 4){
        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.viewControllers];
        [arr removeObjectAtIndex:0];
        [arr removeObjectAtIndex:0];
        [arr removeObjectAtIndex:0];
        [arr removeObjectAtIndex:0];

        
        CFYHomePageViewController *homeVC = [[_logos_static_class_lookup$CFYHomePageViewController() alloc] init];
        homeVC.tabBarItem.title = @"首页";
        homeVC.tabBarItem.image = [UIImage imageWithContentsOfFile:CFYFile(home_btn_nor.png)];
        homeVC.tabBarItem.selectedImage = [UIImage imageWithContentsOfFile:CFYFile(home_btn_nor.png)];
        UINavigationController *homeNav = [[_logos_static_class_lookup$UINavigationController() alloc] initWithRootViewController:homeVC];
        homeNav.navigationBar.barTintColor = [UIColor whiteColor];
        [arr addObject:homeNav];

        
        TDSlideDownloadListVC *dlVC = [[_logos_static_class_lookup$TDSlideDownloadListVC() alloc] init];
        dlVC.tabBarItem.title = @"下载";
        dlVC.tabBarItem.image = [UIImage imageWithContentsOfFile:CFYFile(downlaod_btn_nor.png)];
        dlVC.tabBarItem.selectedImage = [UIImage imageWithContentsOfFile:CFYFile(downlaod_btn_nor.png)];
        MyNavigationController *downNav = [[_logos_static_class_lookup$MyNavigationController() alloc] initWithRootViewController:dlVC];
        [arr addObject:downNav];
        self.viewControllers = arr;
    }

}

static void _logos_method$_ungrouped$XL_TabBarController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL XL_TabBarController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    _logos_orig$_ungrouped$XL_TabBarController$viewDidLoad(self, _cmd);
    NSLog(@"------------cfy--------XL_TabBarController-self.viewControllers-viewDidAppear==%@", [self viewControllers]);
}





static void _logos_method$_ungrouped$TDSlideDownloadListVC$viewDidAppear$(_LOGOS_SELF_TYPE_NORMAL TDSlideDownloadListVC* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL animated){
    _logos_orig$_ungrouped$TDSlideDownloadListVC$viewDidAppear$(self, _cmd, animated);
    [self showTabBar];
}

static void _logos_method$_ungrouped$TDSlideDownloadListVC$viewDidDisappear$(_LOGOS_SELF_TYPE_NORMAL TDSlideDownloadListVC* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL animated){
     _logos_orig$_ungrouped$TDSlideDownloadListVC$viewDidDisappear$(self, _cmd, animated);
     

}

static void _logos_method$_ungrouped$TDSlideDownloadListVC$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL TDSlideDownloadListVC* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    _logos_orig$_ungrouped$TDSlideDownloadListVC$viewDidLoad(self, _cmd);

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getClickYBBtnNotification:) name:@"cfygetClickYBBtnNotification" object:nil];
	

}



static void _logos_method$_ungrouped$TDSlideDownloadListVC$getClickYBBtnNotification$(_LOGOS_SELF_TYPE_NORMAL TDSlideDownloadListVC* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSNotification * notification){

    
    

    
    ZFFullScreenViewController *playerVC = [[_logos_static_class_lookup$ZFFullScreenViewController() alloc] init];
    playerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playerVC animated:YES];
	

}



static void _logos_method$_ungrouped$TDSlideDownloadListVC$topViewController(_LOGOS_SELF_TYPE_NORMAL TDSlideDownloadListVC* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){

}


static void _logos_method$_ungrouped$TDSlideDownloadListVC$showTabBar(_LOGOS_SELF_TYPE_NORMAL TDSlideDownloadListVC* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){

    if(self.tabBarController.tabBar.hidden == NO){
        return;
    }

    UIView *contentView;
    if([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]){
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    }else{
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
        CGRect contentFrame = contentView.frame;
        contentFrame.size.height = contentFrame.size.height - 49;
        contentView.frame = contentFrame;

        self.tabBarController.tabBar.hidden = NO;
    }
}


static void _logos_method$_ungrouped$TDSlideDownloadListVC$hideTabBar(_LOGOS_SELF_TYPE_NORMAL TDSlideDownloadListVC* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    if(self.tabBarController.tabBar.hidden ==YES){
        return;
    }

    UIView *contentView;
    if([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]){
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    }else{
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
        CGRect contentFrame = contentView.frame;
        contentFrame.size.height = contentFrame.size.height + 49;
        contentView.frame = contentFrame;

        self.tabBarController.tabBar.hidden = YES;
    }
}





static void _logos_method$_ungrouped$CFYHomePageViewController$tableView$didSelectRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL CFYHomePageViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITableView * tableView, NSIndexPath * indexPath){

   

   NSLog(@"cfy---这个是电影列表的资源%@",self.dataSource);
   NSDictionary *dict = self.dataSource[indexPath.row];
   NSArray *firstSectionArr = dict[@"download"];
   NSDictionary *firstSectionDict = firstSectionArr[0];
   

    NSArray *urlArr = @[@"ftp://ygdy8:ygdy8@yg76.dydytt.net:5645/[阳光电影-www.ygdy8.com]海贼王-880.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5652/[阳光电影-www.ygdy8.com]海贼王-881.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5659/[阳光电影-www.ygdy8.com]海贼王-882.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5665/[阳光电影-www.ygdy8.com]海贼王-883.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5673/[阳光电影-www.ygdy8.com]海贼王884.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5680/[阳光电影-www.ygdy8.com]海贼王-885.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5688/[阳光电影-www.ygdy8.com]海贼王-886.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5694/[阳光电影-www.ygdy8.com]海贼王-887.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5700/[阳光电影-www.ygdy8.com]海贼王-888.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5706/[阳光电影-www.ygdy8.com]海贼王-889.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5713/[阳光电影-www.ygdy8.com]海贼王-890.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5719/[阳光电影-www.ygdy8.com]海贼王-891.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5728/[阳光电影-www.ygdy8.com]海贼王-892.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5736/[阳光电影-www.ygdy8.com]海贼王-893.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5743/[阳光电影-www.ygdy8.com]海贼王-894.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5753/[阳光电影-www.ygdy8.com]海贼王-895.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5758/[阳光电影-www.ygdy8.com]海贼王-896.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5764/[阳光电影-www.ygdy8.com]海贼王-897.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5771/[阳光电影-www.ygdy8.com]海贼王-898.mp4",
                    @"ftp://ygdy8:ygdy8@yg76.dydytt.net:5778/[阳光电影-www.ygdy8.com]海贼王-899.mp4"];


    













    

    


    if(inputVC == nil){
        inputVC = [[_logos_static_class_lookup$LinkInputController() alloc] init];
    }
    
    

    
    [inputVC createTaskWithURL:firstSectionDict[@"downloadurl"] userData:nil];	
    

    
    [inputVC xViewWillUnload];
    [inputVC xViewDidUnload];


    
    


    


    


    






























}


static void _logos_method$_ungrouped$CFYHomePageViewController$btnDidClicked(_LOGOS_SELF_TYPE_NORMAL CFYHomePageViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    



}





static double _logos_method$_ungrouped$TDDownloadListADCell$cellHeightWithData$cellWidth$(_LOGOS_SELF_TYPE_NORMAL TDDownloadListADCell* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, double arg2){
	_logos_orig$_ungrouped$TDDownloadListADCell$cellHeightWithData$cellWidth$(self, _cmd, arg1, arg2);
	return 0;
}




static void _logos_method$_ungrouped$TDDownloadListViewCell$refreshUI$(_LOGOS_SELF_TYPE_NORMAL TDDownloadListViewCell* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
	_logos_orig$_ungrouped$TDDownloadListViewCell$refreshUI$(self, _cmd, arg1);
	DLDownloadTask * ddTask = self.downloadTask;
	if(ddTask.errorCode == 114004){ 
		self.vipBtn.hidden = NO;
		[self.vipBtn setTitle:@"云播" forState:UIControlStateNormal];
	}else{
		self.vipBtn.hidden = YES;
	}
}
static void _logos_method$_ungrouped$TDDownloadListViewCell$updateUI$(_LOGOS_SELF_TYPE_NORMAL TDDownloadListViewCell* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
	_logos_orig$_ungrouped$TDDownloadListViewCell$updateUI$(self, _cmd, arg1);
	
	
	
	DLDownloadTask * ddTask = self.downloadTask;
	if(ddTask.errorCode == 114004){
		self.vipBtn.hidden = NO;
		[self.vipBtn setTitle:@"云播" forState:UIControlStateNormal];
	}else{
		self.vipBtn.hidden = YES;
	}
	
}

static void _logos_method$_ungrouped$TDDownloadListViewCell$onVipBtnClick$(_LOGOS_SELF_TYPE_NORMAL TDDownloadListViewCell* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){


	NSLog(@"TDDownloadListViewCell---onVipBtnClick---点击加速--%@",arg1);

	

	
	DLDownloadTask * ddTask = self.downloadTask;
	
	
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--downloadPlayUrl--%@", ddTask.downloadPlayUrl);
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--filePath--%@", ddTask.filePath);
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--identifier--%@", ddTask.identifier);
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--hash--%d", ddTask.hash);
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--filePath--%@", ddTask.filePath);
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--userData--%@", ddTask.userData);
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--getDownloadUrl--%@",[ddTask getDownloadUrl:YES]);
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--taskInfoItems--%@",[ddTask taskInfoItems]);
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--observerList--%@",[ddTask observerList]);
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--description--%@",[ddTask description]);
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--reportStatus--%@",[ddTask reportStatus]);
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--recordInfosForVodPlay--%@",[ddTask recordInfosForVodPlay]);
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--recordInfosForLocalPlay--%@",[ddTask recordInfosForLocalPlay]);
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--errorCode--%d",[ddTask errorCode]);

	
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--copyright--%d",[ddTask copyright]);


	
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--statisticsBaseInfo--%@",[ddTask statisticsBaseInfo]);
	
	

	

	

    	

    NSNotification *notification =[NSNotification notificationWithName:@"cfygetClickYBBtnNotification" object:nil userInfo:nil];

    [[NSNotificationCenter defaultCenter] postNotification:notification];


}
















static id _logos_meta_method$_ungrouped$DLCopyrightQuery$queryWithDownloadTask$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){

	NSObject *obj = _logos_meta_orig$_ungrouped$DLCopyrightQuery$queryWithDownloadTask$(self, _cmd, arg1);
	NSLog(@"cfy---DLCopyrightQuery---queryWithDownloadTask--arg1--%@", arg1);
	NSLog(@"cfy---DLCopyrightQuery---queryWithDownloadTask--id--%@", obj);
	return obj;
}








static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$AppDelegate = objc_getClass("AppDelegate"); MSHookMessageEx(_logos_class$_ungrouped$AppDelegate, @selector(application:didFinishLaunchingWithOptions:), (IMP)&_logos_method$_ungrouped$AppDelegate$application$didFinishLaunchingWithOptions$, (IMP*)&_logos_orig$_ungrouped$AppDelegate$application$didFinishLaunchingWithOptions$);MSHookMessageEx(_logos_class$_ungrouped$AppDelegate, @selector(downloadTasksCreate:didCreateTasks:failed:), (IMP)&_logos_method$_ungrouped$AppDelegate$downloadTasksCreate$didCreateTasks$failed$, (IMP*)&_logos_orig$_ungrouped$AppDelegate$downloadTasksCreate$didCreateTasks$failed$);Class _logos_class$_ungrouped$TDSlideViewController = objc_getClass("TDSlideViewController"); MSHookMessageEx(_logos_class$_ungrouped$TDSlideViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$TDSlideViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$TDSlideViewController$viewDidLoad);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$TDSlideViewController, @selector(btnDidClicked), (IMP)&_logos_method$_ungrouped$TDSlideViewController$btnDidClicked, _typeEncoding); }Class _logos_class$_ungrouped$TDSlideHomeViewController = objc_getClass("TDSlideHomeViewController"); MSHookMessageEx(_logos_class$_ungrouped$TDSlideHomeViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$TDSlideHomeViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$TDSlideHomeViewController$viewDidLoad);Class _logos_class$_ungrouped$HomePageVC = objc_getClass("HomePageVC"); MSHookMessageEx(_logos_class$_ungrouped$HomePageVC, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$HomePageVC$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$HomePageVC$viewDidLoad);Class _logos_class$_ungrouped$TDDiscoveryViewController = objc_getClass("TDDiscoveryViewController"); MSHookMessageEx(_logos_class$_ungrouped$TDDiscoveryViewController, @selector(initView), (IMP)&_logos_method$_ungrouped$TDDiscoveryViewController$initView, (IMP*)&_logos_orig$_ungrouped$TDDiscoveryViewController$initView);Class _logos_class$_ungrouped$PersonalCenterVC_new = objc_getClass("PersonalCenterVC_new"); MSHookMessageEx(_logos_class$_ungrouped$PersonalCenterVC_new, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$PersonalCenterVC_new$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$PersonalCenterVC_new$viewDidLoad);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$PersonalCenterVC_new, @selector(btnDidClicked), (IMP)&_logos_method$_ungrouped$PersonalCenterVC_new$btnDidClicked, _typeEncoding); }Class _logos_class$_ungrouped$ORDownloadDetailViewController = objc_getClass("ORDownloadDetailViewController"); MSHookMessageEx(_logos_class$_ungrouped$ORDownloadDetailViewController, @selector(playButtonClicked:), (IMP)&_logos_method$_ungrouped$ORDownloadDetailViewController$playButtonClicked$, (IMP*)&_logos_orig$_ungrouped$ORDownloadDetailViewController$playButtonClicked$);Class _logos_class$_ungrouped$XTFileListController = objc_getClass("XTFileListController"); MSHookMessageEx(_logos_class$_ungrouped$XTFileListController, @selector(buttonAction:), (IMP)&_logos_method$_ungrouped$XTFileListController$buttonAction$, (IMP*)&_logos_orig$_ungrouped$XTFileListController$buttonAction$);MSHookMessageEx(_logos_class$_ungrouped$XTFileListController, @selector(downloadTask:ControlButtonClicked:), (IMP)&_logos_method$_ungrouped$XTFileListController$downloadTask$ControlButtonClicked$, (IMP*)&_logos_orig$_ungrouped$XTFileListController$downloadTask$ControlButtonClicked$);Class _logos_class$_ungrouped$LinkInputController = objc_getClass("LinkInputController"); Class _logos_metaclass$_ungrouped$LinkInputController = object_getClass(_logos_class$_ungrouped$LinkInputController); MSHookMessageEx(_logos_class$_ungrouped$LinkInputController, @selector(createTaskWithURL:userData:), (IMP)&_logos_method$_ungrouped$LinkInputController$createTaskWithURL$userData$, (IMP*)&_logos_orig$_ungrouped$LinkInputController$createTaskWithURL$userData$);MSHookMessageEx(_logos_metaclass$_ungrouped$LinkInputController, @selector(instanseExist), (IMP)&_logos_meta_method$_ungrouped$LinkInputController$instanseExist, (IMP*)&_logos_meta_orig$_ungrouped$LinkInputController$instanseExist);Class _logos_class$_ungrouped$XL_TabBarController = objc_getClass("XL_TabBarController"); MSHookMessageEx(_logos_class$_ungrouped$XL_TabBarController, @selector(viewWillAppear:), (IMP)&_logos_method$_ungrouped$XL_TabBarController$viewWillAppear$, (IMP*)&_logos_orig$_ungrouped$XL_TabBarController$viewWillAppear$);MSHookMessageEx(_logos_class$_ungrouped$XL_TabBarController, @selector(viewDidAppear:), (IMP)&_logos_method$_ungrouped$XL_TabBarController$viewDidAppear$, (IMP*)&_logos_orig$_ungrouped$XL_TabBarController$viewDidAppear$);MSHookMessageEx(_logos_class$_ungrouped$XL_TabBarController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$XL_TabBarController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$XL_TabBarController$viewDidLoad);Class _logos_class$_ungrouped$TDSlideDownloadListVC = objc_getClass("TDSlideDownloadListVC"); MSHookMessageEx(_logos_class$_ungrouped$TDSlideDownloadListVC, @selector(viewDidAppear:), (IMP)&_logos_method$_ungrouped$TDSlideDownloadListVC$viewDidAppear$, (IMP*)&_logos_orig$_ungrouped$TDSlideDownloadListVC$viewDidAppear$);MSHookMessageEx(_logos_class$_ungrouped$TDSlideDownloadListVC, @selector(viewDidDisappear:), (IMP)&_logos_method$_ungrouped$TDSlideDownloadListVC$viewDidDisappear$, (IMP*)&_logos_orig$_ungrouped$TDSlideDownloadListVC$viewDidDisappear$);MSHookMessageEx(_logos_class$_ungrouped$TDSlideDownloadListVC, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$TDSlideDownloadListVC$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$TDSlideDownloadListVC$viewDidLoad);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSNotification *), strlen(@encode(NSNotification *))); i += strlen(@encode(NSNotification *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$TDSlideDownloadListVC, @selector(getClickYBBtnNotification:), (IMP)&_logos_method$_ungrouped$TDSlideDownloadListVC$getClickYBBtnNotification$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$TDSlideDownloadListVC, @selector(topViewController), (IMP)&_logos_method$_ungrouped$TDSlideDownloadListVC$topViewController, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$TDSlideDownloadListVC, @selector(showTabBar), (IMP)&_logos_method$_ungrouped$TDSlideDownloadListVC$showTabBar, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$TDSlideDownloadListVC, @selector(hideTabBar), (IMP)&_logos_method$_ungrouped$TDSlideDownloadListVC$hideTabBar, _typeEncoding); }Class _logos_class$_ungrouped$CFYHomePageViewController = objc_getClass("CFYHomePageViewController"); MSHookMessageEx(_logos_class$_ungrouped$CFYHomePageViewController, @selector(tableView:didSelectRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$CFYHomePageViewController$tableView$didSelectRowAtIndexPath$, (IMP*)&_logos_orig$_ungrouped$CFYHomePageViewController$tableView$didSelectRowAtIndexPath$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$CFYHomePageViewController, @selector(btnDidClicked), (IMP)&_logos_method$_ungrouped$CFYHomePageViewController$btnDidClicked, _typeEncoding); }Class _logos_class$_ungrouped$TDDownloadListADCell = objc_getClass("TDDownloadListADCell"); MSHookMessageEx(_logos_class$_ungrouped$TDDownloadListADCell, @selector(cellHeightWithData:cellWidth:), (IMP)&_logos_method$_ungrouped$TDDownloadListADCell$cellHeightWithData$cellWidth$, (IMP*)&_logos_orig$_ungrouped$TDDownloadListADCell$cellHeightWithData$cellWidth$);Class _logos_class$_ungrouped$TDDownloadListViewCell = objc_getClass("TDDownloadListViewCell"); MSHookMessageEx(_logos_class$_ungrouped$TDDownloadListViewCell, @selector(refreshUI:), (IMP)&_logos_method$_ungrouped$TDDownloadListViewCell$refreshUI$, (IMP*)&_logos_orig$_ungrouped$TDDownloadListViewCell$refreshUI$);MSHookMessageEx(_logos_class$_ungrouped$TDDownloadListViewCell, @selector(updateUI:), (IMP)&_logos_method$_ungrouped$TDDownloadListViewCell$updateUI$, (IMP*)&_logos_orig$_ungrouped$TDDownloadListViewCell$updateUI$);MSHookMessageEx(_logos_class$_ungrouped$TDDownloadListViewCell, @selector(onVipBtnClick:), (IMP)&_logos_method$_ungrouped$TDDownloadListViewCell$onVipBtnClick$, (IMP*)&_logos_orig$_ungrouped$TDDownloadListViewCell$onVipBtnClick$);Class _logos_class$_ungrouped$DLCopyrightQuery = objc_getClass("DLCopyrightQuery"); Class _logos_metaclass$_ungrouped$DLCopyrightQuery = object_getClass(_logos_class$_ungrouped$DLCopyrightQuery); MSHookMessageEx(_logos_metaclass$_ungrouped$DLCopyrightQuery, @selector(queryWithDownloadTask:), (IMP)&_logos_meta_method$_ungrouped$DLCopyrightQuery$queryWithDownloadTask$, (IMP*)&_logos_meta_orig$_ungrouped$DLCopyrightQuery$queryWithDownloadTask$);} }
#line 578 "Tweak.xm"
