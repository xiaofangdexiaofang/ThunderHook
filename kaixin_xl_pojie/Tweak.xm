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


//1.创建一个指针保存原始函数的地址
//2.创建一个函数，用来hook原始的函数
//3.使用fishhook进行交换，需要一个rebinding的数组和数组的长度

//此处需要找到通过fishhook去hookCFNetwork的方法，来监控底层的信息的收发！！！！

//这边需要自己根据AVplayer去封装视频播放！！！！！！！！！

/*
ssize_t (*original_send)(int, void *, size_t, int);
ssize_t replaced_send(int arg1, void *arg2, size_t arg3, int arg4){
    NSData *data = [NSData dataWithBytes:arg2 length:arg3];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//NSLog(@"##################################################################################################str is %@ length is %lu data is %@", str, arg3, data);
    return original_send(arg1, arg2, arg3, arg4);
}

%ctor {
    MSHookFunction((void *)send, (void *)replaced_send, (void **)&original_send);
}
*/



%hook AppDelegate

- (BOOL)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2{

	//启动socket监控
        //[[[HookSocket alloc] init] open];

	//这里监听下网络状态
	//[ZJHURLProtocol startMonitor];

	//[NSURLProtocol registerClass:[ZJHURLProtocol class]];
	
	// Usage 2: 打印在运行过程中调用了哪些方法

	/*
	// Usage 7: 打印方法调用跟踪
    [ANYMethodLog logMethodWithClass:NSClassFromString(@"AppDelegate") condition:^BOOL(SEL sel) {
        return  YES;
    } before:^(id target, SEL sel, NSArray *args, int deep) {
        NSString *selector = NSStringFromSelector(sel);
        NSArray *selectorArrary = [selector componentsSeparatedByString:@":"];
        selectorArrary = [selectorArrary filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"length > 0"]];
        NSMutableString *selectorString = [NSMutableString new];
        for (int i = 0; i < selectorArrary.count; i++) {
            [selectorString appendFormat:@"%@:%@ ", selectorArrary[i], args[i]];
        }
        NSMutableString *deepString = [NSMutableString new];
        for (int i = 0; i < deep; i++) {
            [deepString appendString:@"-"];
        }
        NSLog(@"ANYMethodLog--%@[%@ %@]", deepString , target, selectorString);
    } after:^(id target, SEL sel, NSArray *args, NSTimeInterval interval, int deep, id retValue) {
        NSMutableString *deepString = [NSMutableString new];
        for (int i = 0; i < deep; i++) {
            [deepString appendString:@"-"];
        }
        NSLog(@"ANYMethodLog--%@ret:%@", deepString, retValue);
    }];

	*/
	
	return %orig;
}

- (void)downloadTasksCreate:(id)arg1 didCreateTasks:(id)arg2 failed:(id)arg3{

	//此处获取到arg2的参数后，就去修改里面的参

	NSLog(@"------------cfy--------AppDelegate-downloadTasksCreate-arg1 ==%@", arg1);
	NSLog(@"------------cfy--------AppDelegate-downloadTasksCreate-arg2 ==%@", arg2);
	
}

%end

%hook TDSlideViewController
- (void)viewDidLoad{
	%orig;

    /*
	UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 		kScreenHeight-64-49)];
	testView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:testView];

	UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100,100,100,100)];
        btn.backgroundColor = [UIColor redColor];
	[btn addTarget:self action:@selector(btnDidClicked) 					forControlEvents:UIControlEventTouchUpInside];
	[testView addSubview:btn];
	[btn setTitle:@"调用迅雷边下边播" forState:UIControlStateNormal];
	[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	btn.center = testView.center;
    */
}

%new
- (void)btnDidClicked{
	
	/*
	TDSlideDownloadListVC *dlVC = [[%c(TDSlideDownloadListVC) alloc] init];
	[self.navigationController pushViewController:dlVC animated:YES];
	*/
}

%end

