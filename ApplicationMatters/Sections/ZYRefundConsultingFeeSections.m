//
//  ZYRefundConsultingFeeSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRefundConsultingFeeSections.h"

@implementation ZYRefundConsultingFeeSections
{
    ZYInputCell *money;
    ZYInputCell *accountName;
    ZYInputCell *account;
    ZYInputCell *accountBank;
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
    money.cellPlaceHolder = @"请输入退费金额";
    money.onlyFloat = YES;
    
    accountName = [ZYInputCell cellWithActionBlock:nil];
    accountName.cellPlaceHolder = @"请输入收款人户名";
    accountName.cellTitle = @"收款人户名";
    
    account = [ZYInputCell cellWithActionBlock:nil];
    account.cellPlaceHolder = @"请输入收款人账户";
    account.onlyInt = YES;
    account.cellTitle = @"收款人账户";
    
    accountBank = [ZYInputCell cellWithActionBlock:nil];
    accountBank.cellPlaceHolder = @"请输入开户行";
    accountBank.cellTitle = @"开户行";
    
    ZYSingleButtonCell *buttonCell = [ZYSingleButtonCell cellWithActionBlock:nil];
    [buttonCell.buttonPressedSignal subscribeNext:^(id x) {
        [self cellNextStep:[self error] sender:nil];
    }];
    buttonCell.buttonTitle = @"立即申请";
    
    ZYSection *section = [ZYSection sectionWithCells:@[money,accountName,account,accountBank,buttonCell]];
    self.sections = @[section];
}
- (void)blendModel:(ZYRefundFeeViewModel*)model
{
    RACChannelTo(money,cellText) = RACChannelTo(model,money);
    RACChannelTo(accountName,cellText) = RACChannelTo(model,accountName);
    RACChannelTo(account,cellText) = RACChannelTo(model,account);
    RACChannelTo(accountBank,cellText) = RACChannelTo(model,accountBank);
}
- (NSString*)error
{
    NSArray *errorArr = @[money,
                          accountName,
                          account,
                          accountBank];
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
