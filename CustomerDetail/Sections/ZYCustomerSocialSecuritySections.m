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
    customerSocialOrganization.cellNullable = YES;
    customerSocialOrganization.cellTitle = @"参保单位";
    customerSocialOrganization.cellPlaceHolder = @"请输入参保单位";
    
    customerSocialDate = [ZYSelectCell cellWithActionBlock:nil];
    customerSocialDate.cellTitle = @"本单位参保时间";
    
    customerSocialBase = [ZYInputCell cellWithActionBlock:nil];
    customerSocialBase.cellNullable = YES;
    customerSocialBase.cellTitle = @"参保单位";
    customerSocialBase.cellPlaceHolder = @"请输入参保单位";
}
- (void)blendModel:(ZYCustomerDetailViewModel*)model
{
    
}
@end