%hook TDSlideHomeViewController
- (void)viewDidLoad{
    %orig;
}
%end


%hook HomePageVC
- (void)viewDidLoad{

}
%end


%hook TDDiscoveryViewController
- (void)initView{
	%orig;
	UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-64-49)];
	testView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:testView];
}

%end

%hook PersonalCenterVC_new
- (void) viewDidLoad{
	%orig;
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

%new
- (void)btnDidClicked{
	
	TDSlideDownloadListVC *dlVC = [[%c(TDSlideDownloadListVC) alloc] init];
	[self.navigationController pushViewController:dlVC animated:YES];
}

%end

%hook ORDownloadDetailViewController
- (void)playButtonClicked:(id)arg1{
	%orig;

	//arg1==[[电影天堂www.dy2018.com]爱宠大机密2BD中字.mp4, 4, 9, 1028966136, 113976635]
	NSLog(@"------------cfy--------ORDownloadDetailViewController-playButtonClicked-	arg1==%@", arg1);
}

%end

%hook XTFileListController

- (void)buttonAction:(id)arg1{
	%orig;
	NSLog(@"------------cfy--------XTFileListController-buttonAction-arg1==%@", arg1);
}
- (void)downloadTask:(id)arg1 ControlButtonClicked:(id)arg2{
	%orig;
	NSLog(@"------------cfy--------XTFileListController-downloadTask-arg1==%@", arg1);
	NSLog(@"------------cfy--------XTFileListController-downloadTask-arg2==%@", arg2);
}

%end

%hook LinkInputController
- (void)createTaskWithURL:(id)arg1 userData:(id)arg2{
    %orig;
    NSLog(@"------------cfy--------LinkInputController-createTaskWithURL-arg1==%@", arg1);
    NSLog(@"------------cfy--------LinkInputController-createTaskWithURL-arg2==%@", arg2);
}

+ (BOOL)instanseExist{
    %orig;
    return 0;
}

%end

%hook XL_TabBarController

- (void)viewWillAppear:(BOOL)animated{
    %orig;
    NSLog(@"------------cfy--------XL_TabBarController-self.viewControllers-viewWillAppear==%@", [self viewControllers]);
}


- (void)viewDidAppear:(BOOL)animated{
    %orig;
    NSLog(@"------------cfy--------XL_TabBarController-self.viewControllers-viewDidAppear==%@", [self viewControllers]);
    if(self.viewControllers.count >= 4){
        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.viewControllers];
        [arr removeObjectAtIndex:0];
        [arr removeObjectAtIndex:0];
        [arr removeObjectAtIndex:0];
        [arr removeObjectAtIndex:0];

        //将首页做成自己的页面
        CFYHomePageViewController *homeVC = [[%c(CFYHomePageViewController) alloc] init];
        homeVC.tabBarItem.title = @"首页";
        homeVC.tabBarItem.image = [UIImage imageWithContentsOfFile:CFYFile(home_btn_nor.png)];
        homeVC.tabBarItem.selectedImage = [UIImage imageWithContentsOfFile:CFYFile(home_btn_nor.png)];
        UINavigationController *homeNav = [[%c(UINavigationController) alloc] initWithRootViewController:homeVC];
        homeNav.navigationBar.barTintColor = [UIColor whiteColor];
        [arr addObject:homeNav];

        //此处应该在这里做一个NavigationControlelr，将下载的列表作为一个tabar
        TDSlideDownloadListVC *dlVC = [[%c(TDSlideDownloadListVC) alloc] init];
        dlVC.tabBarItem.title = @"下载";
        dlVC.tabBarItem.image = [UIImage imageWithContentsOfFile:CFYFile(downlaod_btn_nor.png)];
        dlVC.tabBarItem.selectedImage = [UIImage imageWithContentsOfFile:CFYFile(downlaod_btn_nor.png)];//
        MyNavigationController *downNav = [[%c(MyNavigationController) alloc] initWithRootViewController:dlVC];
        [arr addObject:downNav];
        self.viewControllers = arr;
    }

}

