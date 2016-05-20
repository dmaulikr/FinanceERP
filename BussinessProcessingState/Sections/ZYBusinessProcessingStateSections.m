//
//  ZYBusinessProcessingStateSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBusinessProcessingStateSections.h"
#import "ZYBussinessProcessingContentCell.h"
#import "ZYSingleButtonCell.h"

@implementation ZYBusinessProcessingStateSections
{
    ZYSelectCell *completeDateCell;
    ZYSelectCell *handlePersonCell;
    ZYInputCell *operratPersonCell;
    ZYInputCell *operratDaysCell;
    ZYInputCell *regulationsDaysCell;
    ZYInputCell *differentsCell;
    ZYBussinessProcessingContentCell *remarkCell;
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
    completeDateCell = [ZYSelectCell cellWithActionBlock:^{
        [self cellDatePicker:completeDateCell onlyFutura:NO];
    }];
    completeDateCell.cellTitle = @"完成时间";
    
    handlePersonCell = [ZYSelectCell cellWithActionBlock:^{
        
    }];
    handlePersonCell.cellTitle = @"办理人";
    
    operratPersonCell = [ZYInputCell cellWithActionBlock:^{
        
    }];
    operratPersonCell.cellTitle = @"操作人";
    
    operratDaysCell = [ZYInputCell cellWithActionBlock:^{
        
    }];
    operratDaysCell.cellTitle = @"操作天数";
    regulationsDaysCell = [ZYInputCell cellWithActionBlock:^{
        
    }];
    regulationsDaysCell.cellTitle = @"规定天数";
    differentsCell = [ZYInputCell cellWithActionBlock:^{
        
    }];
    differentsCell.cellTitle = @"差异";
    remarkCell = [ZYBussinessProcessingContentCell cellWithActionBlock:^{
        
    }];
    remarkCell.cellTitle = @"备注";
    
    buttonCell = [ZYSingleButtonCell cellWithActionBlock:nil];
    buttonCell.buttonTitle = @"提交";
    [buttonCell.buttonPressedSignal subscribeNext:^(id x) {
        [self cellNextStep:[self error] sender:nil];
    }];
    
}
- (void)blendModel:(ZYBusinessProcessingStatePageModel*)model
{
    RACChannelTo(completeDateCell,cellText) = RACChannelTo(model,businessProcessingStatePageFinishDate);
    RACChannelTo(operratPersonCell,cellText) = RACChannelTo(model,businessProcessingStatePageOperrator);
    RACChannelTo(handlePersonCell,cellText) = RACChannelTo(model,businessProcessingStatePageHandler);
    RACChannelTo(operratDaysCell,cellText) = RACChannelTo(model,businessProcessingStatePageHandleDays);
    RACChannelTo(regulationsDaysCell,cellText) = RACChannelTo(model,businessProcessingStatePageRegulationsDays);
    RACChannelTo(differentsCell,cellText) = RACChannelTo(model,businessProcessingStatePageDifferents);
    RACChannelTo(remarkCell,cellContent) = RACChannelTo(model,businessProcessingStatePageRemark);
    
    RACChannelTo(completeDateCell,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(handlePersonCell,userInteractionEnabled) = RACChannelTo(self,edit);
//    RACChannelTo(handleDaysCell,userInteractionEnabled) = RACChannelTo(self,edit);
//    RACChannelTo(regulationsDaysCell,userInteractionEnabled) = RACChannelTo(self,edit);
//    RACChannelTo(differentsCell,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(remarkCell,userInteractionEnabled) = RACChannelTo(self,edit);
    
    operratPersonCell.userInteractionEnabled = NO;//操作人
    operratDaysCell.userInteractionEnabled = NO;//操作天数
    regulationsDaysCell.userInteractionEnabled = NO;
    differentsCell.userInteractionEnabled = NO;
    operratPersonCell.userInteractionEnabled = NO;
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        if(self.edit)
        {
            ZYSection *section = [ZYSection sectionWithCells:@[completeDateCell,
//                                                               handlePersonCell,
                                                               operratPersonCell,
                                                               operratDaysCell,
                                                               regulationsDaysCell,
                                                               differentsCell,
                                                               remarkCell,buttonCell]];
            self.sections = @[section];
        }
        else
        {
            ZYSection *section = [ZYSection sectionWithCells:@[completeDateCell,
//                                                               handlePersonCell,
                                                               operratPersonCell,
                                                               operratDaysCell,
                                                               regulationsDaysCell,
                                                               differentsCell,
                                                               remarkCell]];
            self.sections = @[section];
        }
    }];
}
- (NSString*)error
{
    NSArray *errorArr = @[completeDateCell,
//                          handlePersonCell,
                          ];
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
