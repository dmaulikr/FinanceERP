//
//  ZYApplicationSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYApplicationSections.h"

#import "ZYForeclosureHouseApplicationContentCell.h"

@implementation ZYApplicationSections
{
    ZYSelectCell *applicationDateCell;
    ZYInputCell *applicationLinkmanCell;
    ZYInputCell *applicationTelephoneCell;
    ZYForeclosureHouseApplicationContentCell *applicationExplainCell;
    ZYForeclosureHouseApplicationContentCell *applicationRemarksCell;
    
    ZYSeveralButtonCell *buttonCell;
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
    applicationDateCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        [self cellDatePicker:applicationDateCell onlyFutura:YES];
    }];
    applicationDateCell.cellTitle = @"申请日期";
    
    applicationLinkmanCell = [ZYInputCell cellWithActionBlock:nil];
    applicationLinkmanCell.cellTitle = @"联系人";
    applicationLinkmanCell.maxLength = 5;
    applicationLinkmanCell.cellPlaceHolder = @"请输入联系人";
    
    applicationTelephoneCell = [ZYInputCell cellWithActionBlock:nil];
    applicationTelephoneCell.cellTitle = @"联系电话";
    applicationTelephoneCell.onlyInt = YES;
    applicationTelephoneCell.maxLength = 11;
    applicationTelephoneCell.cellRegular = [NSString checkTelephone];
    applicationTelephoneCell.cellPlaceHolder = @"请输入联系电话";
    
    applicationExplainCell = [ZYForeclosureHouseApplicationContentCell cellWithActionBlock:nil];
    applicationExplainCell.cellTitle = @"特殊说明";
    
    applicationRemarksCell = [ZYForeclosureHouseApplicationContentCell cellWithActionBlock:nil];
    applicationRemarksCell.cellTitle = @"备注";
    
    buttonCell = [ZYSeveralButtonCell cellWithActionBlock:nil];
    [buttonCell.rightButtonPressedSignal subscribeNext:^(id x) {
        [self submit:[self error]];
    }];
    [buttonCell.midButtonPressedSignal subscribeNext:^(id x) {
        [self save:[self error]];
    }];
    [buttonCell.leftButtonPressedSignal subscribeNext:^(id x) {
        [self cellLastStep];
    }];

}
- (void)blendModel:(ZYForeclosureHouseValueModel*)model
{
    [self initSection];
    RACChannelTo(model,applicationDate) = RACChannelTo(applicationDateCell,selecedObj);
    RACChannelTo(model,applicationLinkman) = RACChannelTo(applicationLinkmanCell,cellText);
    RACChannelTo(model,applicationTelephone) = RACChannelTo(applicationTelephoneCell,cellText);
    RACChannelTo(model,applicationExplain) = RACChannelTo(applicationExplainCell,cellContent);
    RACChannelTo(model,applicationRemarks) = RACChannelTo(applicationRemarksCell,cellContent);
    
    RAC(applicationDateCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(applicationLinkmanCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(applicationTelephoneCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(applicationExplainCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(applicationRemarksCell,userInteractionEnabled) = RACObserve(self, edit);
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        ZYSection *section;
        if(self.edit)
        {
            section = [ZYSection sectionWithCells:@[applicationDateCell,
                                                    applicationLinkmanCell,
                                                    applicationTelephoneCell,
                                                    applicationExplainCell,
                                                    applicationRemarksCell,buttonCell]];
        }
        else
        {
            section = [ZYSection sectionWithCells:@[applicationDateCell,
                                                    applicationLinkmanCell,
                                                    applicationTelephoneCell,
                                                    applicationExplainCell,
                                                    applicationRemarksCell]];
        }
        self.sections = @[section];
    }];
}
- (void)save:(NSString*)error{}
- (RACSignal*)saveSignal
{
    if(_saveSignal==nil)
    {
        _saveSignal = [self rac_signalForSelector:@selector(save:)];
    }
    return _saveSignal;
}
- (void)submit:(NSString*)error{}
- (RACSignal*)submitSignal
{
    if(_submitSignal==nil)
    {
        _submitSignal = [self rac_signalForSelector:@selector(submit:)];
    }
    return _submitSignal;
}
- (NSString*)error
{
    NSArray *errorArr = @[applicationDateCell,
                          applicationLinkmanCell,
                          applicationTelephoneCell];
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
