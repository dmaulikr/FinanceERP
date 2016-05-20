//
//  ZYCustomerCompanyInfoSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerCompanyInfoSections.h"

@implementation ZYCustomerCompanyInfoSections
{
    ZYInputCell *companyName;
    ZYInputCell *companyNum;
    ZYInputCell *companyBusinessLicenseNum;
    ZYInputCell *companyLegalPerson;
    ZYInputCell *companyRegisteredCapital;
    ZYInputCell *companyTelephone;
    
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
    companyName = [ZYInputCell cellWithActionBlock:nil];
    companyName.cellTitle = @"企业名称";
    companyName.cellPlaceHolder = @"请输入企业名称";
    
    companyNum = [ZYInputCell cellWithActionBlock:nil];
    companyNum.cellTitle = @"组织机构代码";
    companyNum.cellPlaceHolder = @"请输入组织机构代码";
    
    companyBusinessLicenseNum = [ZYInputCell cellWithActionBlock:nil];
    companyBusinessLicenseNum.cellTitle = @"营业执照号";
    companyBusinessLicenseNum.cellPlaceHolder = @"请输入营业执照号";
    
    companyLegalPerson = [ZYInputCell cellWithActionBlock:nil];
    companyLegalPerson.cellTitle = @"法人";
    companyLegalPerson.cellPlaceHolder = @"请输入法人";
    
    companyRegisteredCapital = [ZYInputCell cellWithActionBlock:nil];
    companyRegisteredCapital.cellNullable = YES;
    companyRegisteredCapital.onlyFloat = YES;
    companyRegisteredCapital.cellTailText = @"万元";
    companyRegisteredCapital.cellTitle = @"法人";
    companyRegisteredCapital.cellPlaceHolder = @"请输入法人";
    
    companyTelephone = [ZYInputCell cellWithActionBlock:nil];
    companyTelephone.cellNullable = YES;
    companyTelephone.cellTitle = @"法人";
    companyTelephone.maxLength = 11;
    companyTelephone.cellRegular = [NSString checkTelephone];
    companyTelephone.cellPlaceHolder = @"请输入法人";
    
    buttonCell = [ZYSingleButtonCell cellWithActionBlock:nil];
    buttonCell.buttonTitle = @"保存";
    [buttonCell.buttonPressedSignal subscribeNext:^(id x) {
        [self cellNextStep:[self error] sender:nil];
    }];
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        if(self.edit)
        {
            ZYSection *section = [ZYSection sectionWithCells:@[companyName,
                                                               companyNum,
                                                               companyBusinessLicenseNum,
                                                               companyLegalPerson,
                                                               companyRegisteredCapital,
                                                               companyTelephone,
                                                               buttonCell]];
            self.sections = @[section];
        }
        else
        {
            ZYSection *section = [ZYSection sectionWithCells:@[companyName,
                                                               companyNum,
                                                               companyBusinessLicenseNum,
                                                               companyLegalPerson,
                                                               companyRegisteredCapital,
                                                               companyTelephone]];
            self.sections = @[section];
        }
    }];
    
    
    
}
- (void)blendModel:(ZYCustomerDetailViewModel*)model
{
    RACChannelTo(companyName,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(companyNum,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(companyBusinessLicenseNum,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(companyLegalPerson,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(companyRegisteredCapital,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(companyTelephone,userInteractionEnabled) = RACChannelTo(self,edit);
    
    RACChannelTo(companyName,cellText) = RACChannelTo(model,companyName);
    RACChannelTo(companyNum,cellText) = RACChannelTo(model,companyNum);
    RACChannelTo(companyBusinessLicenseNum,cellText) = RACChannelTo(model,companyBusinessLicenseNum);
    RACChannelTo(companyLegalPerson,cellText) = RACChannelTo(model,companyLegalPerson);
    RACChannelTo(companyRegisteredCapital,cellText) = RACChannelTo(model,companyRegisteredCapital);
    RACChannelTo(companyTelephone,cellText) = RACChannelTo(model,companyTelephone);
}
- (NSString*)error
{
    NSArray *errorArr = @[companyName,
                          companyNum,
                          companyBusinessLicenseNum,
                          companyLegalPerson];
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
