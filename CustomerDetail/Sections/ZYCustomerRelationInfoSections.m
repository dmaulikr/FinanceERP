//
//  ZYCustomerRelationInfoSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerRelationInfoSections.h"

@implementation ZYCustomerRelationInfoSections
{
    ZYInputCell *relationShipName;
    ZYSelectCell *relationShipType;
    ZYInputCell *relationShipCardNum;
    ZYInputCell *relationShipTelephone;
    ZYInputCell *relationShipAddress;
    
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
    relationShipName = [ZYInputCell cellWithActionBlock:nil];
    relationShipName.cellTitle = @"关系人姓名";
    relationShipName.cellPlaceHolder = @"请输入关系人姓名";
    
    relationShipType = [ZYSelectCell cellWithActionBlock:^{
        [self cellPicker:relationShipType withDataSourceSignal:[ZYCustomerDetailViewModel relationArrSignal] showKey:@"name"];
    }];
    relationShipType.showKey = @"name";
    relationShipType.cellTitle = @"关系";
    
    relationShipCardNum = [ZYInputCell cellWithActionBlock:nil];
    relationShipCardNum.cellNullable = YES;
    relationShipCardNum.cellRegular = [NSString checkCardNum];
    relationShipCardNum.cellTitle = @"关系人身份证";
    relationShipCardNum.cellPlaceHolder = @"请输入关系人身份证";
    
    relationShipTelephone = [ZYInputCell cellWithActionBlock:nil];
    relationShipTelephone.maxLength = 11;
    relationShipTelephone.cellRegular = [NSString checkTelephone];
    relationShipTelephone.cellTitle = @"关系人手机号";
    relationShipTelephone.cellPlaceHolder = @"请输入关系人手机号";
    
    relationShipAddress = [ZYInputCell cellWithActionBlock:nil];
    relationShipAddress.cellNullable = YES;
    relationShipAddress.cellTitle = @"通讯地址";
    relationShipAddress.cellPlaceHolder = @"请输入通讯地址";
    
    buttonCell = [ZYSingleButtonCell cellWithActionBlock:nil];
    buttonCell.buttonTitle = @"保存";
    [buttonCell.buttonPressedSignal subscribeNext:^(id x) {
        [self cellNextStep:[self error] sender:nil];
    }];
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        if(self.edit)
        {
            ZYSection *section = [ZYSection sectionWithCells:@[relationShipName,
                                                               relationShipType,
                                                               relationShipCardNum,
                                                               relationShipTelephone,
                                                               relationShipAddress,
                                                               buttonCell]];
            self.sections = @[section];
        }
        else
        {
            ZYSection *section = [ZYSection sectionWithCells:@[relationShipName,
                                                               relationShipType,
                                                               relationShipCardNum,
                                                               relationShipTelephone,
                                                               relationShipAddress]];
            self.sections = @[section];
        }
    }];
    
    
    
}
- (void)blendModel:(ZYCustomerDetailViewModel*)model
{
    RACChannelTo(relationShipName,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(relationShipType,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(relationShipCardNum,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(relationShipTelephone,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(relationShipAddress,userInteractionEnabled) = RACChannelTo(self,edit);
    
    RACChannelTo(relationShipName,cellText) = RACChannelTo(model,relationShipName);
    RACChannelTo(relationShipType,selecedObj) = RACChannelTo(model,relationShipType);
    RACChannelTo(relationShipCardNum,cellText) = RACChannelTo(model,relationShipCardNum);
    RACChannelTo(relationShipTelephone,cellText) = RACChannelTo(model,relationShipTelephone);
    RACChannelTo(relationShipAddress,cellText) = RACChannelTo(model,relationShipAddress);
}
- (NSString*)error
{
    NSArray *errorArr = @[relationShipName,
                          relationShipType,
                          relationShipTelephone];
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
