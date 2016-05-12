//
//  ZYBusinessProcessingStateSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBusinessProcessingStateSections.h"
#import "ZYBussinessProcessingContentCell.h"

@implementation ZYBusinessProcessingStateSections
{
    ZYSelectCell *completeDateCell;
    ZYInputCell *operratPersonCell;
    ZYInputCell *handlePersonCell;
    ZYInputCell *handleDaysCell;
    ZYInputCell *regulationsDaysCell;
    ZYInputCell *differentsCell;
    ZYBussinessProcessingContentCell *remarkCell;
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
    operratPersonCell = [ZYInputCell cellWithActionBlock:^{
        
    }];
    operratPersonCell.cellTitle = @"办理人";
    handlePersonCell = [ZYInputCell cellWithActionBlock:^{
        
    }];
    handlePersonCell.cellTitle = @"操作人";
    handleDaysCell = [ZYInputCell cellWithActionBlock:^{
        
    }];
    handleDaysCell.cellTitle = @"操作天数";
    regulationsDaysCell = [ZYInputCell cellWithActionBlock:^{
        
    }];
    regulationsDaysCell.cellTitle = @"规定天数";
    differentsCell = [ZYInputCell cellWithActionBlock:^{
        
    }];
    differentsCell.cellTitle = @"差异";
    remarkCell = [ZYBussinessProcessingContentCell cellWithActionBlock:^{
        
    }];
    remarkCell.cellTitle = @"备注";
    ZYSection *section = [ZYSection sectionWithCells:@[completeDateCell,
                                                       operratPersonCell,
                                                       handlePersonCell,
                                                       handleDaysCell,
                                                       regulationsDaysCell,
                                                       differentsCell,
                                                       remarkCell]];
    self.sections = @[section];
}
- (void)blendModel:(ZYBusinessProcessingStatePageModel*)model
{
    RACChannelTo(completeDateCell,cellText) = RACChannelTo(model,businessProcessingStatePageFinishDate);
    RACChannelTo(operratPersonCell,cellText) = RACChannelTo(model,businessProcessingStatePageOperrator);
    RACChannelTo(handlePersonCell,cellText) = RACChannelTo(model,businessProcessingStatePageHandler);
    RACChannelTo(handleDaysCell,cellText) = RACChannelTo(model,businessProcessingStatePageHandleDays);
    RACChannelTo(regulationsDaysCell,cellText) = RACChannelTo(model,businessProcessingStatePageRegulationsDays);
    RACChannelTo(differentsCell,cellText) = RACChannelTo(model,businessProcessingStatePageDifferents);
    RACChannelTo(remarkCell,cellContent) = RACChannelTo(model,businessProcessingStatePageRemark);
    
    RACChannelTo(completeDateCell,userInteractionEnabled) = RACChannelTo(self,edit);
//    RACChannelTo(operratPersonCell,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(handlePersonCell,userInteractionEnabled) = RACChannelTo(self,edit);
//    RACChannelTo(handleDaysCell,userInteractionEnabled) = RACChannelTo(self,edit);
//    RACChannelTo(regulationsDaysCell,userInteractionEnabled) = RACChannelTo(self,edit);
//    RACChannelTo(differentsCell,userInteractionEnabled) = RACChannelTo(self,edit);
    RACChannelTo(remarkCell,userInteractionEnabled) = RACChannelTo(self,edit);
    handleDaysCell.userInteractionEnabled = NO;
    regulationsDaysCell.userInteractionEnabled = NO;
    differentsCell.userInteractionEnabled = NO;
    operratPersonCell.userInteractionEnabled = NO;
}
@end
