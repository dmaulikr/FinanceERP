//
//  ZYForeclosureHouseOrderInfoHeader.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYForeclosureHouseOrderInfoHeader.h"

@implementation ZYForeclosureHouseOrderInfoHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (CGFloat)defaultHeight
{
    return 30.f;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat tailLableWidth = 40;
        UILabel *tailLable = [[UILabel alloc] initWithFrame:CGRectMake(FUll_SCREEN_WIDTH-tailLableWidth-GAP, 0, tailLableWidth, [ZYForeclosureHouseOrderInfoHeader defaultHeight])];
        tailLable.font = FONT(14);
        tailLable.numberOfLines = 2;
        tailLable.textColor = TITLE_COLOR;
        tailLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tailLable];
        tailLable.text = @"备注";
        
        CGFloat lableWidth = 94;
        UILabel *rightLable = [[UILabel alloc] initWithFrame:CGRectMake(FUll_SCREEN_WIDTH-tailLableWidth-lableWidth-2*GAP, 0, lableWidth, [ZYForeclosureHouseOrderInfoHeader defaultHeight])];
        rightLable.font = FONT(14);
        rightLable.textColor = TITLE_COLOR;
        rightLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:rightLable];
        rightLable.text = @"复印件";
        rightLable.numberOfLines = 2;
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(FUll_SCREEN_WIDTH-tailLableWidth-2*lableWidth-3*GAP, 0, lableWidth, [ZYForeclosureHouseOrderInfoHeader defaultHeight])];
        leftLabel.font = FONT(14);
        leftLabel.textColor = TITLE_COLOR;
        leftLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:leftLabel];
        leftLabel.text = @"原件";
        leftLabel.numberOfLines = 2;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, 0, FUll_SCREEN_WIDTH-tailLableWidth-2*lableWidth-5*GAP, [ZYForeclosureHouseOrderInfoHeader defaultHeight])];
        titleLabel.font = FONT(14);
        titleLabel.textColor = TITLE_COLOR;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        titleLabel.text = @"资料名称";
        titleLabel.numberOfLines = 2;
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
@end
