//
//  CFYHomePageTableViewCell.h
//  
//
//  Created by 陈方永 on 2019/9/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFYHomePageTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *coverImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *categeryLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIView *lineView;
@end

NS_ASSUME_NONNULL_END
