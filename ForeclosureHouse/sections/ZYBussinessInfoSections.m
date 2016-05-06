//
//  ZYBussinessInfoSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBussinessInfoSections.h"

@implementation ZYBussinessInfoSections
{
    ZYSelectCell *bussinessInfoComeFromTypeCell;
    ZYSelectCell *bussinessInfoComeFromTypeSubCell;
    
    ZYInputCell *bussinessInfoAreaCell;
    ZYInputCell *bussinessInfoLoanMoneyCell;
    ZYInputCell *bussinessInfoDaysCell;
    ZYSelectCell *bussinessInfoDateCell;
    ZYInputCell *bussinessInfoAccountCell;
    ZYInputCell *bussinessInfoUsernameCell;
    ZYInputCell *bussinessInfoLinkmanCell;
    ZYInputCell *bussinessInfoTelephoneCell;
    ZYSegmentedCell *bussinessInfoOrderTypeCell;
    ZYSegmentedCell *bussinessInfoTransactionTypeCell;
    
    ZYSingleButtonCell *buttonCell;
    
    ZYSection *comeFromTypeSection;
    ZYSection *comeFromTypeSubSection;

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
    bussinessInfoComeFromTypeCell = [ZYSelectCell cellWithActionBlock:^{
        [self cellPicker:bussinessInfoComeFromTypeCell withDataSourceSignal:[ZYForeclosureHouseViewModel foreclosureHouseBussinessInfoComeFromArrSignal] showKey:@"title"];
    }];
    bussinessInfoComeFromTypeCell.showKey = @"title";
    bussinessInfoComeFromTypeCell.cellTitle = @"业务来源";
    
    @weakify(self)
    bussinessInfoComeFromTypeSubCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        switch (bussinessInfoComeFromTypeCell.selecedIndex) {
            case ZYForeclosureHouseBussinessInfoComeFromBank:
            {
                bussinessInfoComeFromTypeSubCell.showKey = @"look_desc";
                [self cellSearch:bussinessInfoComeFromTypeSubCell withDataSourceSignal:[ZYForeclosureHouseViewModel bankSearchSignal] showKey:@"look_desc"];///银行数据较多 跳转可搜索页面
            }
                break;
            case ZYForeclosureHouseBussinessInfoComeFromCooperativeOrganization:
            {
                bussinessInfoComeFromTypeSubCell.showKey = @"look_desc";
                [self cellPicker:bussinessInfoComeFromTypeSubCell withDataSourceSignal:[ZYForeclosureHouseViewModel cooperativeOrganizationArrSignal] showKey:@"look_desc"];
            }
                break;
            case ZYForeclosureHouseBussinessInfoComeFromIntermediary:
            {
                bussinessInfoComeFromTypeSubCell.showKey = @"look_desc";
                [self cellPicker:bussinessInfoComeFromTypeSubCell withDataSourceSignal:[ZYForeclosureHouseViewModel intermediaryArrSignal] showKey:@"look_desc"];
            }
                break;
            default:
                break;
        }
    }];
    bussinessInfoComeFromTypeSubCell.showKey = @"look_desc";
    RACChannelTo_(bussinessInfoComeFromTypeSubCell,cellTitle,@"") = RACChannelTo_(bussinessInfoComeFromTypeCell,cellText,@"");
    
    comeFromTypeSection = [ZYSection sectionWithCells:@[bussinessInfoComeFromTypeCell]];//单独一个section 便于折叠
    comeFromTypeSubSection = [ZYSection sectionWithCells:@[bussinessInfoComeFromTypeSubCell]];
    
    bussinessInfoAreaCell = [ZYInputCell cellWithActionBlock:nil];
    bussinessInfoAreaCell.cellTitle = @"区域";
    bussinessInfoAreaCell.maxLength = 20;
    bussinessInfoAreaCell.cellPlaceHolder = @"请输入区域";
    
    bussinessInfoLoanMoneyCell = [ZYInputCell cellWithActionBlock:nil];
    bussinessInfoLoanMoneyCell.cellTitle = @"贷款金额";
    bussinessInfoLoanMoneyCell.cellPlaceHolder = @"请输入贷款金额";
    bussinessInfoLoanMoneyCell.onlyFloat = YES;
    
    bussinessInfoDaysCell = [ZYInputCell cellWithActionBlock:nil];
    bussinessInfoDaysCell.cellTitle = @"贷款天数";
    bussinessInfoDaysCell.cellPlaceHolder = @"请输入贷款天数";
    bussinessInfoDaysCell.onlyInt = YES;
    
    bussinessInfoDateCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        [self cellDatePicker:bussinessInfoDateCell onlyFutura:YES];
    }];
    bussinessInfoDateCell.cellTitle = @"计划放款日期";
    
    bussinessInfoAccountCell = [ZYInputCell cellWithActionBlock:nil];
    bussinessInfoAccountCell.cellTitle = @"回款账号";
    bussinessInfoAccountCell.cellPlaceHolder = @"请输入回款账号";
    bussinessInfoAccountCell.onlyInt = YES;
    bussinessInfoAccountCell.maxLength = 20;
    
    bussinessInfoUsernameCell = [ZYInputCell cellWithActionBlock:nil];
    bussinessInfoUsernameCell.cellTitle = @"回款户名";
    bussinessInfoUsernameCell.cellPlaceHolder = @"请输入回款户名";
    
    bussinessInfoLinkmanCell = [ZYInputCell cellWithActionBlock:nil];
    bussinessInfoLinkmanCell.cellTitle = @"业务联系人";
    bussinessInfoLinkmanCell.cellPlaceHolder = @"请输入业务联系人";
    
    bussinessInfoTelephoneCell = [ZYInputCell cellWithActionBlock:nil];
    bussinessInfoTelephoneCell.cellTitle = @"联系电话";
    bussinessInfoTelephoneCell.cellPlaceHolder = @"请输入联系电话";
    bussinessInfoTelephoneCell.onlyInt = YES;
    bussinessInfoTelephoneCell.maxLength = 11;
    
    bussinessInfoOrderTypeCell = [ZYSegmentedCell cellWithActionBlock:nil];
    bussinessInfoOrderTypeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    bussinessInfoOrderTypeCell.showKey = @"title";
    [[ZYForeclosureHouseViewModel foreclosureHouseBussinessInfoOrderArrSignalSignal] subscribeNext:^(NSMutableArray *arr) {
        bussinessInfoOrderTypeCell.cellSegmentedArr = arr;
    }];
    bussinessInfoOrderTypeCell.cellTitle = @"内外单";
    
    bussinessInfoTransactionTypeCell = [ZYSegmentedCell cellWithActionBlock:nil];
    bussinessInfoTransactionTypeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    bussinessInfoTransactionTypeCell.showKey = @"title";
    [[ZYForeclosureHouseViewModel foreclosureHouseBussinessInfoTransactionArrSignal] subscribeNext:^(NSMutableArray *arr) {
        bussinessInfoTransactionTypeCell.cellSegmentedArr = arr;
    }];
    bussinessInfoTransactionTypeCell.cellTitle = @"交易类型";
    
    buttonCell = [ZYSingleButtonCell cellWithActionBlock:nil];
    [buttonCell.buttonPressedSignal subscribeNext:^(id x) {
        [self cellNextStep:[self error]];
    }];
}
- (void)blendModel:(ZYForeclosureHouseViewModel*)model
{
    RACChannelTo(bussinessInfoComeFromTypeCell,selecedObj) = RACChannelTo(model,bussinessInfoComeFromType);

    RACChannelTerminal *channelA = RACChannelTo(bussinessInfoComeFromTypeSubCell,selecedObj);
    RACChannelTerminal *channelB = RACChannelTo(model,bussinessInfoComeFromBank);
    [[channelA filter:^BOOL(id value) {
        if(model.bussinessInfoComeFromType==ZYForeclosureHouseBussinessInfoComeFromBank)
        {
            return YES;
        }
        return NO;
    }] subscribe:channelB];
    [channelB subscribe:channelA];
    
    channelA = RACChannelTo(bussinessInfoComeFromTypeSubCell,selecedObj);
    channelB = RACChannelTo(model,bussinessInfoComeFromCooperativeOrganization);
    [[channelA filter:^BOOL(id value) {
        if(model.bussinessInfoComeFromType.type==ZYForeclosureHouseBussinessInfoComeFromCooperativeOrganization)
        {
            return YES;
        }
        return NO;
    }] subscribe:channelB];
    [channelB subscribe:channelA];
    
    channelA = RACChannelTo(bussinessInfoComeFromTypeSubCell,selecedObj);
    channelB = RACChannelTo(model,bussinessInfoComeFromIntermediary);
    [[channelA filter:^BOOL(id value) {
        if(model.bussinessInfoComeFromType.type==ZYForeclosureHouseBussinessInfoComeFromIntermediary)
        {
            return YES;
        }
        return NO;
    }] subscribe:channelB];
    [channelB subscribe:channelA];
    
    [RACObserve(model, bussinessInfoComeFromType) subscribeNext:^(id x) {
        if(model.bussinessInfoComeFromType.type==ZYForeclosureHouseBussinessInfoComeFromBank||model.bussinessInfoComeFromType.type==ZYForeclosureHouseBussinessInfoComeFromCooperativeOrganization||model.bussinessInfoComeFromType.type==ZYForeclosureHouseBussinessInfoComeFromIntermediary)
        {
            [self showSection:YES sectionIndex:1];
        }
        else
        {
            [self showSection:NO sectionIndex:1];
        }
    }];
    
    RACChannelTo(bussinessInfoAreaCell,cellText) = RACChannelTo(model,bussinessInfoArea);
    RACChannelTo(bussinessInfoLoanMoneyCell,cellText) = RACChannelTo(model,bussinessInfoLoanMoney);
    RACChannelTo(bussinessInfoDaysCell,cellText) = RACChannelTo(model,bussinessInfoDays);
    RACChannelTo(bussinessInfoDateCell,cellText) = RACChannelTo(model,bussinessInfoDate);
    RACChannelTo(bussinessInfoAccountCell,cellText) = RACChannelTo(model,bussinessInfoAccount);
    RACChannelTo(bussinessInfoUsernameCell,cellText) = RACChannelTo(model,bussinessInfoUsername);
    RACChannelTo(bussinessInfoLinkmanCell,cellText) = RACChannelTo(model,bussinessInfoLinkman);
    RACChannelTo(bussinessInfoTelephoneCell,cellText) = RACChannelTo(model,bussinessInfoTelephone);
    RACChannelTo(bussinessInfoOrderTypeCell,cellSegmentedSelecedObj) = RACChannelTo(model,bussinessInfoOrderType);
    RACChannelTo(bussinessInfoTransactionTypeCell,cellSegmentedSelecedObj) = RACChannelTo(model,bussinessInfoTransactionType);

    RAC(bussinessInfoComeFromTypeCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bussinessInfoComeFromTypeSubCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bussinessInfoAreaCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bussinessInfoLoanMoneyCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bussinessInfoDaysCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bussinessInfoDateCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bussinessInfoAccountCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bussinessInfoUsernameCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bussinessInfoLinkmanCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bussinessInfoTelephoneCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bussinessInfoOrderTypeCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bussinessInfoTransactionTypeCell,userInteractionEnabled) = RACObserve(self, edit);
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        ZYSection *section;
        if(self.edit)
        {
            section = [ZYSection sectionWithCells:@[bussinessInfoAreaCell,bussinessInfoLoanMoneyCell,bussinessInfoDaysCell,bussinessInfoDateCell,bussinessInfoAccountCell,bussinessInfoUsernameCell,bussinessInfoLinkmanCell,bussinessInfoTelephoneCell,bussinessInfoOrderTypeCell,bussinessInfoTransactionTypeCell,buttonCell]];
        }
        else
        {
            section = [ZYSection sectionWithCells:@[bussinessInfoAreaCell,bussinessInfoLoanMoneyCell,bussinessInfoDaysCell,bussinessInfoDateCell,bussinessInfoAccountCell,bussinessInfoUsernameCell,bussinessInfoLinkmanCell,bussinessInfoTelephoneCell,bussinessInfoOrderTypeCell,bussinessInfoTransactionTypeCell]];
        }
        
        self.sections = @[comeFromTypeSection,comeFromTypeSubSection,section];
    }];
}
- (NSString*)error
{
    NSArray *errorArr = @[bussinessInfoComeFromTypeSubCell,
                          bussinessInfoAreaCell,
                          bussinessInfoLoanMoneyCell,
                          bussinessInfoDaysCell,
                          bussinessInfoAccountCell,
                          bussinessInfoUsernameCell,
                          bussinessInfoLinkmanCell,
                          bussinessInfoTelephoneCell];
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
