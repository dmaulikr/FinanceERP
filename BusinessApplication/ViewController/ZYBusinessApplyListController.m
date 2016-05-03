//
//  ZYBusinessApplyListController.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/8.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBusinessApplyListController.h"
#import "ZYBusinessApplyListCell.h"
#import "ZYForeclosureHouseController.h"

@interface ZYBusinessApplyListController()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ZYBusinessApplyListController
{
    ZYBusinessApplyListCell *foreclosureHouseCell;
    ZYBusinessApplyListCell *downPaymentMortgageCell;
    ZYBusinessApplyListCell *houseMortgageCell;
    ZYBusinessApplyListCell *customerFundMortgageCell;
    ZYBusinessApplyListCell *creditMortgageCell;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self buildUI];
}
- (void)buildUI
{
    @weakify(self)
    foreclosureHouseCell = [ZYBusinessApplyListCell cellWithActionBlock:^{
        @strongify(self)
        [self performSegueWithIdentifier:@"foreclosureHouse" sender:nil];
    }];
    foreclosureHouseCell.cellImageName = @"prim01";
    foreclosureHouseCell.cellTitleText = @"赎楼";
    foreclosureHouseCell.cellSubTitleText = @"详细介绍";
    [foreclosureHouseCell.cellButtonPressSignal subscribeNext:^(id x) {
        @strongify(self)
        [self performSegueWithIdentifier:@"foreclosureHouse" sender:nil];
    }];
//
//    downPaymentMortgageCell = [ZYBusinessApplyListCell cellWithActionBlock:^{
//        @strongify(self)
//        [self tip:@"功能尚未开通，敬请期待"];
//    }];
//    downPaymentMortgageCell.cellImageName = @"prim02";
//    downPaymentMortgageCell.cellTitleText = @"首付贷";
//    downPaymentMortgageCell.cellSubTitleText = @"详细介绍";
//    [downPaymentMortgageCell.cellButtonPressSignal subscribeNext:^(id x) {
//        @strongify(self)
//        [self tip:@"功能尚未开通，敬请期待"];
//    }];
//    
//    houseMortgageCell = [ZYBusinessApplyListCell cellWithActionBlock:^{
//        @strongify(self)
//        [self tip:@"功能尚未开通，敬请期待"];
//    }];
//    houseMortgageCell.cellImageName = @"prim03";
//    houseMortgageCell.cellTitleText = @"房帮贷";
//    houseMortgageCell.cellSubTitleText = @"详细介绍";
//    [houseMortgageCell.cellButtonPressSignal subscribeNext:^(id x) {
//        @strongify(self)
//        [self tip:@"功能尚未开通，敬请期待"];
//    }];
//    
//    customerFundMortgageCell = [ZYBusinessApplyListCell cellWithActionBlock:^{
//        @strongify(self)
//        [self tip:@"功能尚未开通，敬请期待"];
//    }];
//    customerFundMortgageCell.cellImageName = @"prim04";
//    customerFundMortgageCell.cellTitleText = @"客资贷";
//    customerFundMortgageCell.cellSubTitleText = @"详细介绍";
//    [customerFundMortgageCell.cellButtonPressSignal subscribeNext:^(id x) {
//        @strongify(self)
//        [self tip:@"功能尚未开通，敬请期待"];
//    }];
//    
//    creditMortgageCell = [ZYBusinessApplyListCell cellWithActionBlock:^{
//        @strongify(self)
//        [self tip:@"功能尚未开通，敬请期待"];
//    }];
//    creditMortgageCell.cellImageName = @"prim05";
//    creditMortgageCell.cellTitleText = @"信用贷";
//    creditMortgageCell.cellSubTitleText = @"详细介绍";
//    [creditMortgageCell.cellButtonPressSignal subscribeNext:^(id x) {
//        @strongify(self)
//        [self tip:@"功能尚未开通，敬请期待"];
//    }];
    
//    ZYSection *section = [ZYSection sectionWithCells:@[foreclosureHouseCell,downPaymentMortgageCell,houseMortgageCell,customerFundMortgageCell,creditMortgageCell]];
     ZYSection *section = [ZYSection sectionWithCells:@[foreclosureHouseCell]];
    self.sections = @[section];
    
    [self.rac_willDeallocSignal subscribeNext:^(id x) {
        @strongify(self)
        self.sections = nil;
    }];
}
- (UITableView*)tableView
{
    return _myTableView;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"foreclosureHouse"])
    {
        ZYForeclosureHouseController *controller = [segue destinationViewController];
        controller.edit = YES;//允许编辑
    }
}
@end
