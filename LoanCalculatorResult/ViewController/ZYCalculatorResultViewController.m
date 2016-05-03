//
//  ZYCalculatorResultViewController.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/7.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCalculatorResultViewController.h"
#import "ZYCalculatorResultHeader.h"
#import "ZYCalculatorResultCell.h"


@interface ZYCalculatorResultViewController ()
{
    CGFloat tableViewTopGapDefault;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UILabel *totleMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totlePaymentLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *totleInterestLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentPerMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *bussinessInterestLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicFundsInterestLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopGap;

@end

@implementation ZYCalculatorResultViewController
ZY_VIEW_MODEL_GET(ZYCalculatorResultViewModel)

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    /**
     *  根据类型 更改页面样式
     */
    if(tableViewTopGapDefault==0)
    {
        tableViewTopGapDefault = _tableViewTopGap.constant;
    }
    if(self.viewModel.calculatorType!=ZYCalculatorTypeAdmixture)
    {
        _tableViewTopGap.constant = tableViewTopGapDefault - 26;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
    [self blendViewModel];
}
- (void)buildUI
{
    ZYCalculatorResultViewModel *viewModel = self.viewModel;
    
    NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZYCalculatorResultHeader class]) owner:nil options:nil];
    ZYCalculatorResultHeader *header = [nibs lastObject];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYCalculatorResultCell class]) bundle:nil] forCellReuseIdentifier:[ZYCalculatorResultCell defaultIdentifier]];
    
    ZYSection *section = [ZYSection sectionSupportingReuseWithHeadView:header headViewHeight:[ZYCalculatorResultHeader defaultHeight] cellHeight:[ZYCalculatorResultCell defaultHeight] cellCount:^NSInteger(UITableView *tableView, NSInteger section) {
        return viewModel.dataSource.count;
    } cellForRowBlock:^UITableViewCell *(UITableView *tableView, NSInteger row) {
        ZYCalculatorResultCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZYCalculatorResultCell defaultIdentifier]];
        [cell loadModel:[viewModel modelAtIndex:row]];
        return cell;
    } actionBlock:^(UITableView *tableView, NSInteger row) {
        
    }];
    
    self.sections = @[section];
}
- (void)blendViewModel
{
    ZYCalculatorResultViewModel *viewModel = self.viewModel;
    
    RAC(self.totleMoneyLabel,text) = RACObserve(viewModel, totleMoneyContent);
    RAC(self.totlePaymentLabel,text) = RACObserve(viewModel, totlePaymentContent);
    RAC(self.paymentMonthLabel,text) = RACObserve(viewModel, paymentMonthContent);
    RAC(self.totleInterestLabel,text) = RACObserve(viewModel, totleInterestContent);
    RAC(self.paymentPerMonthLabel,text) = RACObserve(viewModel, paymentPerMonthContent);
    RAC(self.bussinessInterestLabel,text) = RACObserve(viewModel, bussinessInterestRateContent);
    RAC(self.publicFundsInterestLabel,text) = RACObserve(viewModel, publicFundsInterestRateContent);
    
    [RACObserve(viewModel,dataSource) subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
    [viewModel computePaymentAllMonth];
}
- (UITableView*)tableView
{
    return _myTableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
