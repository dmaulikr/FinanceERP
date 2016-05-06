//
//  ZYHousePropertyInfoSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYHousePropertyInfoSections.h"

@implementation ZYHousePropertyInfoSections
{
    ZYInputCell *housePropertyInfoName;
    ZYInputCell *housePropertyInfoArea;
    ZYInputCell *housePropertyInfoOrigePrice;
    ZYInputCell *housePropertyInfoHousePropertyCardNumber;
    ZYInputCell *housePropertyInfoDealPrice;
    ZYInputCell *housePropertyInfoAssessmentPrice;
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
    housePropertyInfoName = [ZYInputCell cellWithActionBlock:nil];
    housePropertyInfoName.cellTitle = @"物业名称";
    housePropertyInfoName.cellPlaceHolder = @"请输入物业名称";
    
    housePropertyInfoArea = [ZYInputCell cellWithActionBlock:nil];
    housePropertyInfoArea.cellTitle = @"面积";
    housePropertyInfoArea.cellPlaceHolder = @"请输入面积";
    housePropertyInfoArea.cellTailText = @"平米";
    housePropertyInfoArea.onlyFloat = YES;
    
    housePropertyInfoOrigePrice = [ZYInputCell cellWithActionBlock:nil];
    housePropertyInfoOrigePrice.cellTitle = @"原价";
    housePropertyInfoOrigePrice.cellPlaceHolder = @"请输入原价";
    housePropertyInfoOrigePrice.cellTailText = @"元";
    housePropertyInfoOrigePrice.onlyFloat = YES;
    
    housePropertyInfoHousePropertyCardNumber = [ZYInputCell cellWithActionBlock:nil];
    housePropertyInfoHousePropertyCardNumber.cellTitle = @"房产证号";
    housePropertyInfoHousePropertyCardNumber.cellPlaceHolder = @"请输入房产证号";
    housePropertyInfoHousePropertyCardNumber.onlyInt = YES;
    
    housePropertyInfoDealPrice = [ZYInputCell cellWithActionBlock:nil];
    housePropertyInfoDealPrice.cellTitle = @"成交价";
    housePropertyInfoDealPrice.cellPlaceHolder = @"请输入成交价";
    housePropertyInfoDealPrice.onlyFloat = YES;
    housePropertyInfoDealPrice.cellTailText = @"元";
    
    housePropertyInfoAssessmentPrice = [ZYInputCell cellWithActionBlock:nil];
    housePropertyInfoAssessmentPrice.cellTitle = @"评估价";
    housePropertyInfoAssessmentPrice.cellPlaceHolder = @"请输入评估价";
    housePropertyInfoAssessmentPrice.onlyFloat = YES;
    housePropertyInfoAssessmentPrice.cellTailText = @"元";
    
    footCell = [ZYTableViewCell cellWithStyle:UITableViewCellStyleDefault height:[ZYDoubleButtonCell defaultHeight] actionBlock:nil];
    footCell.selectionStyle = UITableViewCellSelectionStyleNone;
    footCell.lineHidden = YES;

}
- (void)blendModel:(ZYForeclosureHouseViewModel*)model
{

    RACChannelTo(housePropertyInfoName,cellText) = RACChannelTo(model,housePropertyInfoName);
    RACChannelTo(housePropertyInfoArea,cellText) = RACChannelTo(model,housePropertyInfoArea);
    RACChannelTo(housePropertyInfoOrigePrice,cellText) = RACChannelTo(model,housePropertyInfoOrigePrice);
    RACChannelTo(housePropertyInfoHousePropertyCardNumber,cellText) = RACChannelTo(model,housePropertyInfoHousePropertyCardNumber);
    RACChannelTo(housePropertyInfoDealPrice,cellText) = RACChannelTo(model,housePropertyInfoDealPrice);
    RACChannelTo(housePropertyInfoAssessmentPrice,cellText) = RACChannelTo(model,housePropertyInfoAssessmentPrice);
    
    RAC(housePropertyInfoName,userInteractionEnabled) = RACObserve(self, edit);
    RAC(housePropertyInfoArea,userInteractionEnabled) = RACObserve(self, edit);
    RAC(housePropertyInfoOrigePrice,userInteractionEnabled) = RACObserve(self, edit);
    RAC(housePropertyInfoHousePropertyCardNumber,userInteractionEnabled) = RACObserve(self, edit);
    RAC(housePropertyInfoDealPrice,userInteractionEnabled) = RACObserve(self, edit);
    RAC(housePropertyInfoAssessmentPrice,userInteractionEnabled) = RACObserve(self, edit);
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        ZYSection *section;
        if(self.edit)
        {
            section = [ZYSection sectionWithCells:@[housePropertyInfoName,
                                                    housePropertyInfoArea,
                                                    housePropertyInfoOrigePrice,
                                                    housePropertyInfoHousePropertyCardNumber,
                                                    housePropertyInfoDealPrice,
                                                    housePropertyInfoAssessmentPrice,
                                                    footCell]];
            
        }
        else
        {
            section = [ZYSection sectionWithCells:@[housePropertyInfoName,
                                                    housePropertyInfoArea,
                                                    housePropertyInfoOrigePrice,
                                                    housePropertyInfoHousePropertyCardNumber,
                                                    housePropertyInfoDealPrice,
                                                    housePropertyInfoAssessmentPrice]];
        }
        self.sections = @[section];

    }];
}
- (NSString*)error
{
    NSArray *errorArr = @[housePropertyInfoName,
                          housePropertyInfoArea,
                          housePropertyInfoOrigePrice,
                          housePropertyInfoHousePropertyCardNumber,
                          housePropertyInfoDealPrice,
                          housePropertyInfoAssessmentPrice];
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
