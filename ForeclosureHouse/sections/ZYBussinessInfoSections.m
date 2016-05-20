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
    ZYSelectCell *bussinessInfoComeFromTypeSubSelecedCell;
    ZYInputCell  *bussinessInfoComeFromTypeSubInputCell;
    
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
    ZYSection *comeFromTypeSubSelecedSection;
    ZYSection *comeFromTypeSubInputSection;
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
    bussinessInfoComeFromTypeSubSelecedCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        switch (bussinessInfoComeFromTypeCell.selecedIndex) {
            case ZYForeclosureHouseBussinessInfoComeFromBank:
            {
                [self cellSearch:bussinessInfoComeFromTypeSubSelecedCell withDataSourceSignal:[ZYForeclosureHouseViewModel bankSearchSignal] showKey:@"look_desc"];///银行数据较多 跳转可搜索页面
            }
                break;
            case ZYForeclosureHouseBussinessInfoComeFromCooperativeOrganization:
            {
                [self cellPicker:bussinessInfoComeFromTypeSubSelecedCell withDataSourceSignal:[ZYForeclosureHouseViewModel cooperativeOrganizationArrSignal] showKey:@"look_desc"];
            }
                break;
            case ZYForeclosureHouseBussinessInfoComeFromIntermediary:
            {
                [self cellPicker:bussinessInfoComeFromTypeSubSelecedCell withDataSourceSignal:[ZYForeclosureHouseViewModel intermediaryArrSignal] showKey:@"look_desc"];
            }
                break;
            default:
                break;
        }
    }];
    bussinessInfoComeFromTypeSubSelecedCell.showKey = @"look_desc";
    RACChannelTo_(bussinessInfoComeFromTypeSubSelecedCell,cellTitle,@"") = RACChannelTo_(bussinessInfoComeFromTypeCell,cellText,@"");
    
    bussinessInfoComeFromTypeSubInputCell = [ZYInputCell cellWithActionBlock:nil];
    bussinessInfoComeFromTypeSubInputCell.cellTitle = @"其他";
    bussinessInfoComeFromTypeSubInputCell.cellNullable = YES;
    bussinessInfoComeFromTypeSubInputCell.cellPlaceHolder = @"请输入其他业务来源";
    
    comeFromTypeSection = [ZYSection sectionWithCells:@[bussinessInfoComeFromTypeCell]];//单独一个section 便于折叠
    comeFromTypeSubSelecedSection = [ZYSection sectionWithCells:@[bussinessInfoComeFromTypeSubSelecedCell]];
    comeFromTypeSubInputSection = [ZYSection sectionWithCells:@[bussinessInfoComeFromTypeSubInputCell]];
    
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
        [self cellNextStep:[self error] sender:nil];
    }];
}
- (void)blendModel:(ZYForeclosureHouseViewModel*)model
{
    RACChannelTo(bussinessInfoComeFromTypeCell,selecedObj) = RACChannelTo(model,bussinessInfoComeFromType);
   

    [RACObserve(bussinessInfoComeFromTypeSubSelecedCell,selecedObj) subscribeNext:^(id x) {
        if(model.bussinessInfoComeFromType.type==ZYForeclosureHouseBussinessInfoComeFromBank)
        {
            model.bussinessInfoComeFromBank = x;
        }
        else if(model.bussinessInfoComeFromType.type==ZYForeclosureHouseBussinessInfoComeFromCooperativeOrganization)
        {
            model.bussinessInfoComeFromCooperativeOrganization = x;
        }
        else if(model.bussinessInfoComeFromType.type==ZYForeclosureHouseBussinessInfoComeFromIntermediary)
        {
            model.bussinessInfoComeFromIntermediary = x;
        }
        else if(model.bussinessInfoComeFromType.type==ZYForeclosureHouseBussinessInfoComeFromOther)
        {
            model.bussinessInfoComeFromOther = x;
        }
        else
        {
            
        }
    }];
    
    //其他类型 填入的自定义信息
    RACChannelTo(bussinessInfoComeFromTypeSubInputCell,cellText) = RACChannelTo(model,bussinessInfoComeFromOther);
    
    if(model.bussinessInfoComeFromType.type==ZYForeclosureHouseBussinessInfoComeFromBank)
    {
        comeFromTypeSubSelecedSection.hasFold = NO;
        comeFromTypeSubInputSection.hasFold = YES;
    }
    else if(model.bussinessInfoComeFromType.type==ZYForeclosureHouseBussinessInfoComeFromCooperativeOrganization)
    {
        comeFromTypeSubSelecedSection.hasFold = NO;
        comeFromTypeSubInputSection.hasFold = YES;
    }
    else if(model.bussinessInfoComeFromType.type==ZYForeclosureHouseBussinessInfoComeFromIntermediary)
    {
        comeFromTypeSubSelecedSection.hasFold = NO;
        comeFromTypeSubInputSection.hasFold = YES;
    }
    else if(model.bussinessInfoComeFromType.type==ZYForeclosureHouseBussinessInfoComeFromOther)
    {
        comeFromTypeSubSelecedSection.hasFold = YES;
        comeFromTypeSubInputSection.hasFold = NO;
    }
    else
    {
        comeFromTypeSubSelecedSection.hasFold = NO;
        comeFromTypeSubInputSection.hasFold = NO;
    }
    [[RACObserve(model, bussinessInfoComeFromType) skip:1] subscribeNext:^(id x) {
        if(model.bussinessInfoComeFromType.type==ZYForeclosureHouseBussinessInfoComeFromBank)
        {
            bussinessInfoComeFromTypeSubSelecedCell.showKey = @"look_desc";
            bussinessInfoComeFromTypeSubSelecedCell.selecedObj = model.bussinessInfoComeFromBank;
            [self showSection:YES sectionIndex:1];
            [self showSection:NO sectionIndex:2];
        }
        else if(model.bussinessInfoComeFromType.type==ZYForeclosureHouseBussinessInfoComeFromCooperativeOrganization)
        {
            bussinessInfoComeFromTypeSubSelecedCell.showKey = @"look_desc";
            bussinessInfoComeFromTypeSubSelecedCell.selecedIndex = model.bussinessInfoComeFromCooperativeOrganization.num;
            bussinessInfoComeFromTypeSubSelecedCell.selecedObj = model.bussinessInfoComeFromCooperativeOrganization;
            [self showSection:YES sectionIndex:1];
            [self showSection:NO sectionIndex:2];
        }
        else if(model.bussinessInfoComeFromType.type==ZYForeclosureHouseBussinessInfoComeFromIntermediary)
        {
            bussinessInfoComeFromTypeSubSelecedCell.showKey = @"look_desc";
            bussinessInfoComeFromTypeSubSelecedCell.selecedIndex = model.bussinessInfoComeFromIntermediary.num;
            bussinessInfoComeFromTypeSubSelecedCell.selecedObj = model.bussinessInfoComeFromIntermediary;
            [self showSection:YES sectionIndex:1];
            [self showSection:NO sectionIndex:2];
        }
        else if(model.bussinessInfoComeFromType.type==ZYForeclosureHouseBussinessInfoComeFromOther)
        {
            [self showSection:YES sectionIndex:2];
            [self showSection:NO sectionIndex:1];
        }
        else
        {
            [self showSection:NO sectionIndex:2];
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
    RAC(bussinessInfoComeFromTypeSubSelecedCell,userInteractionEnabled) = RACObserve(self, edit);
    RAC(bussinessInfoComeFromTypeSubInputCell,userInteractionEnabled) = RACObserve(self, edit);
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
        
        self.sections = @[comeFromTypeSection,comeFromTypeSubSelecedSection,comeFromTypeSubInputSection,section];
    }];
}
- (NSString*)error
{
    NSArray *errorArr = nil;
    ZYForeclosureHouseBussinessInfoComeFromType type = [(ZYForeclosureHouseComeFromTypeModel*)bussinessInfoComeFromTypeCell.selecedObj type];
    if(type==ZYForeclosureHouseBussinessInfoComeFromBank||type==ZYForeclosureHouseBussinessInfoComeFromCooperativeOrganization||type==ZYForeclosureHouseBussinessInfoComeFromIntermediary)
    {
        errorArr = @[bussinessInfoComeFromTypeSubSelecedCell,
                              bussinessInfoAreaCell,
                              bussinessInfoLoanMoneyCell,
                              bussinessInfoDaysCell,
                              bussinessInfoAccountCell,
                              bussinessInfoUsernameCell,
                              bussinessInfoLinkmanCell,
                              bussinessInfoTelephoneCell];
    }
    else
    {
        errorArr = @[bussinessInfoAreaCell,
                     bussinessInfoLoanMoneyCell,
                     bussinessInfoDaysCell,
                     bussinessInfoAccountCell,
                     bussinessInfoUsernameCell,
                     bussinessInfoLinkmanCell,
                     bussinessInfoTelephoneCell];
    }
   
    
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
