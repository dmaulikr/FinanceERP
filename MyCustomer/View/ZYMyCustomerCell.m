//
//  ZYMyCustomerCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/10.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYMyCustomerCell.h"
#import <UIImageView+AFNetworking.h>

@interface ZYMyCustomerCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;


@end

@implementation ZYMyCustomerCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [self.headImageView roundRectWith:self.headImageView.height/2.f];
}
- (void)loadData:(ZYCustomerModel*)model
{
    [_headImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,model.file_url]] placeholderImage:[UIImage imageNamed:@"headImage"]];
    _titleLabel.text = model.customer_name;
    _subTitleLabel.text = model.phone_num;
}
+ (CGFloat)defaultHeight
{
    return 80.f;
}
@end
