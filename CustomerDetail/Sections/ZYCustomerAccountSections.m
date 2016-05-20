//
//  ZYCustomerAccountSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerAccountSections.h"

@implementation ZYCustomerAccountSections
{
    ZYInputCell *bankName;
    ZYSelectCell *accountType;
    ZYSelectCell *accountPurpose;
    ZYInputCell *accountName;
    ZYInputCell *accountNum;
    
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
    bankName = [ZYInputCell cellWithActionBlock:nil];
    bankName.cellTitle = @"银行名称";
    bankName.cellPlaceHolder = @"请输入银行名称";
    
    accountType = [ZYSelectCell cellWithActionBlock:^{
        [self cellPicker:accountType withDataSourceSignal:[ZYCustomerDetailViewModel accountTypeArrSignal] showKey:@"name"];
    }];
    accountType.showKey = @"name";
    accountType.cellTitle = @"账户类型";
    
    accountPurpose = [ZYSelectCell cellWithActionBlock:^{
        [self cellPicker:accountPurpose withDataSourceSignal:[ZYCustomerDetailViewModel accountPurposeArrSignal] showKey:@"name"];
    }];
    accountPurpose.showKey = @"name";
    accountPurpose.cellTitle = @"账户用途";
    
    accountName = [ZYInputCell cellWithActionBlock:nil];
    accountName.cellTitle = @"开户名";
    accountName.cellPlaceHolder = @"请输入开户名";
    accountName.cellNullable = YES;
    
    accountNum = [ZYInputCell cellWithActionBlock:nil];
    accountNum.cellTitle = @"卡号";
    accountNum.cellPlaceHolder = @"请输入卡号";
    accountNum.cellNullable = YES;
    accountNum.onlyInt = YES;
    
    buttonCell = [ZYSingleButtonCell cellWithActionBlock:nil];
    buttonCell.buttonTitle = @"保存";
    [buttonCell.buttonPressedSignal subscribeNext:^(id x) {
        [self cellNextStep:[self error] sender:nil];
    }];
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        if(self.edit)
        {
            ZYSection *section = [ZYSection sectionWithCells:@[bankName,
                                                               accountType,
                                                               accountPurpose,
                                                               accountName,
                                                               accountNum,
                                                               buttonCell]];
            self.sections = @[section];
        }
        else
        {
            ZYSection *section = [ZYSection sectionWithCells:@[bankName,
                                                               accountType,
                                                               accountPurpose,
                                                               accountName,
                                                               accountNum,]];
            self.sections = @[section];
        }
    }];
    
    
    
}
- (void)blendModel:(ZYCustomerDetailViewModel*)model
{
    RACChannelTo(bankName,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(accountType,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(accountPurpose,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(accountName,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(accountNum,userInteractionEnabled) = RACChannelTo(self,edit);
    
    RACChannelTo(bankName,cellText) = RACChannelTo(model,bankName);
    RACChannelTo(accountType,selecedObj) = RACChannelTo(model,accountType);
    RACChannelTo(accountPurpose,selecedObj) = RACChannelTo(model,accountPurpose);
    RACChannelTo(accountName,cellText) = RACChannelTo(model,accountName);
    RACChannelTo(accountNum,cellText) = RACChannelTo(model,accountNum);
}
- (NSString*)error
{
    NSArray *errorArr = @[bankName,
                          accountType,
                          accountPurpose];
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
