//
//  ZYCustomerCreditInfoSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerCreditInfoSections.h"

@implementation ZYCustomerCreditInfoSections
{
    ZYInputCell *creditNum;
    ZYSelectCell *creditDate;
    
    ZYSingleButtonCell *buttonCell;
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
    creditNum = [ZYInputCell cellWithActionBlock:nil];
    creditNum.cellTitle = @"信用报告编号";
    creditNum.cellPlaceHolder = @"请输入信用报告编号";
    
    creditDate = [ZYSelectCell cellWithActionBlock:^{
        [self cellDatePicker:creditDate onlyFutura:NO];
    }];
    creditDate.cellTitle = @"报告查询时间";
    
    buttonCell = [ZYSingleButtonCell cellWithActionBlock:nil];
    buttonCell.buttonTitle = @"保存";
    [buttonCell.buttonPressedSignal subscribeNext:^(id x) {
        [self cellNextStep:[self error] sender:nil];
    }];
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        if(self.edit)
        {
            ZYSection *section = [ZYSection sectionWithCells:@[creditNum,
                                                               creditDate,
                                                               buttonCell]];
            self.sections = @[section];
        }
        else
        {
            ZYSection *section = [ZYSection sectionWithCells:@[creditNum,
                                                               creditDate]];
            self.sections = @[section];
        }
    }];
    
    
    
}
- (void)blendModel:(ZYCustomerDetailViewModel*)model
{
    RACChannelTo(creditNum,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(creditDate,userInteractionEnabled) = RACChannelTo(self,edit);
    
    RACChannelTo(creditNum,cellText) = RACChannelTo(model,creditNum);
    RACChannelTo(creditDate,cellText) = RACChannelTo(model,creditDate);
}
- (NSString*)error
{
    NSArray *errorArr = @[creditNum,
                          creditDate];
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
