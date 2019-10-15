//
//  ZFTVScreenView.m
//  xinchen
//
//  Created by ping on 2019/8/7.
//  Copyright © 2019 ping. All rights reserved.
//

#import "ZFTVScreenView.h"
//#import "ZFTVScreenTableViewCell.h"
//#import "MBProgressHUD+NJ.h"
//#import "MBProgressHUD+BWMExtension.h"
#import "UIView+ZFFrame.h"

/*
 自定义颜色
 */
#define MyColor(r,g,b,al) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:al])
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

#define TVScreenTableViewCell @"ZFTVScreenTableViewCell"
#define AnimateDuration 0.4
#define ViewWidth 250

@interface  ZFTVScreenView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *backView;
@end

@implementation ZFTVScreenView

- (instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

-(void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    
    if (dataSource.count<=0) {
        CGRect tableViewFrame = self.tableView.frame;
        tableViewFrame.size.height = 0;
        self.tableView.frame = tableViewFrame;
    }else{
        CGRect tableViewFrame = self.tableView.frame;
        tableViewFrame.size.height = 100;
        self.tableView.frame = tableViewFrame;
        [self.tableView reloadData];
    }
}

-(void)setShowHUD:(BOOL)showHUD{
    if (showHUD) {
        //此处显示当前的加载控件
      
    }else{
        //隐藏当前的加载按钮
        
    }
}

- (void)setup{
    
    //弹出菜单，添加半透明背景
    _backView = [UIButton buttonWithType:UIButtonTypeCustom];
    _backView.frame = CGRectMake(kScreenHeight-250, 0, 250, kScreenWidth);
//    _backView.alpha = 0.3;
    _backView.backgroundColor = MyColor(0, 0, 0, .4);
    [_backView addTarget:self action:@selector(backViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 250, 20)];
    titleLabel.text = @"为你找到以下设备:";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor whiteColor];
    [_backView addSubview:titleLabel];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//    tableView.backgroundColor = MyColor(0, 0, 0, .4);
    tableView.dataSource = self;
    tableView.delegate   = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_backView addSubview:tableView];
    _tableView.hidden = YES;
    
    tableView.frame = CGRectMake(43, CGRectGetMaxY(titleLabel.frame)+40, 250-86, 0);
    self.tableView = tableView;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TVScreenTableViewCell];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ld",indexPath.row]];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%ld",indexPath.row]];
    }
    
//    if (self.dataSource.count>0) {
//        LBLelinkService *service = self.dataSource[indexPath.row];
//        NSLog(@"%@",service.lelinkServiceName);
//        [cell.tvScreenBtn setTitle:service.lelinkServiceName forState:UIControlStateNormal];
//    }
//
//    UIButton *tvScreenBtn = cell.tvScreenBtn;
//    tvScreenBtn.tag = indexPath.row + 100;
//    [tvScreenBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 51;
}

- (void)clickBtn:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(zf_tvScreenViewAtIndexPath:)]) {
        [self.delegate zf_tvScreenViewAtIndexPath:btn.tag-100];
    }
}

- (void)backViewClicked:(id)sender{
}

@end
