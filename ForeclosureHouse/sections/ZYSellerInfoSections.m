//
//  ZYSellerInfoSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/9.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSellerInfoSections.h"

@implementation ZYSellerInfoSections
{

    ZYInputCell *bothSideInfoBuyerNameCell;
    ZYInputCell *bothSideInfoBuyerCardNumberCell;
    ZYInputCell *bothSideInfoBuyerTelephoneCell;
    ZYInputCell *bothSideInfoBuyerAddressCell;
    
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

    bothSideInfoBuyerNameCell = [ZYInputCell cellWithActionBlock:nil];
    bothSideInfoBuyerNameCell.cellTitle = @"买家名称";
    bothSideInfoBuyerNameCell.cellPlaceHolder = @"请输入买家名称";
    
    bothSideInfoBuyerCardNumberCell = [ZYInputCell cellWithActionBlock:nil];
    bothSideInfoBuyerCardNumberCell.cellTitle = @"身份证号";
    bothSideInfoBuyerCardNumberCell.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    bothSideInfoBuyerCardNumberCell.cellRegular = [NSString checkCardNum];
    bothSideInfoBuyerCardNumberCell.cellPlaceHolder = @"请输入身份证号";
    
    bothSideInfoBuyerTelephoneCell = [ZYInputCell cellWithActionBlock:nil];
    bothSideInfoBuyerTelephoneCell.cellTitle = @"联系电话";
    bothSideInfoBuyerTelephoneCell.cellPlaceHolder = @"请输入联系电话";
    bothSideInfoBuyerTelephoneCell.onlyInt = YES;
    bothSideInfoBuyerTelephoneCell.maxLength = 11;
    
    bothSideInfoBuyerAddressCell = [ZYInputCell cellWithActionBlock:nil];
    bothSideInfoBuyerAddressCell.cellTitle = @"家庭住址";
    bothSideInfoBuyerAddressCell.cellPlaceHolder = @"请输入家庭住址";
    
    footCell = [ZYTableViewCell cellWithStyle:UITableViewCellStyleDefault height:[ZYDoubleButtonCell defaultHeight] actionBlock:nil];
    footCell.selectionStyle = UITableViewCellSelectionStyleNone;
    footCell.lineHidden = YES;
    
}
- (void)blendModel:(ZYForeclosureHouseViewModel*)model
{

    RACChannelTo(bothSideInfoBuyerNameCell,cellText) = RACChannelTo(model,bothSideInfoBuyerName);
    RACChannelTo(bothSideInfoBuyerCardNumberCell,cellText) = RACChannelTo(model,bothSideInfoBuyerCardNumber);
    RACChannelTo(bothSideInfoBuyerTelephoneCell,cellText) = RACChannelTo(model,bothSideInfoBuyerTelephone);
    RACChannelTo(bothSideInfoBuyerAddressCell,cellText) = RACChannelTo(model,bothSideInfoBuyerAddress);
    
    RAC(bothSideInfoBuyerNameCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bothSideInfoBuyerCardNumberCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bothSideInfoBuyerTelephoneCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bothSideInfoBuyerAddressCell,userInteractionEnabled) = RACObserve(self, edit);
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        ZYSection *section;
        if(self.edit)
        {
            section = [ZYSection sectionWithCells:@[bothSideInfoBuyerNameCell,
                                                    bothSideInfoBuyerCardNumberCell,
                                                    bothSideInfoBuyerTelephoneCell,
                                                    bothSideInfoBuyerAddressCell,footCell]];
        }
        else
        {
            section = [ZYSection sectionWithCells:@[bothSideInfoBuyerNameCell,
                                                    bothSideInfoBuyerCardNumberCell,
                                                    bothSideInfoBuyerTelephoneCell,
                                                    bothSideInfoBuyerAddressCell]];
        }
        self.sections = @[section];
    }];
}
- (NSString*)error
{
    NSArray *errorArr = @[bothSideInfoBuyerNameCell,
                          bothSideInfoBuyerCardNumberCell,
                          bothSideInfoBuyerTelephoneCell,
                          bothSideInfoBuyerAddressCell];
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