- (void)viewDidLoad{
    %orig;
    NSLog(@"------------cfy--------XL_TabBarController-self.viewControllers-viewDidAppear==%@", [self viewControllers]);
}

%end

%hook TDSlideDownloadListVC

- (void)viewDidAppear:(BOOL)animated{
    %orig;
    [self showTabBar];
}

- (void)viewDidDisappear:(BOOL)animated{
     %orig;
     //[self hideTabBar];

}

- (void)viewDidLoad{
    %orig;

    //这里注册一个通知，监听点击cell发送的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getClickYBBtnNotification:) name:@"cfygetClickYBBtnNotification" object:nil];
	

}


%new
-(void)getClickYBBtnNotification:(NSNotification *) notification{

    //将收到的点击事件的链接传递过来
    //NSString * str = notification.userInfo[@"oneCellValue"];

    //在这里跳转到播放的详情页面
    ZFFullScreenViewController *playerVC = [[%c(ZFFullScreenViewController) alloc] init];
    playerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playerVC animated:YES];
	//[self presentViewController: playerVC animated:YES completion:nil];

}


%new
- (void)topViewController{

}

%new
- (void)showTabBar{

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

%new
- (void)hideTabBar{
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

%end

%hook CFYHomePageViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

   //这边获取到dataSource的资源，

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


    /*
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    NSString *string = @"ftp://dygod3:dygod3@y069.dydytt.net:3272/海贼王/[阳光电影-www.ygdy8.com][one piece][677].rmvb";
    [pab setString:string];

    if(pab == nil){
        //复制失效
        NSLog(@"------------cfy--------复制粘贴板失效==");
    }else{
        //已复制
        NSLog(@"------------cfy--------复制粘贴板成功==");
    }
    */

    //1.此处自己调用TDAlertView的方法，然后实现跳转到下载列表的页面,因为之前是APP检测粘贴板是否有内容才去触发这个操作，现在要去主动h触发这个操作，这条路暂时走不通，换一条路

    //2.此处应该直接调用输入地址的页面，然后让类实例调用其方法，按钮居然无法点击？？？？此外，还有一点这个方法点击了一行之后，再点击其他行就会闪退？？？？


    if(inputVC == nil){
        inputVC = [[%c(LinkInputController) alloc] init];
    }
    //[%c(LinkInputController) present];
    //[%c(LinkInputController) presentWithIsForClipBoard:0 needToGotoDownloadList:1];

    //firstSectionDict[@"downloadurl"]
    [inputVC createTaskWithURL:firstSectionDict[@"downloadurl"] userData:nil];	
    //[inputVC createTaskWithURL:urlArr[indexPath.row] userData:nil];

    //下面这两句非常重要，如果不加的话，那么在点击首页的下载的方法后，再次点击添加任务的➕按钮会出不来页面
    [inputVC xViewWillUnload];
    [inputVC xViewDidUnload];


    //每次点击这个页面的时候，需要转换页面
    //self.navigationController.tabBarController.selectedIndex = 1;


    //3.这边通过在主页调用downloadList和LinkInput的方法去执行这个步骤，这是第三个方法


    //4.我觉得最主要的能够触发检测的复制粘贴的行为，用它的方法最好，这样可以去除掉不必要的麻烦


    /*
    UIView *view = [[%c(UIView) alloc] initWithFrame:CGRectMake(0,0,300,100)];
    view.backgroundColor = [UIColor redColor];


    //TDAlertView *tdAlert = [[%c(TDAlertView) alloc] init];


    TDAlertView *tdAlert = [%c(TDAlertView) viewWithContentView:view withTitle:@"" cancelButton:@"取消" otherButtons:@"创建任务" delegate:AppDelegate_iPhone];


    [tdAlert buttonWithTitle:@"取消" isCancel:1 longBtn:0];
    [tdAlert buttonWithTitle:@"创建任务" isCancel:0 longBtn:0];



    UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(15,20,265,20)];
    title1.text = @"cfy";
    [%c(TDAlertView) needObserverKeyboard:title1];


    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(15,45,270,40)];
    [%c(TDAlertView) needObserverKeyboard:title2];

    [tdAlert setUserData:@"ftp://dygod3:dygod3@y069.dydytt.net:3272/海贼王/[阳光电影-www.ygdy8.com][one piece][677].rmvb"];


    [tdAlert show];
    */


}

%new
- (void)btnDidClicked{
    /*
    TDSlideDownloadListVC *dlVC = [[%c(TDSlideDownloadListVC) alloc] init];
    [self.navigationController pushViewController:dlVC animated:YES];
    */
}

%end


%hook TDDownloadListADCell
- (double)cellHeightWithData:(id)arg1 cellWidth:(double)arg2{
	%orig;
	return 0;
}
%end

%hook TDDownloadListViewCell

- (void)refreshUI:(id)arg1{
	%orig;
	DLDownloadTask * ddTask = self.downloadTask;
	if(ddTask.errorCode == 114004){ //  || ddTask.errorCode == 9000
		self.vipBtn.hidden = NO;
		[self.vipBtn setTitle:@"云播" forState:UIControlStateNormal];
	}else{
		self.vipBtn.hidden = YES;
	}
}
- (void)updateUI:(id)arg1{
	%orig;
	
	//114004 这个是版权问题
	//9000 这个好像是死链或者也是版权问题
	DLDownloadTask * ddTask = self.downloadTask;
	if(ddTask.errorCode == 114004){
		self.vipBtn.hidden = NO;
		[self.vipBtn setTitle:@"云播" forState:UIControlStateNormal];
	}else{
		self.vipBtn.hidden = YES;
	}
	
}

- (void)onVipBtnClick:(id)arg1{


	NSLog(@"TDDownloadListViewCell---onVipBtnClick---点击加速--%@",arg1);

	//此处应该获取当前的这个cell对应的model，然后把magnet协议拿出来

	//从这里获取到当前这个cell的DLDownloadTask，然后打印出来？？？？？？？？？
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

	//这个是查看任务的版权信息
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--copyright--%d",[ddTask copyright]);


	//卧槽，找了半天终于找到了，原来在这里，这里需要将此任务的url拿出来，然后给通知的dict，这样就可以在播放页面播放magnet协议的视频了
	NSLog(@"cfy---TDDownloadListViewCell---onVipBtnClick--statisticsBaseInfo--%@",[ddTask statisticsBaseInfo]);
	
	//此处本来是点击会员加速的，这里将会员加速修改为云播，然后在这里发送一个通知然后跳转到另外一个页面实现	播放

	//其实理论上这里是可以获取到当前的cell上的task的magnet的协议然后传递给播放器的页面

	//NSString *totalStr = [NSString stringWithFormat:@"%@-%@-%@",item.bizInNo,item.title,item.money];

    	//NSDictionary *dict =[[NSDictionary alloc]initWithObjectsAndKeys:totalStr,@"oneCellValue", nil];

    NSNotification *notification =[NSNotification notificationWithName:@"cfygetClickYBBtnNotification" object:nil userInfo:nil];

    [[NSNotificationCenter defaultCenter] postNotification:notification];


}
%end

%hook DLDownloadTask

%end


%hook DLDownloadManager
%end


%hook CFYCustomPlayerController

%end

%hook DLCopyrightQuery
+ (id)queryWithDownloadTask:(id)arg1{

	NSObject *obj = %orig;
	NSLog(@"cfy---DLCopyrightQuery---queryWithDownloadTask--arg1--%@", arg1);
	NSLog(@"cfy---DLCopyrightQuery---queryWithDownloadTask--id--%@", obj);
	return obj;
}
%end

%hook XLCustomAlertView

%end



