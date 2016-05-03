//
//  ZYCalculatorSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCalculatorSections.h"

@implementation ZYCalculatorSections
{
    ZYCalculatorSelectCell *calculatorComputingFormulaCell;
    ZYCalculatorInputCell *calculatorTotleMoneyCell;
    ZYCalculatorInputCell *calculatorPricePerCentiareCell;
    ZYCalculatorInputCell *calculatorAreaCell;
    ZYCalculatorSelectCell *calculatorLoanRateCell;
    ZYCalculatorInputCell *calculatorBussinessTotleMoneyCell;
    ZYCalculatorInputCell *calculatorPublicFundsTotleMoneyCell;
    ZYCalculatorInputCell *calculatorBussinessInterestRateCell;
    ZYCalculatorInputCell *calculatorPublicFundsInterestRateCell;
    ZYCalculatorSelectCell *calculatorMonthsCell;
    ZYCalculatorSelectCell *calculatorInterestCell;
    ZYCalculatorInputCell *calculatorInterestRateCell;
    ZYCalculatorSelectCell *calculatorPaymentTypeCell;
    
    ZYCalculatorButtonCell *buttonCell;
    
    ZYCalculatorViewModel *sectionsViewModel;
}
- (instancetype)initWithTitle:(NSString *)title
{
    self = [super initWithTitle:title];
    if (self) {
        [self initSections];
    }
    return self;
}
- (void)initSections
{
#pragma mark - 选择cell
    
    calculatorComputingFormulaCell = [ZYCalculatorSelectCell cellWithXibHeight:[ZYCalculatorSelectCell defaultHeight] actionBlock:^{
        [self cellPicker:calculatorComputingFormulaCell withDataSource:[ZYCalculatorValueModel calculatorComputingFormulaArr] showKey:nil];
    }];
    calculatorComputingFormulaCell.cellTitle = @"计算公式";
    
    calculatorLoanRateCell = [ZYCalculatorSelectCell cellWithXibHeight:[ZYCalculatorSelectCell defaultHeight] actionBlock:^{
        [self cellPicker:calculatorLoanRateCell withDataSource:[ZYCalculatorValueModel calculatorLoanRateArr] showKey:nil];
    }];
    calculatorLoanRateCell.cellTitle = @"按揭成数";
    
    
    calculatorMonthsCell = [ZYCalculatorSelectCell cellWithXibHeight:[ZYCalculatorSelectCell defaultHeight] actionBlock:^{
        [self cellPicker:calculatorMonthsCell withDataSource:[ZYCalculatorValueModel calculatorMonthsArr] showKey:nil];
    }];
    calculatorMonthsCell.cellTitle = @"按揭期数";
    
    calculatorInterestCell = [ZYCalculatorSelectCell cellWithXibHeight:[ZYCalculatorSelectCell defaultHeight] actionBlock:^{
        [self cellPicker:calculatorInterestCell withDataSource:[ZYCalculatorValueModel calculatorInterestArr] showKey:nil];
    }];
    calculatorInterestCell.cellTitle = @"贷款利率";
    
    calculatorPaymentTypeCell = [ZYCalculatorSelectCell cellWithXibHeight:[ZYCalculatorSelectCell defaultHeight] actionBlock:^{
        [self cellPicker:calculatorPaymentTypeCell withDataSource:[ZYCalculatorValueModel calculatorPaymentTypeArr] showKey:nil];
    }];
    calculatorPaymentTypeCell.cellTitle = @"还款方式";
    
#pragma mark - 输入cell
    
    calculatorTotleMoneyCell = [ZYCalculatorInputCell cellWithXibHeight:[ZYCalculatorSelectCell defaultHeight] actionBlock:^{
    }];
    calculatorTotleMoneyCell.cellTitle = @"贷款总额";
    calculatorTotleMoneyCell.tailText = @"万元";
    
    calculatorPricePerCentiareCell = [ZYCalculatorInputCell cellWithXibHeight:[ZYCalculatorSelectCell defaultHeight] actionBlock:^{
    }];
    calculatorPricePerCentiareCell.cellTitle = @"单价";
    calculatorPricePerCentiareCell.tailText = @"元/平米";
    calculatorPricePerCentiareCell.maxLength = 6;
    
    calculatorAreaCell = [ZYCalculatorInputCell cellWithXibHeight:[ZYCalculatorSelectCell defaultHeight] actionBlock:^{
    }];
    calculatorAreaCell.cellTitle = @"面积";
    calculatorAreaCell.tailText = @"平米";
    
    calculatorBussinessTotleMoneyCell = [ZYCalculatorInputCell cellWithXibHeight:[ZYCalculatorSelectCell defaultHeight] actionBlock:^{
    }];
    calculatorBussinessTotleMoneyCell.cellTitle = @"商业性";
    calculatorBussinessTotleMoneyCell.tailText = @"万元";
    
    calculatorPublicFundsTotleMoneyCell = [ZYCalculatorInputCell cellWithXibHeight:[ZYCalculatorSelectCell defaultHeight] actionBlock:^{
    }];
    calculatorPublicFundsTotleMoneyCell.cellTitle = @"公积金";
    calculatorPublicFundsTotleMoneyCell.tailText = @"万元";
    
    calculatorBussinessInterestRateCell = [ZYCalculatorInputCell cellWithXibHeight:[ZYCalculatorSelectCell defaultHeight] actionBlock:^{
    }];
    calculatorBussinessInterestRateCell.cellTitle = @"商业";
    calculatorBussinessInterestRateCell.tailText = @"%";
    
    calculatorPublicFundsInterestRateCell = [ZYCalculatorInputCell cellWithXibHeight:[ZYCalculatorSelectCell defaultHeight] actionBlock:^{
    }];
    calculatorPublicFundsInterestRateCell.cellTitle = @"公积金";
    calculatorPublicFundsInterestRateCell.tailText = @"%";
    
    calculatorInterestRateCell = [ZYCalculatorInputCell cellWithXibHeight:[ZYCalculatorSelectCell defaultHeight] actionBlock:^{
        
    }];
    calculatorInterestRateCell.cellTitle = @"";
    calculatorInterestRateCell.tailText = @"%";
    
    
    buttonCell = [ZYCalculatorButtonCell cellWithXibHeight:[ZYCalculatorButtonCell defaultHeight] actionBlock:nil];
    [buttonCell setLineHidden:YES];
}
- (void)reloadCells
{
    NSArray *cellArr;
    if(sectionsViewModel.calculatorType==ZYCalculatorTypePublicFunds||sectionsViewModel.calculatorType==ZYCalculatorTypeBusinessLoan)
    {
        if(sectionsViewModel.calculatorComputingFormulaSelected==ZYCalculatorComputingTypePrice)
        {
            cellArr = @[calculatorComputingFormulaCell,calculatorTotleMoneyCell,calculatorMonthsCell,calculatorInterestCell,calculatorInterestRateCell,calculatorPaymentTypeCell,buttonCell];
        }
        else if (sectionsViewModel.calculatorComputingFormulaSelected==ZYCalculatorComputingTypeArea)
        {
            cellArr = @[calculatorComputingFormulaCell,calculatorPricePerCentiareCell,calculatorAreaCell,calculatorLoanRateCell,calculatorMonthsCell,calculatorInterestCell,calculatorInterestRateCell,calculatorPaymentTypeCell,buttonCell];
        }
    }
    else if (sectionsViewModel.calculatorType==ZYCalculatorTypeAdmixture)
    {
        cellArr = @[calculatorBussinessTotleMoneyCell,calculatorPublicFundsTotleMoneyCell,calculatorMonthsCell,calculatorInterestCell,calculatorBussinessInterestRateCell,calculatorPublicFundsInterestRateCell,calculatorPaymentTypeCell,buttonCell];
    }
    ZYSection *section = [ZYSection sectionWithCells:cellArr];
    
    self.sections = @[section];
}
- (void)blendViewModel:(ZYCalculatorViewModel*)viewModel
{
    sectionsViewModel = viewModel;
    RACChannelTo(calculatorTotleMoneyCell,cellDetail) = RACChannelTo(viewModel,calculatorTotleMoney);
    
    RACChannelTo(calculatorPricePerCentiareCell,cellDetail) = RACChannelTo(viewModel,calculatorPricePerCentiare);
    RACChannelTo(calculatorAreaCell,cellDetail) = RACChannelTo(viewModel,calculatorArea);
//    RACChannelTo(calculatorLoanRateCell,cellDetail) = RACChannelTo(viewModel,calculatorLoanRate);
    RACChannelTo(calculatorBussinessTotleMoneyCell,cellDetail) = RACChannelTo(viewModel,calculatorBussinessTotleMoney);
    RACChannelTo(calculatorPublicFundsTotleMoneyCell,cellDetail) = RACChannelTo(viewModel,calculatorPublicFundsTotleMoney);
    RACChannelTo(calculatorBussinessInterestRateCell,cellDetail) = RACChannelTo(viewModel,calculatorBussinessInterestRate);
    RACChannelTo(calculatorPublicFundsInterestRateCell,cellDetail) = RACChannelTo(viewModel,calculatorPublicFundsInterestRate);
    RACChannelTo(calculatorInterestRateCell,cellDetail) = RACChannelTo(viewModel,calculatorInterestRate);
    
//    RACChannelTo(calculatorComputingFormulaCell,cellDetail) = RACChannelTo(viewModel,calculatorComputingFormula);
//    RACChannelTo(calculatorMonthsCell,cellDetail) = RACChannelTo(viewModel,calculatorMonths);
//    RACChannelTo(calculatorInterestCell,cellDetail) = RACChannelTo(viewModel,calculatorInterest);
//    RACChannelTo(calculatorPaymentTypeCell,cellDetail) = RACChannelTo(viewModel,calculatorPaymentType);
    
    RACChannelTo(calculatorComputingFormulaCell,selecedIndex) = RACChannelTo(viewModel,calculatorComputingFormulaSelected);
    RACChannelTo(calculatorLoanRateCell,selecedIndex) = RACChannelTo(viewModel,calculatorLoanRateSelected);
    RACChannelTo(calculatorMonthsCell,selecedIndex) = RACChannelTo(viewModel,calculatorMonthsSelected);
    RACChannelTo(calculatorInterestCell,selecedIndex) = RACChannelTo(viewModel,calculatorInterestSelected);
    RACChannelTo(calculatorPaymentTypeCell,selecedIndex) = RACChannelTo(viewModel,calculatorPaymentTypeSelected);
    
    RAC(calculatorComputingFormulaCell,selecedObj) = [RACObserve(calculatorComputingFormulaCell,selecedIndex) map:^id(NSNumber *value) {
        return [ZYCalculatorValueModel calculatorComputingFormulaArr][value.longLongValue];
    }];
    RAC(calculatorLoanRateCell,selecedObj) = [RACObserve(calculatorLoanRateCell,selecedIndex) map:^id(NSNumber *value) {
        return [ZYCalculatorValueModel calculatorLoanRateArr][value.longLongValue];
    }];
    RAC(calculatorMonthsCell,selecedObj) = [RACObserve(calculatorMonthsCell,selecedIndex) map:^id(NSNumber *value) {
        return [ZYCalculatorValueModel calculatorMonthsArr][value.longLongValue];
    }];
    RAC(calculatorInterestCell,selecedObj) = [RACObserve(calculatorInterestCell,selecedIndex) map:^id(NSNumber *value) {
        return [ZYCalculatorValueModel calculatorInterestArr][value.longLongValue];
    }];
    RAC(calculatorPaymentTypeCell,selecedObj) = [RACObserve(calculatorPaymentTypeCell,selecedIndex) map:^id(NSNumber *value) {
        return [ZYCalculatorValueModel calculatorPaymentTypeArr][value.longLongValue];
    }];
    
    [buttonCell.leftButtonPressedSignal subscribeNext:^(id x) {
        [self reset];
    }];
    [buttonCell.rightButtonPressedSignal subscribeNext:^(id x) {
        [self cellNextStep:viewModel.computeError];
    }];
    [RACObserve(viewModel, calculatorComputingFormulaSelected) subscribeNext:^(id x) {
        [self reloadCells];
    }];
    
    
}
- (void)reset
{
    calculatorComputingFormulaCell.selecedIndex = 0;
    calculatorTotleMoneyCell.cellDetail = @"";
    calculatorPricePerCentiareCell.cellDetail = @"";
    calculatorAreaCell.cellDetail = @"";
    calculatorLoanRateCell.selecedIndex = 0;
    calculatorBussinessTotleMoneyCell.cellDetail = @"";
    calculatorPublicFundsTotleMoneyCell.cellDetail = @"";
    calculatorBussinessInterestRateCell.cellDetail = @"4.9";
    calculatorPublicFundsInterestRateCell.cellDetail = @"4.9";
    calculatorMonthsCell.selecedIndex = 0;
    calculatorInterestCell.selecedIndex = 0;
    calculatorInterestRateCell.cellDetail = @"4.9";
    calculatorPaymentTypeCell.selecedIndex = 0;
}
@end
