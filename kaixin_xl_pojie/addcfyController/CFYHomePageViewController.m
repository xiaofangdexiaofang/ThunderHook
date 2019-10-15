//
//  CFYHomePageViewController.m
//  
//
//  Created by 陈方永 on 2019/9/4.
//

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

#import "CFYHomePageViewController.h"
#import "CFYHomePageTableViewCell.h"
#import <CommonCrypto/CommonDigest.h> //MD5签名
#import <MobileCoreServices/MobileCoreServices.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "SDWebImage/UIImageView+WebCache.h"
#import "SDWebImage/UIImage+WebP.h"
#import "CFYSearchViewController.h"
#import "PYSearch/PYSearch.h"
//#import "JWRefresh/UIScrollView+Refresh.h"
//#import "JWRefresh/UITableViewController+NoData.h"

static NSString *Member_Cid = @"D1BA33134F6C772A2DE4CF0D15F66483";

@interface CFYHomePageViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,PYSearchViewControllerDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSString *tokenStr;
@property (nonatomic,assign) NSInteger pageNum;
@property (nonatomic,assign) BOOL stopRefresh;
@end

/*
 Oct 14 11:23:13 iPhone iThunder[17510] <Warning>: XLCustomAlertView deallocated!
 Oct 14 11:23:13 iPhone iThunder[17510] <Error>: *** Terminating app due to uncaught exception 'NSRangeException', reason: 'Cannot remove an observer <XLCustomAlertView 0x124d33060> for the key path "contentOffset" from <XLCustomAlertView 0x124d33060> because it is not registered as an observer.'
 *** First throw call stack:
 (0x18487259c 0x194f840e4 0x1848724dc 0x185687efc 0x1856879b4 0x102885448 0x100580f00 0x184751228 0x18475d7e8 0x194f9d724 0x194f85dd4 0x194f86d1c 0x1200bde44 0x1200c95f8 0x1200c9460 0x1200c9728 0x1200be154 0x1200c1880 0x1200bd044)
 */

@implementation CFYHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = [NSMutableArray new];
    
    self.navigationItem.title = @"最新电影";

    [self createTableView];
    
//    [self requestMember_cid];
    
    [self requestTokenData];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}

//此处跳转到搜索的界面
- (void)onClickedOKbtn{
    
    // 1. Create an Array of popular search
    NSArray *hotSeaches = @[@"我不是药神", @"战狼", @"复仇者联盟4"];
    // 2. Create a search view controller
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"热门资源", @"热门资源") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // Called when search begain.
        // eg：Push to a temp view controller
        CFYSearchViewController *searchVC = [[CFYSearchViewController alloc] init];
        searchVC.searchText = searchText;
        [searchViewController.navigationController pushViewController:searchVC animated:YES];
        
    }];
    // 3. Set style for popular search and search history
//    if (0 == indexPath.section) {
        searchViewController.hotSearchStyle = 0;//(NSInteger)indexPath.row
        searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;
//    } else {
//        searchViewController.hotSearchStyle = PYHotSearchStyleDefault;
//        searchViewController.searchHistoryStyle = (NSInteger)indexPath.row;
//    }
    // 4. Set delegate
    searchViewController.delegate = self;
    // 5. Present(Modal) or push search view controller
    // Present(Modal)
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
        [self presentViewController:nav animated:YES completion:nil];
    // Push
    // Set mode of show search view controller, default is `PYSearchViewControllerShowModeModal`
//    searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowModePush;
//    //    // Push search view controller
//    [self.navigationController pushViewController:searchViewController animated:YES];
    
}

- (void)checkFilterResource{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.131:8008/api/get/json/"];
    //http://jh.lecou.com.cn/lefu/api/heartbeat/updateZfbSinglePay.pay
    //https://u5.utopay.cn/utopay5/api/heartbeat/updateZfbSinglePay.pay
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    
    //如果这边连接失败，客户端这边要做什么？找一个数记录下，如果检测到这边失败直接将timer置为失败，或者不执行后面的代码
    NSMutableDictionary *subDict = [NSMutableDictionary dictionary];
    
    NSData *json = [NSJSONSerialization dataWithJSONObject:subDict options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = json;
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"获取检测电影资源的接口--dict---%@",dict);  // 打印当前线程
            dispatch_async(dispatch_get_main_queue(), ^{
                //界面展示要在主线程做
                //code = 1000; 表示正常返回
                if ([dict[@"code"] intValue] == 1000) {
                    self.dataSource = dict[@"data"];
                    [self.tableView reloadData];
                }
                
            });
        }else{
            NSLog(@"获取检测电影资源的接口--error---%@",error);
        }
    }];
    
    [dataTask resume];
}

