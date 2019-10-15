//
//  ZFControlTVScreenView.m
//  xinchen
//
//  Created by ping on 2019/8/8.
//  Copyright © 2019 ping. All rights reserved.
//

#import "ZFControlTVScreenView.h"
#import "UIView+ZFFrame.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@implementation ZFControlTVScreenView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
//        CGFloat leftSize = (kScreenWidth-250)/2;
        
        self.userInteractionEnabled = YES;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenHeight/2-125, kScreenWidth/2-23.5-25, 250, 25)];
        _titleLabel.text = @"已投屏到(客厅的小米电视)";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        
        _exitScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exitScreenBtn setTitle:@"退出屏幕" forState:UIControlStateNormal];
        _exitScreenBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _exitScreenBtn.layer.cornerRadius = 18;
        _exitScreenBtn.layer.masksToBounds = YES;
        _exitScreenBtn.layer.borderWidth = 1;
        _exitScreenBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _exitScreenBtn.frame = CGRectMake(kScreenHeight/2-125, CGRectGetMaxY(_titleLabel.frame)+12.5+18, 120, 36);
        [self addSubview:_exitScreenBtn];
        [_exitScreenBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        _exitScreenBtn.tag = 100;
        
        _changeDeviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeDeviceBtn setTitle:@"切换设备" forState:UIControlStateNormal];
        [_changeDeviceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _changeDeviceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _changeDeviceBtn.layer.cornerRadius = 18;
        _changeDeviceBtn.layer.masksToBounds = YES;
        _changeDeviceBtn.layer.borderWidth = 1;
        _changeDeviceBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _changeDeviceBtn.frame = CGRectMake(CGRectGetMaxX(_exitScreenBtn.frame)+10, CGRectGetMaxY(_titleLabel.frame)+12.5+18, 120, 36);
        [self addSubview:_changeDeviceBtn];
        [_changeDeviceBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        _changeDeviceBtn.tag = 200;
    }
    return self;
}

-(void)setTvScreenViewTitle:(NSString *)tvScreenViewTitle{
    _tvScreenViewTitle = tvScreenViewTitle;
    self.titleLabel.text = [NSString stringWithFormat:@"已投屏到(%@)",tvScreenViewTitle];
}

- (void)clickBtn:(UIButton *)btn{
    if (_block) {
        _block(btn.tag);
    }
}

- (void)setup{
    
}

//- (UILabel *)titleLabel{
//    if (!_titleLabel) {
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 25)];
//        _titleLabel.text = @"已投屏到(客厅的小米电视)";
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.font = [UIFont systemFontOfSize:18];
//        _titleLabel.textColor = [UIColor whiteColor];
////        _titleLabel.center = self.center;
//    }
//    return _titleLabel;
//}


//- (UIButton *)exitScreenBtn{
//    if (!_exitScreenBtn) {
//        _exitScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_exitScreenBtn setTitle:@"退出屏幕" forState:UIControlStateNormal];
//        _exitScreenBtn.layer.cornerRadius = 18;
//        _exitScreenBtn.layer.masksToBounds = YES;
//        _exitScreenBtn.layer.borderWidth = 1;
//        _exitScreenBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//        _exitScreenBtn.frame = CGRectMake(0, 0, 120, 36);
//    }
//    return _exitScreenBtn;
//}

//- (UIButton *)changeDeviceBtn{
//    if (!_changeDeviceBtn) {
//        _changeDeviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_changeDeviceBtn setTitle:@"切换设备" forState:UIControlStateNormal];
//        [_changeDeviceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _changeDeviceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        _changeDeviceBtn.layer.cornerRadius = 18;
//        _changeDeviceBtn.layer.masksToBounds = YES;
//        _changeDeviceBtn.layer.borderWidth = 1;
//        _changeDeviceBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//        _changeDeviceBtn.frame = CGRectMake(0, 0, 120, 36);
//    }
//    return _changeDeviceBtn;
//}

@end
