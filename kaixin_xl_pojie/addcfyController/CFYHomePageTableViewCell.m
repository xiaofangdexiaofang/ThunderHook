//
//  CFYHomePageTableViewCell.m
//  
//
//  Created by 陈方永 on 2019/9/5.
//

#import "CFYHomePageTableViewCell.h"
#define MyColor(r,g,b,al) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:al])
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@implementation CFYHomePageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}

- (void)createView{
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16,12,76,110)];
    self.coverImageView.image = [UIImage imageNamed:@"LaunchImage-700-568h@2x"];
    self.coverImageView.backgroundColor = [UIColor redColor];
    [self addSubview:self.coverImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.coverImageView.frame)+16,14,kScreenWidth-76-32-16,30)];
    self.titleLabel.text = @"千与千寻";
    self.titleLabel.textColor = MyColor(51,51,51,1);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.titleLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.coverImageView.frame)+16,CGRectGetMaxY(self.titleLabel.frame),kScreenWidth-76-32-16,20)];
    self.timeLabel.text = @"2019/06/21 上映 共有三个资源";
    self.timeLabel.textColor = MyColor(102,102,102,1);
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.timeLabel];
    
    self.categeryLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.coverImageView.frame)+16,CGRectGetMaxY(self.timeLabel.frame),kScreenWidth-76-32-16,20)];
    self.categeryLabel.text = @"剧情 | 动画 | 奇幻";
    self.categeryLabel.textColor = MyColor(153,153,153,1);
    self.categeryLabel.textAlignment = NSTextAlignmentLeft;
    self.categeryLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.categeryLabel];
    
    self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.coverImageView.frame)+16,CGRectGetMaxY(self.categeryLabel.frame)+5,kScreenWidth-76-32-16,30)];
    self.detailLabel.text = @"  那年夏天，啦啦啦啦啦啦啦啦";
    self.detailLabel.textColor = MyColor(102,102,102,1);
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    self.detailLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.detailLabel];
    self.detailLabel.backgroundColor = MyColor(241,241,241,1);
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.coverImageView.frame)+16,CGRectGetMaxY(self.coverImageView.frame)+12,kScreenWidth-76-32,1)];
    self.lineView.backgroundColor = MyColor(233,233,233,1);
    [self addSubview:self.lineView];
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