//- (void)requestMember_cid{
//
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURL *url = [NSURL URLWithString:@"http://106.12.70.20/api/member/auth/"];
//    //http://jh.lecou.com.cn/lefu/api/heartbeat/updateZfbSinglePay.pay
//    //https://u5.utopay.cn/utopay5/api/heartbeat/updateZfbSinglePay.pay
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    request.HTTPMethod = @"POST";
//
//    //如果这边连接失败，客户端这边要做什么？找一个数记录下，如果检测到这边失败直接将timer置为失败，或者不执行后面的代码
//    NSMutableDictionary *subDict = [NSMutableDictionary dictionary];
//    [subDict setValue:@"" forKey:@"member_cid"];
//    [subDict setValue:[self uuid] forKey:@"uuid"];
//
//
//
//    NSData *json = [NSJSONSerialization dataWithJSONObject:subDict options:NSJSONWritingPrettyPrinted error:nil];
//    request.HTTPBody = json;
//
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error == nil) {
//
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//            NSLog(@"获取member_cid的接口--token---%@",dict);  // 打印当前线程
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //界面展示要在主线程做
//                //code = 1000; 表示正常返回
//                if ([dict[@"code"] intValue] == 1000) {
//
//                }
//
//            });
//        }else{
//
//        }
//    }];
//
//    [dataTask resume];
//
//}

- (void)requestTokenData{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://106.12.70.20/api/get/token/"];
    //http://jh.lecou.com.cn/lefu/api/heartbeat/updateZfbSinglePay.pay
    //https://u5.utopay.cn/utopay5/api/heartbeat/updateZfbSinglePay.pay
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    
    //如果这边连接失败，客户端这边要做什么？找一个数记录下，如果检测到这边失败直接将timer置为失败，或者不执行后面的代码
    NSMutableDictionary *subDict = [NSMutableDictionary dictionary];
    [subDict setValue:@"FIhfrVQyQjWy7oB72pkBcvG7gbTPly=s" forKey:@"access_key_id"];
    [subDict setValue:@"PCL60UgbcQIUPYGFnHSnL1bYXUlqv4bJEg3yVbnDK_fLNSyNPwgCGe1XVwa=LeFX" forKey:@"access_key_secret"];
    
    NSData *json = [NSJSONSerialization dataWithJSONObject:subDict options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = json;
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"获取token的接口--token---%@",dict);  // 打印当前线程
            dispatch_async(dispatch_get_main_queue(), ^{
                //界面展示要在主线程做
                //code = 1000; 表示正常返回
                if ([dict[@"code"] intValue] == 1000) {
                    self.tokenStr = dict[@"token"];
                    [self requestCurrentPageData];
                }
                
            });
        }else{
            
        }
    }];
    
    [dataTask resume];
}

- (void)requestCurrentPageData{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://106.12.70.20/api/films/latest/"];
    //http://jh.lecou.com.cn/lefu/api/heartbeat/updateZfbSinglePay.pay
    //https://u5.utopay.cn/utopay5/api/heartbeat/updateZfbSinglePay.pay
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    
    //如果这边连接失败，客户端这边要做什么？找一个数记录下，如果检测到这边失败直接将timer置为失败，或者不执行后面的代码

    NSMutableDictionary *paraDict = [NSMutableDictionary dictionary];
    [paraDict setValue:@"1" forKey:@"pageNum"];
    [paraDict setValue:@"20" forKey:@"size"];
    
    NSString *jsonString = [self convert2JsonWithDictionary:paraDict];
    NSString *base64EncodingString = [self base64EncodingString:jsonString];
    
    NSString *timestamp = [NSString stringWithFormat:@"%ld",(long)([[NSDate date] timeIntervalSince1970]*1000)];
    
    
    NSString *vsign = [self md5_32bit:[NSString stringWithFormat:@"i=%@&timestamp=%@&token=%@",base64EncodingString,timestamp,self.tokenStr]];
    
    
    NSMutableDictionary *subDict = [NSMutableDictionary dictionary];
    [subDict setValue:self.tokenStr forKey:@"token"];
    [subDict setValue:vsign forKey:@"vsign"];
    [subDict setValue:timestamp forKey:@"timestamp"];
    [subDict setValue:base64EncodingString forKey:@"i"];
    
    
    NSLog(@"此处表示最新电影的列表--filems--latest--subDict-%@",subDict);
    
    NSData *json = [NSJSONSerialization dataWithJSONObject:subDict options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = json;
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
//        [self.tableView endHeaderRefresh];
        
        if (error == nil) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
             // 打印当前线程
            dispatch_async(dispatch_get_main_queue(), ^{
                //界面展示要在主线程做
                NSLog(@"此处表示最新电影的列表--filems--latest--data-%@",dict);
                
                if ([dict[@"code"] intValue] == 1000) {
                    //现在在做资源度的检测，暂时将接口获取到的代码注释
                    self.dataSource = dict[@"films"];
                    [self.tableView reloadData];
                }
            });
            
        }else{
            
        }
    }];
    
    [dataTask resume];
}

