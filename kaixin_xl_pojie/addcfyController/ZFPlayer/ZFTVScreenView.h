//
//  ZFTVScreenView.h
//  xinchen
//
//  Created by ping on 2019/8/7.
//  Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef  void (^ZFTVScreenViewClickBtnBlock)(NSInteger selectIndex,NSString *indexString);

@protocol ZFTVScreenViewDelegate <NSObject>

- (void)zf_tvScreenViewAtIndexPath:(NSInteger)indexPath;

@end

@interface ZFTVScreenView : UIView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic,copy) ZFTVScreenViewClickBtnBlock block;

@property (nonatomic, weak) id<ZFTVScreenViewDelegate> delegate;
@property (nonatomic, assign) NSInteger indexPath;
@property (nonatomic, assign) BOOL showHUD;
@end

NS_ASSUME_NONNULL_END
