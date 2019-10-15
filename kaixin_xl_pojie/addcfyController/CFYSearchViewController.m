//
//  CFYSearchViewController.m
//  
//
//  Created by ping on 2019/10/12.
//

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

#import "CFYSearchViewController.h"
#import "PYSearch/PYSearch.h"
#import "CFYHomePageTableViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "SDWebImage/UIImage+WebP.h"

@interface CFYSearchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation CFYSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //这里的页面是从搜索界面跳转过来的，然后展示列表，再点击下载
    self.navigationItem.title = @"搜索列表";
    
    [self createTableView];
    
    //在这个列表中通过搜索的关键字，网络请求下，然后展示列表
    
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
}

#pragma mark -- tableView dataSource
- (NSInteger)numberOfSectionInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataSource.count > 0) {
        return self.dataSource.count;
    }
    return 1;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
