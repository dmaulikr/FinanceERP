//
//  ZYCostInfoSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCostInfoSections.h"

@implementation ZYCostInfoSections
{
    ZYSegmentedCell *costInfoChargeTypeCell;
    ZYInputCell *costInfoInterestIncomeCell;//利息收入
    ZYInputCell *costInfoPoundageCell;//手续费
    ZYInputCell *costInfoWaitForCostingCell;//待收费用
    ZYInputCell *costInfoSubsidyCell;//补贴
    ZYInputCell *costInfoCommissionCell;//应付佣金
    
    ZYDoubleButtonCell *buttonCell;
}
- (instancetype)initWithTitle:(NSString *)title
{
    self = [super initWithTitle:title];
    if (self) {
        
    }
    return self;
}
- (void)initSection
{
    costInfoChargeTypeCell = [ZYSegmentedCell cellWithActionBlock:nil];
    costInfoChargeTypeCell.cellSegmentedTitles = [ZYForeclosureHouseValueModel costInfoChargeTypeArr];
    costInfoChargeTypeCell.cellTitle = @"收入方式";
    
    costInfoInterestIncomeCell = [ZYInputCell cellWithActionBlock:nil];
    costInfoInterestIncomeCell.cellTitle = @"利息收入";
    costInfoInterestIncomeCell.cellPlaceHolder = @"请输入利息收入";
    costInfoInterestIncomeCell.onlyFloat = YES;
    costInfoInterestIncomeCell.cellTailText = @"元";
    
    costInfoPoundageCell = [ZYInputCell cellWithActionBlock:nil];
    costInfoPoundageCell.cellTitle = @"手续费";
    costInfoPoundageCell.cellPlaceHolder = @"请输入手续费";
    costInfoPoundageCell.onlyFloat = YES;
    costInfoPoundageCell.cellTailText = @"元";
    
    costInfoWaitForCostingCell = [ZYInputCell cellWithActionBlock:nil];
    costInfoWaitForCostingCell.cellTitle = @"待收费用";
    costInfoWaitForCostingCell.cellPlaceHolder = @"请输入待收费用";
    costInfoWaitForCostingCell.onlyFloat = YES;
    costInfoWaitForCostingCell.cellTailText = @"元";
    
    costInfoSubsidyCell = [ZYInputCell cellWithActionBlock:nil];
    costInfoSubsidyCell.cellTitle = @"补贴";
    costInfoSubsidyCell.cellPlaceHolder = @"请输入补贴";
    costInfoSubsidyCell.onlyFloat = YES;
    costInfoSubsidyCell.cellTailText = @"元";
    
    costInfoCommissionCell = [ZYInputCell cellWithActionBlock:nil];
    costInfoCommissionCell.cellTitle = @"应付佣金";
    costInfoCommissionCell.cellPlaceHolder = @"请输入应付佣金";
    costInfoCommissionCell.onlyFloat = YES;
    costInfoCommissionCell.cellTailText = @"元";
    
    buttonCell = [ZYDoubleButtonCell cellWithActionBlock:nil];
    [buttonCell.rightButtonPressedSignal subscribeNext:^(id x) {
        [self cellNextStep:[self error]];
    }];
    [buttonCell.leftButtonPressedSignal subscribeNext:^(id x) {
        [self cellLastStep];
    }];

}
- (void)blendModel:(ZYForeclosureHouseValueModel*)model
{
    [self initSection];
    RACChannelTo(model,costInfoChargeType) = RACChannelTo(costInfoChargeTypeCell,cellSegmentedSelecedIndex);
    RACChannelTo(model,costInfoInterestIncome) = RACChannelTo(costInfoInterestIncomeCell,cellText);
    RACChannelTo(model,costInfoPoundage) = RACChannelTo(costInfoPoundageCell,cellText);
    RACChannelTo(model,costInfoWaitForCosting) = RACChannelTo(costInfoWaitForCostingCell,cellText);
    RACChannelTo(model,costInfoSubsidy) = RACChannelTo(costInfoSubsidyCell,cellText);
    RACChannelTo(model,costInfoCommission) = RACChannelTo(costInfoCommissionCell,cellText);
    
    RAC(costInfoChargeTypeCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(costInfoInterestIncomeCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(costInfoPoundageCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(costInfoWaitForCostingCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(costInfoSubsidyCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(costInfoCommissionCell,userInteractionEnabled) = RACObserve(self, edit);
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        ZYSection *section;
        if(self.edit)
        {
            section = [ZYSection sectionWithCells:@[costInfoChargeTypeCell,
                                                    costInfoInterestIncomeCell,
                                                    costInfoPoundageCell,
                                                    costInfoWaitForCostingCell,
                                                    costInfoSubsidyCell,
                                                    costInfoCommissionCell,
                                                    buttonCell
                                                    ]];
        }
        else
        {
            section = [ZYSection sectionWithCells:@[costInfoChargeTypeCell,
                                                    costInfoInterestIncomeCell,
                                                    costInfoPoundageCell,
                                                    costInfoWaitForCostingCell,
                                                    costInfoSubsidyCell,
                                                    costInfoCommissionCell,
                                                    ]];
        }
        self.sections = @[section];
    }];
}
- (NSString*)error
{
    NSArray *errorArr = @[costInfoInterestIncomeCell,
                          costInfoPoundageCell,
                          costInfoWaitForCostingCell,
                          costInfoSubsidyCell,
                          costInfoCommissionCell];
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
