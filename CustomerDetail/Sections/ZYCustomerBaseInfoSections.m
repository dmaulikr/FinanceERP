//
//  ZYCustomerBaseInfoSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/13.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerBaseInfoSections.h"
#import "ZYHeadImageCell.h"

@implementation ZYCustomerBaseInfoSections
{
    ZYHeadImageCell *customerHeadImageCell;
    ZYInputCell *customerNameCell;
    ZYInputCell *customerCardNumCell;
    ZYInputCell *customerTelephoneCell;
    ZYInputCell *customerAddressCell;
    
    ZYTableViewCell *customerDetailCell;
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
    customerHeadImageCell = [ZYHeadImageCell cellWithActionBlock:nil];
    customerHeadImageCell.cellTitle = @"客户头像";
    
    customerNameCell = [ZYInputCell cellWithActionBlock:nil];
    customerNameCell.cellTitle = @"客户名称";
    customerNameCell.cellPlaceHolder = @"请输入客户名称";
    customerNameCell.keyboardReturnType = UIReturnKeyDone;
    
    customerCardNumCell = [ZYInputCell cellWithActionBlock:nil];
    customerCardNumCell.cellTitle = @"身份证号码";
    customerCardNumCell.cellPlaceHolder = @"请输入身份证号码";
    customerCardNumCell.keyboardReturnType = UIReturnKeyDone;
    
    customerTelephoneCell = [ZYInputCell cellWithActionBlock:nil];
    customerTelephoneCell.cellTitle = @"手机号码";
    customerTelephoneCell.cellPlaceHolder = @"请输入手机号码";
    customerTelephoneCell.keyboardReturnType = UIReturnKeyDone;
    customerTelephoneCell.cellRegular = [NSString checkTelephone];
    customerTelephoneCell.maxLength = 11;
    
    customerAddressCell = [ZYInputCell cellWithActionBlock:nil];
    customerAddressCell.cellTitle = @"通讯地址";
    customerAddressCell.cellPlaceHolder = @"请输入通讯地址";
    customerAddressCell.keyboardReturnType = UIReturnKeyDone;
    
    ZYSection *section = [ZYSection sectionWithCells:@[customerHeadImageCell,customerNameCell,customerCardNumCell,customerTelephoneCell,customerAddressCell]];
    
    customerDetailCell = [ZYTableViewCell cellWithActionBlock:^{
        [self detailCellPressed];
    }];
    customerDetailCell.textLabel.text = @"用户详细信息";
    customerDetailCell.textLabel.textColor = TITLE_COLOR;
    customerDetailCell.textLabel.font = FONT(14);
    customerDetailCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    ZYSection *detailSection = [ZYSection sectionWithHeaderTitle:@" " cells:@[customerDetailCell]];
    
    self.sections = @[section,detailSection];
    
    self.returnSignal = [RACSignal merge:@[customerNameCell.returnSignal,
                                           customerCardNumCell.returnSignal,
                                           customerTelephoneCell.returnSignal,
                                           customerAddressCell.returnSignal]];
}
- (void)blendModel:(ZYCustomerBaseInfoViewModel*)model
{
    RACChannelTo(customerHeadImageCell, cellHeadImage) = RACChannelTo(model, headImage);
    RACChannelTo(customerHeadImageCell, cellHeadImageUrl) = RACChannelTo(model, headImageUrl);
    RACChannelTo(customerHeadImageCell, cellUploadSuccess) = RACChannelTo(model,headImageUploadSuccess);
    
    RACChannelTo(customerNameCell, cellText) = RACChannelTo(model, customerName);
    RACChannelTo(customerCardNumCell, cellText) = RACChannelTo(model, customerCardNum);
    RACChannelTo(customerTelephoneCell, cellText) = RACChannelTo(model, customerTelephone);
    RACChannelTo(customerAddressCell, cellText) = RACChannelTo(model, customerAddress);
    
//    RACChannelTo(customerHeadImageCell, userInteractionEnabled) = RACChannelTo(self, edit);
    RACChannelTo(customerNameCell, userInteractionEnabled) = RACChannelTo(self, edit);
    RACChannelTo(customerCardNumCell, userInteractionEnabled) = RACChannelTo(self, edit);
    RACChannelTo(customerTelephoneCell, userInteractionEnabled) = RACChannelTo(self, edit);
    RACChannelTo(customerAddressCell, userInteractionEnabled) = RACChannelTo(self, edit);
}
- (RACSignal*)headImagePickSignal
{
    return customerHeadImageCell.cellHeadImageButtonPressSignal;
}
- (NSString*)error
{
    NSArray *errorArr = @[customerNameCell,
                          customerCardNumCell,
                          customerTelephoneCell,
                          customerAddressCell];
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
- (void)becomeFirstResponder
{
    [customerNameCell becomeFirstResponder];
}
- (void)detailCellPressed{}
- (RACSignal*)detailCellPressedSignal
{
    if(_detailCellPressedSignal==nil)
    {
        _detailCellPressedSignal = [self rac_signalForSelector:@selector(detailCellPressed)];
    }
    return _detailCellPressedSignal;
}

@end
