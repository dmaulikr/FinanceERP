//
//  ZYRefundCounterFeeSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRefundCounterFeeSections.h"

@implementation ZYRefundCounterFeeSections
{
    ZYInputCell *money;
}
- (instancetype)initWithTitle:(NSString *)title
{
    self = [super initWithTitle:title];
    if (self) {
        [self initSection];
    }
    return self;
}
- (void)initSection
{
    money = [ZYInputCell cellWithActionBlock:nil];
    money.cellTitle = @"退费金额";
    money.cellTailText = @"元";
    money.onlyFloat = YES;
    
    ZYSingleButtonCell *buttonCell = [ZYSingleButtonCell cellWithActionBlock:nil];
    [buttonCell.buttonPressedSignal subscribeNext:^(id x) {
        [self cellNextStep:[self error] sender:nil];
    }];
    buttonCell.buttonTitle = @"立即申请";
    
    ZYSection *section = [ZYSection sectionWithCells:@[money,buttonCell]];
    self.sections = @[section];
}
- (void)blendModel:(ZYRefundFeeViewModel*)model
{
    RACChannelTo(money,cellText) = RACChannelTo(model,money);
}
- (NSString*)error
{
    NSArray *errorArr = @[money];
    NSString *result = nil;
    for(id cell in errorArr)
    {
        if([cell respondsToSelector:@selector(checkInput:)])
        {
            NSString *error  = [cell checkInput:YES];
            if(error.length>0&&result==nil)
                result = error;
            else
                continue;
        }
        else
        {
            continue;
        }
    }
    errorArr = nil;
    return result;
}
@end
