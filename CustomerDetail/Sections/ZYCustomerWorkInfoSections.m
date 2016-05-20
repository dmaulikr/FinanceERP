//
//  ZYCustomerWorkInfoSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/18.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerWorkInfoSections.h"

@implementation ZYCustomerWorkInfoSections
{
    ZYSelectCell *customerEducation;
    ZYInputCell *customerCompeny;
    ZYInputCell *customerCompenyAddress;
    ZYInputCell *customerCompenyTelephone;
    ZYSelectCell *customerCompenyTitle;//职称
    ZYInputCell *customerIncome;
    ZYSelectCell *customerIncomeType;//发薪方式
    ZYSelectCell *customerEntryCompanyDate;
    ZYSelectCell *customerIncomeDay;//发薪日
    
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
    customerEducation = [ZYSelectCell cellWithActionBlock:^{
        [self cellPicker:customerEducation withDataSourceSignal:[ZYCustomerDetailViewModel customerEducationArrSignal] showKey:@"name"];
    }];
    customerEducation.showKey = @"name";
    customerEducation.cellTitle = @"最高学历";
    customerEducation.cellNullable = YES;
    
    customerCompeny = [ZYInputCell cellWithActionBlock:nil];
    customerCompeny.cellTitle = @"工作单位";
    customerCompeny.cellPlaceHolder = @"请输入工作单位";
    
    customerCompenyAddress = [ZYInputCell cellWithActionBlock:nil];
    customerCompenyAddress.cellTitle = @"单位地址";
    customerCompenyAddress.cellPlaceHolder = @"请输入单位地址";
    
    customerCompenyTelephone = [ZYInputCell cellWithActionBlock:nil];
    customerCompenyTelephone.cellTitle = @"单位电话";
    customerCompenyTelephone.cellNullable = YES;
    customerCompenyTelephone.maxLength = 11;
    customerCompenyTelephone.onlyInt = YES;
    customerCompenyTelephone.cellRegular = [NSString checkTelephone];
    customerCompenyTelephone.cellPlaceHolder = @"请输入电话";
    
    
    customerCompenyTitle = [ZYSelectCell cellWithActionBlock:^{
        [self cellPicker:customerCompenyTitle withDataSourceSignal:[ZYCustomerDetailViewModel workTitleArrSignal] showKey:@"name"];
    }];
    customerCompenyTitle.showKey = @"name";
    customerCompenyTitle.cellTitle = @"职称";
    customerCompenyTitle.cellNullable = YES;
    
    customerIncome = [ZYInputCell cellWithActionBlock:nil];
    customerIncome.cellTitle = @"月收入";
    customerIncome.onlyFloat = YES;
    customerIncome.cellTailText = @"万元";
    customerIncome.cellNullable = YES;
    
    customerIncomeType = [ZYSelectCell cellWithActionBlock:^{
        [self cellPicker:customerIncomeType withDataSourceSignal:[ZYCustomerDetailViewModel incomeTypeArrSignal] showKey:@"name"];
    }];
    customerIncomeType.showKey = @"name";
    customerIncomeType.cellTitle = @"发薪形式";
    customerIncomeType.cellNullable = YES;
    
    customerEntryCompanyDate = [ZYSelectCell cellWithActionBlock:^{
        [self cellDatePicker:customerEntryCompanyDate onlyFutura:NO];
    }];
    customerEntryCompanyDate.cellTitle = @"入职时间";
    customerEntryCompanyDate.cellNullable = YES;
    
    customerIncomeDay = [ZYSelectCell cellWithActionBlock:^{
        [self cellPicker:customerIncomeDay withDataSourceSignal:[ZYCustomerDetailViewModel incomeDayArrSignal] showKey:nil];
    }];
    customerIncomeDay.showKey = @"name";
    customerIncomeDay.cellTitle = @"发薪日期";
    customerIncomeDay.cellNullable = YES;
    
    buttonCell = [ZYSingleButtonCell cellWithActionBlock:nil];
    buttonCell.buttonTitle = @"保存";
    [buttonCell.buttonPressedSignal subscribeNext:^(id x) {
        [self cellNextStep:[self error] sender:nil];
    }];
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        if(self.edit)
        {
            ZYSection *section = [ZYSection sectionWithCells:@[customerEducation,
                                                               customerCompeny,
                                                               customerCompenyAddress,
                                                               customerCompenyTelephone,
                                                               customerCompenyTitle,
                                                               customerIncome,
                                                               customerIncomeType,
                                                               customerEntryCompanyDate,
                                                               customerIncomeDay,
                                                               buttonCell]];
            self.sections = @[section];
        }
        else
        {
            ZYSection *section = [ZYSection sectionWithCells:@[customerEducation,
                                                               customerCompeny,
                                                               customerCompenyAddress,
                                                               customerCompenyTelephone,
                                                               customerCompenyTitle,
                                                               customerIncome,
                                                               customerIncomeType,
                                                               customerEntryCompanyDate,
                                                               customerIncomeDay]];
            self.sections = @[section];
        }
    }];
    
    
}
- (void)blendModel:(ZYCustomerDetailViewModel*)model
{
    RACChannelTo(customerEducation,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(customerCompeny,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(customerCompenyAddress,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(customerCompenyTelephone,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(customerCompenyTitle,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(customerIncome,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(customerIncomeType,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(customerEntryCompanyDate,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(customerIncomeDay,userInteractionEnabled) = RACChannelTo(self,edit);
    
    
    RACChannelTo(customerEducation,selecedObj) = RACChannelTo(model,customerEducation);
    RACChannelTo(customerCompeny,cellText) = RACChannelTo(model,customerCompeny);
    RACChannelTo(customerCompenyAddress,cellText) = RACChannelTo(model,customerCompenyAddress);
    RACChannelTo(customerCompenyTelephone,cellText) = RACChannelTo(model,customerCompenyTelephone);
    RACChannelTo(customerCompenyTitle,selecedObj) = RACChannelTo(model,customerCompenyTitle);
    RACChannelTo(customerIncome,cellText) = RACChannelTo(model,customerIncome);
    RACChannelTo(customerIncomeType,selecedObj) = RACChannelTo(model,customerIncomeType);
    RACChannelTo(customerEntryCompanyDate,cellText) = RACChannelTo(model,customerEntryCompanyDate);
    RACChannelTo(customerIncomeDay,selecedObj) = RACChannelTo(model,customerIncomeDay);
}
- (NSString*)error
{
    NSArray *errorArr = @[customerCompeny,
                          customerCompenyAddress];
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
