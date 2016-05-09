//
//  ZYBuyerInfoSections.m
//  
//
//  Created by zhangyu on 16/5/9.
//
//

#import "ZYBuyerInfoSections.h"

@implementation ZYBuyerInfoSections
{
    ZYInputCell *bothSideInfoSellerNameCell;
    ZYInputCell *bothSideInfoSellerCardNumberCell;
    ZYInputCell *bothSideInfoSellerTelephoneCell;
    ZYInputCell *bothSideInfoSellerAddressCell;
    
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
    bothSideInfoSellerNameCell = [ZYInputCell cellWithActionBlock:nil];
    bothSideInfoSellerNameCell.cellTitle = @"卖家名称";
    bothSideInfoSellerNameCell.cellPlaceHolder = @"请输入卖家名称";
    
    bothSideInfoSellerCardNumberCell = [ZYInputCell cellWithActionBlock:nil];
    bothSideInfoSellerCardNumberCell.cellTitle = @"身份证号";
    bothSideInfoSellerCardNumberCell.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    bothSideInfoSellerCardNumberCell.cellRegular = [NSString checkCardNum];
    bothSideInfoSellerCardNumberCell.cellPlaceHolder = @"请输入身份证号";
    
    bothSideInfoSellerTelephoneCell = [ZYInputCell cellWithActionBlock:nil];
    bothSideInfoSellerTelephoneCell.cellTitle = @"联系电话";
    bothSideInfoSellerTelephoneCell.cellPlaceHolder = @"请输入联系电话";
    bothSideInfoSellerTelephoneCell.onlyInt = YES;
    bothSideInfoSellerTelephoneCell.maxLength = 11;
    
    bothSideInfoSellerAddressCell = [ZYInputCell cellWithActionBlock:nil];
    bothSideInfoSellerAddressCell.cellTitle = @"家庭住址";
    bothSideInfoSellerAddressCell.cellPlaceHolder = @"请输入家庭住址";
    
    
    footCell = [ZYTableViewCell cellWithStyle:UITableViewCellStyleDefault height:[ZYDoubleButtonCell defaultHeight] actionBlock:nil];
    footCell.selectionStyle = UITableViewCellSelectionStyleNone;
    footCell.lineHidden = YES;
    
}
- (void)blendModel:(ZYForeclosureHouseViewModel*)model
{
    RACChannelTo(bothSideInfoSellerNameCell,cellText) = RACChannelTo(model,bothSideInfoSellerName);
    RACChannelTo(bothSideInfoSellerCardNumberCell,cellText) = RACChannelTo(model,bothSideInfoSellerCardNumber);
    RACChannelTo(bothSideInfoSellerTelephoneCell,cellText) = RACChannelTo(model,bothSideInfoSellerTelephone);
    RACChannelTo(bothSideInfoSellerAddressCell,cellText) = RACChannelTo(model,bothSideInfoSellerAddress);
    
    RAC(bothSideInfoSellerNameCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bothSideInfoSellerCardNumberCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bothSideInfoSellerTelephoneCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bothSideInfoSellerAddressCell,userInteractionEnabled) = RACObserve(self, edit);

    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        ZYSection *section;
        if(self.edit)
        {
            section = [ZYSection sectionWithCells:@[bothSideInfoSellerNameCell,
                                                    bothSideInfoSellerCardNumberCell,
                                                    bothSideInfoSellerTelephoneCell,
                                                    bothSideInfoSellerAddressCell,
                                                    footCell]];
        }
        else
        {
            section = [ZYSection sectionWithCells:@[bothSideInfoSellerNameCell,
                                                    bothSideInfoSellerCardNumberCell,
                                                    bothSideInfoSellerTelephoneCell,
                                                    bothSideInfoSellerAddressCell]];
        }
        self.sections = @[section];
    }];
}
- (NSString*)error
{
    NSArray *errorArr = @[bothSideInfoSellerNameCell,
                          bothSideInfoSellerCardNumberCell,
                          bothSideInfoSellerTelephoneCell,
                          bothSideInfoSellerAddressCell];
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