//字典转为json字符串
- (NSString *)convert2JsonWithDictionary:(NSMutableDictionary *)dic{
    NSError *err = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    
    NSString *jsonString = nil;
    if (jsonData == nil) {
        NSLog(@"%@",err);
    }else{
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSLog(@"%@",jsonString);
    return jsonString;
}

//将转换后的json字符串经过base64编码
- (NSString *)base64EncodingString:(NSString *)string{
    //1.先转换成二进制
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    
    //对二进制数据进行base64编码，完成后返回字符串
    NSString *baseString  = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    return baseString;
}

- (NSString *)md5_32bit:(NSString *)input{
    //传入参数,转化成char
    const char * str = [input UTF8String];
    //开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    unsigned char md[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (int)strlen(str), md);
    //创建一个可变字符串收集结果
    NSMutableString * ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",md[i]];
    }
    //返回一个长度为32的字符串
    return ret;
}

//通过URL获取网络图片
- (UIImage *)getImageFromURL:(NSString *)fileURL{
    UIImage *images = nil;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    images = [UIImage imageWithData:data];
    return images;
}

- (void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    tableView.frame = CGRectMake(0,0,kScreenWidth,kScreenHeight-64-49);
    
    self.tableView = tableView;
    
    [self.tableView registerClass:[CFYHomePageTableViewCell class] forCellReuseIdentifier:@"HOMECELLID"];
    
    // 上拉加载，下拉刷新测试
//    __weak __typeof(self)weakSelf = self;
//    [(UIScrollView *)self.tableView jw_addHeaderRefreshWithBlock:^{
//        [weakSelf refreshTest];
//    }];
//    [(UIScrollView *)self.tableView jw_addFooterRefreshWithBlock:^{
//        [weakSelf loadTest];
//    }];
}

#pragma mark -- tableView dataSource
- (NSInteger)numberOfSectionInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataSource.count > 0) {
        return self.dataSource.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CFYHomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HOMECELLID" forIndexPath:indexPath];
    if (self.dataSource.count > 0) {
        NSDictionary *dict = self.dataSource[indexPath.row];
        
        
        [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"pic_url"]] placeholderImage:[UIImage imageNamed:@""]];
        
//        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:dict[@"pic_url"]]];
//        UIImage * image = [UIImage sd_imageWithWebPData:data];
//        cell.coverImageView.image = image;
        
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",dict[@"name"]];
        cell.timeLabel.text = dict[@"release_time"];
        NSArray *cateArr = dict[@"label"];
        cell.categeryLabel.text = [cateArr componentsJoinedByString:@"| "]; // | 为分隔符
        cell.detailLabel.text = [NSString stringWithFormat:@"  %@",dict[@"recommend_info"]];
        
        
        //这个是检测资源的
