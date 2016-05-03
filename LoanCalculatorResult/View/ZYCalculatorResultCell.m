//
//  ZYCalculatorResultCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/7.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCalculatorResultCell.h"

@interface ZYCalculatorResultCell ()
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *interestLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMoneyLabel;
@end

@implementation ZYCalculatorResultCell


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    CGFloat width = 1/[UIScreen mainScreen].scale;
    
    for(int i=0;i<4;i++)
    {
        CGFloat gap = rect.size.width/5.f;
        CALayer *line = [CALayer layer];
        line.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"].CGColor;
        line.frame = CGRectMake(gap+gap*i, 10, width, rect.size.height-20.f);
        [self.contentView.layer addSublayer:line];
    }
}
- (void)loadModel:(ZYCaclulatorResultModel*)model
{
    _monthLabel.text = [NSString stringWithFormat:@"第%ld期",(long)model.month];
    _interestLabel.text = [NSString stringWithFormat:@"%@",[NSNumber showPriceWithTenThousand:model.interestPerMonth]];
    _moneyLabel.text = [NSString stringWithFormat:@"%@",[NSNumber showPriceWithTenThousand:model.moneyPerMonth]];
    _paymentLabel.text = [NSString stringWithFormat:@"%@",[NSNumber showPriceWithTenThousand:model.paymenyPerMonth]];
    _lastMoneyLabel.text = [NSString stringWithFormat:@"%@",[NSNumber showPriceWithTenThousand:model.lastMoney]];
}

@end
