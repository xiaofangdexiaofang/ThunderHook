//
//  ZFControlTVScreenView.h
//  xinchen
//
//  Created by ping on 2019/8/8.
//  Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef  void (^ZFControlTVScreenViewClickBtnBlock)(NSInteger selectIndex);
@interface ZFControlTVScreenView : UIView
@property (nonatomic, strong) NSString *tvScreenViewTitle;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *exitScreenBtn;
@property (nonatomic, strong) UIButton *changeDeviceBtn;
@property (nonatomic,copy) ZFControlTVScreenViewClickBtnBlock block;
@end

NS_ASSUME_NONNULL_END
