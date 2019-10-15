//
//  ZFTVScreenTableViewCell.m
//  xinchen
//
//  Created by ping on 2019/8/7.
//  Copyright © 2019 ping. All rights reserved.
//

#import "ZFTVScreenTableViewCell.h"
#import "UIView+ZFFrame.h"
@implementation ZFTVScreenTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.tvScreenBtn];
        self.contentView.backgroundColor = [UIColor blackColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UIButton *)tvScreenBtn{
    if (!_tvScreenBtn) {
        _tvScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _tvScreenBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _tvScreenBtn.layer.cornerRadius = 18;
        _tvScreenBtn.layer.masksToBounds = YES;
        _tvScreenBtn.layer.borderWidth = 1;
        _tvScreenBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_tvScreenBtn setTitle:@"test" forState:UIControlStateNormal];
        _tvScreenBtn.frame = CGRectMake(0, 0, 162, 36);
        _tvScreenBtn.backgroundColor = [UIColor blackColor];
    }
    return _tvScreenBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
