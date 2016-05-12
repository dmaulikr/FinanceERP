//
//  ZYCurrentBankSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCurrentBankSections.h"

@implementation ZYCurrentBankSections
{
    ZYSelectCell *newBankCell;
    ZYInputCell *newBankLoanMoneyCell;
    ZYInputCell *newBankLinkmanCell;
    ZYInputCell *newBankTelephoneCell;
    ZYSegmentedCell *newBankLoanTypeCell;
    
    ZYInputCell *newBankForeclosureAccountCell;
    ZYSelectCell *newBankPublicFundBankCell;
    ZYInputCell *newBankPublicFundMoneyCell;
    
    ZYSelectCell *newBankSuperviseOrganizationCell;
    ZYInputCell *newBankSuperviseMoneyCell;
    ZYInputCell *newBankSuperviseAccountCell;
    
    ZYSelectCell *newBankJusticeDateCell;
    ZYSelectCell *newBankContractDateCell;
    
    ZYTableViewCell *footCell;
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
    @weakify(self)
    newBankCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        [self cellSearch:newBankCell withDataSourceSignal:[ZYForeclosureHouseViewModel bankSearchSignal] showKey:@"look_desc"];
    }];
    newBankCell.showKey = @"look_desc";
    newBankCell.cellTitle = @"新贷款银行";
    
    newBankLoanMoneyCell = [ZYInputCell cellWithActionBlock:nil];
    newBankLoanMoneyCell.cellTitle = @"新贷款金额";
    newBankLoanMoneyCell.onlyFloat = YES;
    newBankLoanMoneyCell.maxLength = 11;
    newBankLoanMoneyCell.cellTailText = @"元";
    newBankLoanMoneyCell.cellPlaceHolder = @"请输入新贷款金额";
    
    newBankLinkmanCell = [ZYInputCell cellWithActionBlock:nil];
    newBankLinkmanCell.cellTitle = @"银行联系人";
    newBankLinkmanCell.cellNullable = YES;
    newBankLinkmanCell.cellPlaceHolder = @"请输入银行联系人";
    
    newBankTelephoneCell = [ZYInputCell cellWithActionBlock:nil];
    newBankTelephoneCell.cellTitle = @"联系电话";
    newBankTelephoneCell.maxLength = 11;
    newBankTelephoneCell.cellRegular = [NSString checkTelephone];
    newBankTelephoneCell.cellNullable = YES;
    newBankTelephoneCell.onlyInt = YES;
    newBankTelephoneCell.cellPlaceHolder = @"请输入联系电话";
    
    newBankLoanTypeCell = [ZYSegmentedCell cellWithActionBlock:nil];
    newBankLoanTypeCell.cellTitle = @"贷款方式";
    newBankLoanTypeCell.showKey = @"title";
    [[ZYForeclosureHouseViewModel loanTypeArrSignal] subscribeNext:^(NSArray *arr) {
        newBankLoanTypeCell.cellSegmentedArr = arr;
    }];
    
    
    newBankForeclosureAccountCell = [ZYInputCell cellWithActionBlock:nil];
    newBankForeclosureAccountCell.cellTitle = @"赎楼账号";
    newBankForeclosureAccountCell.maxLength = 20;
    newBankForeclosureAccountCell.cellPlaceHolder = @"请输入赎楼账号";
    newBankForeclosureAccountCell.onlyInt = YES;
    
    newBankPublicFundBankCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        [self cellSearch:newBankPublicFundBankCell withDataSourceSignal:[ZYForeclosureHouseViewModel bankSearchSignal] showKey:@"look_desc"];
    }];
    newBankPublicFundBankCell.showKey = @"look_desc";
    newBankPublicFundBankCell.cellTitle = @"公积金银行";
    newBankPublicFundBankCell.cellNullable = YES;
    
    newBankPublicFundMoneyCell = [ZYInputCell cellWithActionBlock:nil];
    newBankPublicFundMoneyCell.cellTitle = @"公积金贷款额";
    newBankPublicFundMoneyCell.onlyFloat = YES;
    newBankPublicFundMoneyCell.maxLength = 11;
    newBankPublicFundMoneyCell.cellNullable = YES;
    newBankPublicFundMoneyCell.cellPlaceHolder = @"请输入公积金贷款金额";
    
    newBankSuperviseOrganizationCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        [self cellSearch:newBankSuperviseOrganizationCell withDataSourceSignal:[ZYForeclosureHouseViewModel bankSearchSignal] showKey:@"look_desc"];
    }];
    newBankSuperviseOrganizationCell.showKey = @"look_desc";
    newBankSuperviseOrganizationCell.cellTitle = @"资金监管银行";
    
    newBankSuperviseMoneyCell = [ZYInputCell cellWithActionBlock:nil];
    newBankSuperviseMoneyCell.cellTitle = @"资金监管金额";
    newBankSuperviseMoneyCell.onlyFloat = YES;
    newBankSuperviseMoneyCell.maxLength = 11;
    newBankSuperviseMoneyCell.cellPlaceHolder = @"请输入资金监管金额";
    
    newBankSuperviseAccountCell = [ZYInputCell cellWithActionBlock:nil];
    newBankSuperviseAccountCell.cellTitle = @"资金监管帐号";
    newBankSuperviseAccountCell.onlyInt = YES;
    newBankSuperviseAccountCell.maxLength = 20;
    newBankSuperviseAccountCell.cellPlaceHolder = @"请输入资金监管帐号";
    
    newBankJusticeDateCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        [self cellDatePicker:newBankJusticeDateCell onlyFutura:NO];
    }];
    newBankJusticeDateCell.cellTitle = @"委托公证日期";
    
    newBankContractDateCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        [self cellDatePicker:newBankContractDateCell onlyFutura:NO];
    }];
    newBankContractDateCell.cellTitle = @"签署合同日期";
    
    
    footCell = [ZYTableViewCell cellWithStyle:UITableViewCellStyleDefault height:[ZYDoubleButtonCell defaultHeight] actionBlock:nil];
    footCell.selectionStyle = UITableViewCellSelectionStyleNone;
    footCell.lineHidden = YES;

}
- (void)blendModel:(ZYForeclosureHouseViewModel*)model
{
    RACChannelTo(newBankCell,selecedObj) = RACChannelTo(model,bank);
    RACChannelTo(newBankLoanTypeCell,cellSegmentedSelecedObj) = RACChannelTo(model,bankLoanType);
    RACChannelTo(newBankPublicFundBankCell,selecedObj) = RACChannelTo(model,bankPublicFundBank);
    RACChannelTo(newBankJusticeDateCell,cellText) = RACChannelTo(model,bankJusticeDate);
    RACChannelTo(newBankContractDateCell,cellText) = RACChannelTo(model,bankContractDate);
    RACChannelTo(newBankLoanMoneyCell,cellText) = RACChannelTo(model,bankLoanMoney);
    RACChannelTo(newBankLinkmanCell,cellText) = RACChannelTo(model,bankLinkman);
    RACChannelTo(newBankTelephoneCell,cellText) = RACChannelTo(model,bankTelephone);
    RACChannelTo(newBankForeclosureAccountCell,cellText) = RACChannelTo(model,bankForeclosureAccount);
    RACChannelTo(newBankPublicFundMoneyCell,cellText) = RACChannelTo(model,bankPublicFundMoney);
    RACChannelTo(newBankSuperviseOrganizationCell,selecedObj) = RACChannelTo(model,bankSuperviseOrganization);
    RACChannelTo(newBankSuperviseMoneyCell,cellText) = RACChannelTo(model,bankSuperviseMoney);
    RACChannelTo(newBankSuperviseAccountCell,cellText) = RACChannelTo(model,bankSuperviseAccount);
    
    RAC(newBankCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(newBankLoanTypeCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(newBankPublicFundBankCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(newBankJusticeDateCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(newBankContractDateCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(newBankLinkmanCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(newBankLoanMoneyCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(newBankTelephoneCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(newBankForeclosureAccountCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(newBankPublicFundMoneyCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(newBankSuperviseOrganizationCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(newBankSuperviseMoneyCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(newBankSuperviseAccountCell,userInteractionEnabled) = RACObserve(self, edit);
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        ZYSection *section;
        if(self.edit)
        {
            section = [ZYSection sectionWithCells:@[newBankCell,
                                                    newBankLoanMoneyCell,
                                                    newBankLinkmanCell,
                                                    newBankTelephoneCell,
                                                    newBankLoanTypeCell,
                                                    newBankForeclosureAccountCell,
                                                    newBankPublicFundBankCell,
                                                    newBankPublicFundMoneyCell,
                                                    newBankSuperviseOrganizationCell,
                                                    newBankSuperviseMoneyCell,
                                                    newBankSuperviseAccountCell,
                                                    newBankJusticeDateCell,
                                                    newBankContractDateCell,footCell]];
        }
        else
        {
            section = [ZYSection sectionWithCells:@[newBankCell,
                                                    newBankLoanMoneyCell,
                                                    newBankLinkmanCell,
                                                    newBankTelephoneCell,
                                                    newBankLoanTypeCell,
                                                    newBankForeclosureAccountCell,
                                                    newBankPublicFundBankCell,
                                                    newBankPublicFundMoneyCell,
                                                    newBankSuperviseOrganizationCell,
                                                    newBankSuperviseMoneyCell,
                                                    newBankSuperviseAccountCell,
                                                    newBankJusticeDateCell,
                                                    newBankContractDateCell]];
        }
        self.sections = @[section];
    }];
}
- (NSString*)error
{
    NSArray *errorArr = @[newBankCell,
                          newBankLoanMoneyCell,
                          newBankLinkmanCell,
                          newBankTelephoneCell,
                          newBankLoanTypeCell,
                          newBankForeclosureAccountCell,
                          newBankPublicFundBankCell,
                          newBankPublicFundMoneyCell,
                          newBankSuperviseOrganizationCell,
                          newBankSuperviseMoneyCell,
                          newBankSuperviseAccountCell,
                          newBankJusticeDateCell,
                          newBankContractDateCell,];
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