//        NSDictionary *dict = self.dataSource[indexPath.row];
//        cell.timeLabel.text = dict[@"douban_id"];
//
//        NSArray *firstSectionArr = dict[@"download"];
//        NSDictionary *firstSectionDict = firstSectionArr[0];
//        cell.titleLabel.text = [NSString stringWithFormat:@"%d__%@",indexPath.row+1,firstSectionDict[@"downloadname"]];
//        cell.detailLabel.text = [NSString stringWithFormat:@"  %@",firstSectionDict[@"downloadurl"]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark -- tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 134;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
//            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
//                NSString *searchSuggestion = [NSString stringWithFormat:@"Search suggestion %d", i];
//                [searchSuggestionsM addObject:searchSuggestion];
//            }
//            // Refresh and display the search suggustions
//            searchViewController.searchSuggestions = searchSuggestionsM;
//        });
        
        [self searchRelativeText:searchText];
    }
}

//此处获取当前的搜索关键字的
- (void)searchRelativeText:(NSString *)searchText{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.131:8008/api/source/search_related/"];
    //http://jh.lecou.com.cn/lefu/api/heartbeat/updateZfbSinglePay.pay
    //https://u5.utopay.cn/utopay5/api/heartbeat/updateZfbSinglePay.pay
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    

    NSMutableDictionary *subDict = [NSMutableDictionary dictionary];
    [subDict setValue:Member_Cid forKey:@"member_cid"];
    [subDict setValue:searchText forKey:@"search_name"];
    
    NSData *json = [NSJSONSerialization dataWithJSONObject:subDict options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = json;
    
    NSLog(@"cfy---search--post--%@",subDict);
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error == nil) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            // 打印当前线程
            dispatch_async(dispatch_get_main_queue(), ^{
                //界面展示要在主线程做
                NSLog(@"cfy---search--list--%@",dict);
                
                if ([dict[@"code"] intValue] == 1000) {
                    NSArray *moreData = dict[@"names"];
                    
                }
            });
        }else{
            NSLog(@"cfy---search--list--error---%@",error);
        }
    }];
    
    [dataTask resume];
}

#pragma mark add Refresh
//下拉刷新
- (void)refreshTest{
    self.pageNum = 1;
    [self requestTokenData];
}

//上拉刷新
- (void)loadTest{
    
    self.pageNum++;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://106.12.70.20/api/films/latest/"];
    //http://jh.lecou.com.cn/lefu/api/heartbeat/updateZfbSinglePay.pay
    //https://u5.utopay.cn/utopay5/api/heartbeat/updateZfbSinglePay.pay
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    
    //如果这边连接失败，客户端这边要做什么？找一个数记录下，如果检测到这边失败直接将timer置为失败，或者不执行后面的代码
    
    NSMutableDictionary *paraDict = [NSMutableDictionary dictionary];
    [paraDict setValue:[NSString stringWithFormat:@"%d",self.pageNum] forKey:@"pageNum"];
    [paraDict setValue:@"20" forKey:@"size"];
    
    NSString *jsonString = [self convert2JsonWithDictionary:paraDict];
    NSString *base64EncodingString = [self base64EncodingString:jsonString];
    
    NSString *timestamp = [NSString stringWithFormat:@"%ld",(long)([[NSDate date] timeIntervalSince1970]*1000)];
    
    
    NSString *vsign = [self md5_32bit:[NSString stringWithFormat:@"i=%@&timestamp=%@&token=%@",base64EncodingString,timestamp,self.tokenStr]];
    
    
    NSMutableDictionary *subDict = [NSMutableDictionary dictionary];
    [subDict setValue:self.tokenStr forKey:@"token"];
    [subDict setValue:vsign forKey:@"vsign"];
    [subDict setValue:timestamp forKey:@"timestamp"];
    [subDict setValue:base64EncodingString forKey:@"i"];
    
    
    NSLog(@"此处表示最新电影的列表--filems--latest--subDict-%@",subDict);
    
    NSData *json = [NSJSONSerialization dataWithJSONObject:subDict options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = json;
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
//        [self.tableView endFooterRefresh];
        
        if (error == nil) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            // 打印当前线程
            dispatch_async(dispatch_get_main_queue(), ^{
                //界面展示要在主线程做
                NSLog(@"此处表示最新电影的列表--filems--latest--data-%@",dict);
                
                if ([dict[@"code"] intValue] == 1000) {
                    NSArray *moreData = dict[@"films"];
                    if (moreData.count > 0) {
                        [self.dataSource addObjectsFromArray:moreData];
                        [self.tableView reloadData];
                    }
                }
            });
        }else{
            
        }
    }];
    
    [dataTask resume];
}


-(NSString*)uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
