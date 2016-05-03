//
//  ZYApplyInfoSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYApplyInfoSections.h"

@implementation ZYApplyInfoSections
{
    ZYInputCell *applyInfoBorrowerNameCell;
    ZYInputCell *applyInfoBorrowerCardNumberCell;
    ZYInputCell *applyInfoBorrowerTelphoneCell;
    ZYInputCell *applyInfoHousePropertyCardNumberCell;
    ZYInputCell *applyInfoAddressCell;
    
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
    @weakify(self)
    applyInfoBorrowerNameCell = [ZYInputCell cellWithActionBlock:^{
        @strongify(self)
        applyInfoBorrowerNameCell.showKey = @"name";
        [self cellSearch:applyInfoBorrowerNameCell withDataSourceSignal:[ZYForeclosureHouseValueModel borrowersSignal] showKey:@"name"];
    }];
    applyInfoBorrowerNameCell.cellTitle = @"借款人";
    applyInfoBorrowerNameCell.cellPlaceHolder = @"请输入或者选择借款人";
    applyInfoBorrowerNameCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    applyInfoBorrowerNameCell.maxLength = 5;
    
    applyInfoBorrowerCardNumberCell = [ZYInputCell cellWithActionBlock:nil];
    applyInfoBorrowerCardNumberCell.cellTitle = @"身份证号";
    applyInfoBorrowerCardNumberCell.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    applyInfoBorrowerCardNumberCell.cellRegular = [NSString checkCardNum];
    applyInfoBorrowerCardNumberCell.cellPlaceHolder = @"请输入身份证号";
    
    applyInfoBorrowerTelphoneCell = [ZYInputCell cellWithActionBlock:nil];
    applyInfoBorrowerTelphoneCell.cellTitle = @"联系电话";
    applyInfoBorrowerTelphoneCell.cellPlaceHolder = @"请输入联系电话";
    
    applyInfoHousePropertyCardNumberCell = [ZYInputCell cellWithActionBlock:nil];
    applyInfoHousePropertyCardNumberCell.cellTitle = @"房产证号";
    applyInfoHousePropertyCardNumberCell.onlyInt = YES;
    applyInfoHousePropertyCardNumberCell.cellPlaceHolder = @"请输入房产证号";
    
    applyInfoAddressCell = [ZYInputCell cellWithActionBlock:nil];
    applyInfoAddressCell.cellTitle = @"联系地址";
    applyInfoAddressCell.cellPlaceHolder = @"请输入联系地址";
    
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
    RACChannelTo(model,applyInfoBorrowerName) = RACChannelTo(applyInfoBorrowerNameCell,cellText);
    
    RACChannelTo(model,applyInfoBorrowerCardNumber) = RACChannelTo(applyInfoBorrowerCardNumberCell,cellText);
    RACChannelTo(model,applyInfoBorrowerTelphone) = RACChannelTo(applyInfoBorrowerTelphoneCell,cellText);
    RACChannelTo(model,applyInfoHousePropertyCardNumber) = RACChannelTo(applyInfoHousePropertyCardNumberCell,cellText);
    RACChannelTo(model,applyInfoAddress) = RACChannelTo(applyInfoAddressCell,cellText);
    
    [RACObserve(applyInfoBorrowerNameCell, selecedObj) subscribeNext:^(id x) {
       if([x isKindOfClass:[ZYBorrowerModel class]])
       {
           model.applyInfoBorrowerCardNumber = [(ZYBorrowerModel*)x cardNumber];
           model.applyInfoBorrowerTelphone = [(ZYBorrowerModel*)x telephone];
       }
    }];
    
    RAC(applyInfoBorrowerNameCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(applyInfoBorrowerCardNumberCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(applyInfoBorrowerTelphoneCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(applyInfoHousePropertyCardNumberCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(applyInfoAddressCell,userInteractionEnabled) = RACObserve(self, edit);
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        ZYSection *section;
        if(self.edit)
        {
            section = [ZYSection sectionWithCells:@[applyInfoBorrowerNameCell,
                                                    applyInfoBorrowerCardNumberCell,
                                                    applyInfoBorrowerTelphoneCell,
                                                    applyInfoHousePropertyCardNumberCell,
                                                    applyInfoAddressCell,
                                                    buttonCell]];
        }
        else
        {
            section = [ZYSection sectionWithCells:@[applyInfoBorrowerNameCell,
                                                    applyInfoBorrowerCardNumberCell,
                                                    applyInfoBorrowerTelphoneCell,
                                                    applyInfoHousePropertyCardNumberCell,
                                                    applyInfoAddressCell]];
        }
        self.sections = @[section];
    }];
}
- (NSString*)error
{
    NSArray *errorArr = @[applyInfoBorrowerNameCell,
                          applyInfoBorrowerCardNumberCell,
                          applyInfoBorrowerTelphoneCell,
                          applyInfoHousePropertyCardNumberCell,
                          applyInfoAddressCell];
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
