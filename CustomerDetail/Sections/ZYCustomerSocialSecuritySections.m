//
//  ZYCustomerSocialSecuritySections.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/18.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerSocialSecuritySections.h"

@implementation ZYCustomerSocialSecuritySections
{
    ZYInputCell *customerSocialOrganization;
    ZYSelectCell *customerSocialDate;
    ZYInputCell *customerSocialBase;
    ZYInputCell *customerSocialTime;//参保时长
    ZYInputCell *customerSocialMedical;//医疗余额
    ZYInputCell *customerSocialPension;//养老余额
    ZYSegmentedCell *customerSocialState;//是否中断
    
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
    customerSocialOrganization = [ZYInputCell cellWithActionBlock:nil];
    customerSocialOrganization.cellTitle = @"参保单位";
    customerSocialOrganization.cellPlaceHolder = @"请输入参保单位";
    
    customerSocialDate = [ZYSelectCell cellWithActionBlock:nil];
    customerSocialDate.cellTitle = @"单位参保时间";
    
    customerSocialBase = [ZYInputCell cellWithActionBlock:nil];
    customerSocialBase.cellNullable = YES;
    customerSocialBase.onlyFloat = YES;
    customerSocialBase.cellTitle = @"参保基数";
    customerSocialBase.cellPlaceHolder = @"请输入参保基数";
    
    customerSocialTime = [ZYInputCell cellWithActionBlock:nil];
    customerSocialTime.cellTitle = @"总参保时间";
    customerSocialTime.cellNullable = YES;
    customerSocialTime.onlyFloat = YES;
    customerSocialTime.cellTailText = @"年";
    
    customerSocialMedical = [ZYInputCell cellWithActionBlock:nil];
    customerSocialMedical.cellNullable = YES;
    customerSocialMedical.cellTitle = @"医疗余额";
    customerSocialMedical.onlyFloat = YES;
    customerSocialMedical.cellPlaceHolder = @"请输入医疗余额";
    
    customerSocialPension = [ZYInputCell cellWithActionBlock:nil];
    customerSocialPension.cellNullable = YES;
    customerSocialPension.cellTitle = @"养老余额";
    customerSocialPension.onlyFloat = YES;
    customerSocialPension.cellPlaceHolder = @"请输入养老余额";
    
    customerSocialState = [ZYSegmentedCell cellWithActionBlock:nil];
    customerSocialState.showKey = @"name";
    [[ZYCustomerDetailViewModel socialStatueArrSignal] subscribeNext:^(id x) {
        customerSocialState.cellSegmentedArr = x;
    }];
    
    customerSocialState.cellTitle = @"是否中断";
    
    buttonCell = [ZYSingleButtonCell cellWithActionBlock:nil];
    buttonCell.buttonTitle = @"保存";
    [buttonCell.buttonPressedSignal subscribeNext:^(id x) {
        [self cellNextStep:[self error] sender:nil];
    }];
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        if(self.edit)
        {
            ZYSection *section = [ZYSection sectionWithCells:@[customerSocialOrganization,
                                                               customerSocialDate,
                                                               customerSocialBase,
                                                               customerSocialTime,
                                                               customerSocialMedical,
                                                               customerSocialPension,
                                                               customerSocialState,
                                                               buttonCell]];
            self.sections = @[section];
        }
        else
        {
            ZYSection *section = [ZYSection sectionWithCells:@[customerSocialOrganization,
                                                               customerSocialDate,
                                                               customerSocialBase,
                                                               customerSocialTime,
                                                               customerSocialMedical,
                                                               customerSocialPension,
                                                               customerSocialState]];
            self.sections = @[section];
        }
    }];
    
    
}
- (void)blendModel:(ZYCustomerDetailViewModel*)model
{
    RACChannelTo(customerSocialOrganization,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(customerSocialDate,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(customerSocialBase,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(customerSocialTime,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(customerSocialMedical,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(customerSocialPension,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(customerSocialState,userInteractionEnabled) = RACChannelTo(self,edit);
    
    RACChannelTo(customerSocialOrganization,cellText) = RACChannelTo(model,customerSocialOrganization);
    RACChannelTo(customerSocialDate,selecedObj) = RACChannelTo(model,customerSocialDate);
    RACChannelTo(customerSocialBase,cellText) = RACChannelTo(model,customerSocialBase);
    RACChannelTo(customerSocialTime,cellText) = RACChannelTo(model,customerSocialTime);
    RACChannelTo(customerSocialMedical,cellText) = RACChannelTo(model,customerSocialMedical);
    RACChannelTo(customerSocialPension,cellText) = RACChannelTo(model,customerSocialPension);
    RACChannelTo(customerSocialState,cellSegmentedSelecedObj) = RACChannelTo(model,customerSocialState);
}
- (NSString*)error
{
    NSArray *errorArr = @[customerSocialOrganization,
                          customerSocialDate];
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
