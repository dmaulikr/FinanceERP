//
//  ZYCustomerFamilyInfoSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/18.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerFamilyInfoSections.h"

@implementation ZYCustomerFamilyInfoSections
{
    ZYSegmentedCell *liveIdentity;
    ZYSelectCell *liveState;
    ZYSelectCell *liveType;
    ZYInputCell *liveArea;
    ZYInputCell *totalProperty;//总资产
    ZYInputCell *totalLiabilities;//总负债
    ZYInputCell *monthlyAverageIncome;//月平均收入
    ZYInputCell *familyIncome;//家庭税后收入
    ZYInputCell *spouseName;//配偶姓名
    ZYInputCell *spouseCardNum;//配偶身份证
    ZYInputCell *spouseTelephone;//配偶电话
    
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
    liveIdentity = [ZYSegmentedCell cellWithActionBlock:nil];
    liveIdentity.cellTitle = @"是否户主";
    [[ZYCustomerDetailViewModel liveIdentityArrSignal] subscribeNext:^(id x) {
        liveIdentity.cellSegmentedArr = x;
    }];
    
    liveState = [ZYSelectCell cellWithActionBlock:^{
        [self cellPicker:liveState withDataSourceSignal:[ZYCustomerDetailViewModel liveStateArrSignal] showKey:@"name"];
    }];
    liveState.showKey = @"name";
    liveState.cellTitle = @"居住状况";
    
    liveType = [ZYSelectCell cellWithActionBlock:^{
        [self cellPicker:liveType withDataSourceSignal:[ZYCustomerDetailViewModel liveTypeArrSignal] showKey:@"name"];
    }];
    liveType.showKey = @"name";
    liveType.cellTitle = @"现住宅形式";
    
    liveArea = [ZYInputCell cellWithActionBlock:nil];
    liveArea.cellTitle = @"现住宅面积";
    liveArea.onlyFloat = YES;
    liveArea.cellPlaceHolder = @"请输入现住宅面积";
    
    totalProperty = [ZYInputCell cellWithActionBlock:nil];
    totalProperty.cellNullable = YES;
    totalProperty.cellTitle = @"总资产";
    totalProperty.onlyFloat = YES;
    totalProperty.cellPlaceHolder = @"请输入总资产";
    totalProperty.cellTailText = @"万元";
    
    totalLiabilities = [ZYInputCell cellWithActionBlock:nil];
    totalLiabilities.cellNullable = YES;
    totalLiabilities.cellTitle = @"总负债";
    totalLiabilities.onlyFloat = YES;
    totalLiabilities.cellPlaceHolder = @"请输入总负债";
    totalLiabilities.cellTailText = @"万元";
    
    monthlyAverageIncome = [ZYInputCell cellWithActionBlock:nil];
    monthlyAverageIncome.cellNullable = YES;
    monthlyAverageIncome.cellTitle = @"月平均工资";
    monthlyAverageIncome.onlyFloat = YES;
    monthlyAverageIncome.cellPlaceHolder = @"请输入月平均工资";
    monthlyAverageIncome.cellTailText = @"元";
    
    familyIncome = [ZYInputCell cellWithActionBlock:nil];
    familyIncome.cellNullable = YES;
    familyIncome.cellTitle = @"家庭税后收入";
    familyIncome.onlyFloat = YES;
    familyIncome.cellPlaceHolder = @"请输入家庭税后收入";
    familyIncome.cellTailText = @"元";
    
    spouseName = [ZYInputCell cellWithActionBlock:nil];
    spouseName.cellNullable = YES;
    spouseName.cellTitle = @"配偶名字";
    spouseName.cellPlaceHolder = @"请输入配偶名字";
    
    spouseCardNum = [ZYInputCell cellWithActionBlock:nil];
    spouseCardNum.cellNullable = YES;
    spouseCardNum.cellTitle = @"配偶身份证号";
    spouseCardNum.cellRegular = [NSString checkCardNum];
    spouseCardNum.onlyInt = YES;
    spouseCardNum.cellPlaceHolder = @"请输入配偶身份证号";

    spouseTelephone = [ZYInputCell cellWithActionBlock:nil];
    spouseTelephone.cellNullable = YES;
    spouseTelephone.cellTitle = @"配偶电话";
    spouseTelephone.onlyInt = YES;
    spouseTelephone.maxLength = 11;
    spouseTelephone.cellPlaceHolder = @"配偶电话";
    
    buttonCell = [ZYSingleButtonCell cellWithActionBlock:nil];
    buttonCell.buttonTitle = @"保存";
    [buttonCell.buttonPressedSignal subscribeNext:^(id x) {
        [self cellNextStep:[self error] sender:nil];
    }];
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        if(self.edit)
        {
            ZYSection *section = [ZYSection sectionWithCells:@[liveIdentity,
                                                               liveState,
                                                               liveType,
                                                               liveArea,
                                                               totalProperty,
                                                               totalLiabilities,
                                                               monthlyAverageIncome,
                                                               familyIncome,
                                                               spouseName,
                                                               spouseCardNum,
                                                               spouseTelephone,
                                                               buttonCell]];
            self.sections = @[section];
        }
        else
        {
            ZYSection *section = [ZYSection sectionWithCells:@[liveIdentity,
                                                               liveState,
                                                               liveType,
                                                               liveArea,
                                                               totalProperty,
                                                               totalLiabilities,
                                                               monthlyAverageIncome,
                                                               familyIncome,
                                                               spouseName,
                                                               spouseCardNum,
                                                               spouseTelephone]];
            self.sections = @[section];
        }
    }];
    
    
}
- (void)blendModel:(ZYCustomerDetailViewModel*)model
{
    RACChannelTo(liveIdentity,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(liveState,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(liveType,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(liveArea,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(totalProperty,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(totalLiabilities,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(monthlyAverageIncome,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(familyIncome,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(spouseName,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(spouseCardNum,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(spouseTelephone,userInteractionEnabled) = RACChannelTo(self,edit);
    
    RACChannelTo(liveIdentity,cellSegmentedSelecedObj) = RACChannelTo(model,liveIdentity);
    RACChannelTo(liveState,selecedObj) = RACChannelTo(model,liveState);
    RACChannelTo(liveType,selecedObj) = RACChannelTo(model,liveType);
    RACChannelTo(liveArea,cellText) = RACChannelTo(model,liveArea);
    RACChannelTo(totalProperty,cellText) = RACChannelTo(model,totalProperty);
    RACChannelTo(totalLiabilities,cellText) = RACChannelTo(model,totalLiabilities);
    RACChannelTo(monthlyAverageIncome,cellText) = RACChannelTo(model,monthlyAverageIncome);
    RACChannelTo(familyIncome,cellText) = RACChannelTo(model,familyIncome);
    RACChannelTo(spouseName,cellText) = RACChannelTo(model,spouseName);
    RACChannelTo(spouseCardNum,cellText) = RACChannelTo(model,spouseCardNum);
    RACChannelTo(spouseTelephone,cellText) = RACChannelTo(model,spouseTelephone);
}
- (NSString*)error
{
    NSArray *errorArr = @[liveIdentity,
                          liveState,
                          liveType,
                          liveArea];
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
