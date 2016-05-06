//
//  ZYOriginalBankSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYOriginalBankSections.h"

@implementation ZYOriginalBankSections
{
    ZYSelectCell *originalBankNameCell;
    
    ZYInputCell *originalBankLoanMoneyCell;
    ZYInputCell *originalBankDebtCell;
    
    ZYSelectCell *originalBankLoanEndTimeCell;
    
    ZYInputCell *originalBankLinkmanCell;
    ZYInputCell *originalBankTelephoneCell;
    ZYInputCell *originalBankThirdPartyLoanCell;
    ZYInputCell *originalBankThirdPartyCardNumberCell;
    ZYInputCell *originalBankThirdPartyTelephoneCell;
    ZYInputCell *originalBankThirdPartyAddressCell;
    
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
    
    originalBankNameCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        [self cellSearch:originalBankNameCell withDataSourceSignal:[ZYForeclosureHouseViewModel bankSearchSignal] showKey:@"look_desc"];
    }];
    originalBankNameCell.showKey = @"look_desc";
    originalBankNameCell.cellTitle = @"原贷款银行";
    
    originalBankLoanMoneyCell = [ZYInputCell cellWithActionBlock:nil];
    originalBankLoanMoneyCell.cellTitle = @"原贷款金额";
    originalBankLoanMoneyCell.cellPlaceHolder = @"请输入原贷款金额";
    originalBankLoanMoneyCell.onlyFloat = YES;
    originalBankLoanMoneyCell.cellTailText = @"元";
    
    originalBankDebtCell = [ZYInputCell cellWithActionBlock:nil];
    originalBankDebtCell.cellTitle = @"欠款金额";
    originalBankDebtCell.cellPlaceHolder = @"请输入欠款金额";
    originalBankDebtCell.onlyFloat = YES;
    originalBankDebtCell.cellTailText = @"元";
    
    originalBankLoanEndTimeCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        [self cellDatePicker:originalBankLoanEndTimeCell onlyFutura:NO];
    }];
    originalBankLoanEndTimeCell.cellTitle = @"贷款结束时间";
    
    originalBankLinkmanCell = [ZYInputCell cellWithActionBlock:nil];
    originalBankLinkmanCell.cellTitle = @"银行联系人";
    originalBankLinkmanCell.cellPlaceHolder = @"请输入银行联系人";
    originalBankLinkmanCell.cellNullable = YES;
    
    originalBankTelephoneCell = [ZYInputCell cellWithActionBlock:nil];
    originalBankTelephoneCell.cellTitle = @"联系电话";
    originalBankTelephoneCell.cellPlaceHolder = @"联系电话";
    originalBankTelephoneCell.onlyInt = YES;
    originalBankTelephoneCell.maxLength = 11;
    originalBankTelephoneCell.cellRegular = [NSString checkTelephone];
    originalBankTelephoneCell.cellNullable = YES;
    
    originalBankThirdPartyLoanCell = [ZYInputCell cellWithActionBlock:nil];
    originalBankThirdPartyLoanCell.cellTitle = @"第三借款人";
    originalBankThirdPartyLoanCell.cellPlaceHolder = @"请输入第三借款人";
    originalBankThirdPartyLoanCell.cellNullable = YES;
    
    originalBankThirdPartyCardNumberCell = [ZYInputCell cellWithActionBlock:nil];
    originalBankThirdPartyCardNumberCell.cellTitle = @"身份证号";
    originalBankThirdPartyCardNumberCell.cellRegular = [NSString checkCardNum];
    originalBankThirdPartyCardNumberCell.cellPlaceHolder = @"请输入身份证号";
    originalBankThirdPartyCardNumberCell.cellNullable = YES;
    originalBankThirdPartyCardNumberCell.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    originalBankThirdPartyTelephoneCell = [ZYInputCell cellWithActionBlock:nil];
    originalBankThirdPartyTelephoneCell.cellTitle = @"手机号码";
    originalBankThirdPartyTelephoneCell.onlyInt = YES;
    originalBankThirdPartyTelephoneCell.maxLength = 11;
    originalBankThirdPartyTelephoneCell.cellRegular = [NSString checkTelephone];
    originalBankThirdPartyTelephoneCell.cellPlaceHolder = @"请输入手机号码";
    originalBankThirdPartyTelephoneCell.cellNullable = YES;
    
    originalBankThirdPartyAddressCell = [ZYInputCell cellWithActionBlock:nil];
    originalBankThirdPartyAddressCell.cellTitle = @"家庭地址";
    originalBankThirdPartyAddressCell.cellPlaceHolder = @"请输入家庭地址";
    originalBankThirdPartyAddressCell.cellNullable = YES;
    
    footCell = [ZYTableViewCell cellWithStyle:UITableViewCellStyleDefault height:[ZYDoubleButtonCell defaultHeight] actionBlock:nil];
    footCell.selectionStyle = UITableViewCellSelectionStyleNone;
    footCell.lineHidden = YES;

}
- (void)blendModel:(ZYForeclosureHouseViewModel*)model
{
    RACChannelTo(originalBankNameCell,selecedObj) = RACChannelTo(model,originalBankName);

    RACChannelTo(originalBankLoanMoneyCell,cellText) = RACChannelTo(model,originalBankLoanMoney);
    RACChannelTo(originalBankDebtCell,cellText) = RACChannelTo(model,originalBankDebt);
    RACChannelTo(originalBankLoanEndTimeCell,cellText) = RACChannelTo(model,originalBankLoanEndTime);
    
    RACChannelTo(originalBankLinkmanCell,cellText) = RACChannelTo(model,originalBankLinkman);
    RACChannelTo(originalBankTelephoneCell,cellText) = RACChannelTo(model,originalBankTelephone);
    RACChannelTo(originalBankThirdPartyLoanCell,cellText) = RACChannelTo(model,originalBankThirdPartyLoan);
    RACChannelTo(originalBankThirdPartyCardNumberCell,cellText) = RACChannelTo(model,originalBankThirdPartyCardNumber);
    RACChannelTo(originalBankThirdPartyTelephoneCell,cellText) = RACChannelTo(model,originalBankThirdPartyTelephone);
    RACChannelTo(originalBankThirdPartyAddressCell,cellText) = RACChannelTo(model,originalBankThirdPartyAddress);
    
    RAC(originalBankNameCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(originalBankLoanMoneyCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(originalBankDebtCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(originalBankLoanEndTimeCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(originalBankLinkmanCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(originalBankTelephoneCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(originalBankThirdPartyLoanCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(originalBankThirdPartyCardNumberCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(originalBankThirdPartyTelephoneCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(originalBankThirdPartyAddressCell,userInteractionEnabled) = RACObserve(self, edit);
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        ZYSection *section;
        if(self.edit)
        {
            section = [ZYSection sectionWithCells:@[originalBankNameCell,
                                                    originalBankLoanMoneyCell,
                                                    originalBankDebtCell,
                                                    originalBankLoanEndTimeCell,
                                                    originalBankLinkmanCell,
                                                    originalBankTelephoneCell,
                                                    originalBankThirdPartyLoanCell,
                                                    originalBankThirdPartyCardNumberCell,
                                                    originalBankThirdPartyTelephoneCell,
                                                    originalBankThirdPartyAddressCell,
                                                    footCell]];
        }
        else
        {
            section = [ZYSection sectionWithCells:@[originalBankNameCell,
                                                    originalBankLoanMoneyCell,
                                                    originalBankDebtCell,
                                                    originalBankLoanEndTimeCell,
                                                    originalBankLinkmanCell,
                                                    originalBankTelephoneCell,
                                                    originalBankThirdPartyLoanCell,
                                                    originalBankThirdPartyCardNumberCell,
                                                    originalBankThirdPartyTelephoneCell,
                                                    originalBankThirdPartyAddressCell,
                                                    ]];
        }
        self.sections = @[section];
    }];
}
- (NSString*)error
{
    NSArray *errorArr = @[originalBankNameCell,
                          originalBankLoanMoneyCell,
                          originalBankDebtCell,
                          originalBankLoanEndTimeCell,
                          originalBankLinkmanCell,
                          originalBankTelephoneCell,
                          originalBankThirdPartyLoanCell,
                          originalBankThirdPartyCardNumberCell,
                          originalBankThirdPartyTelephoneCell,
                          originalBankThirdPartyAddressCell];
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
