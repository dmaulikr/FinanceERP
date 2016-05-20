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
#import "ZYApplicationMattersController.h"

@interface ZYBusinessApplyListController()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ZYBusinessApplyListController
{
    ZYBusinessApplyListCell *foreclosureHouseCell;
    
//    ZYBusinessApplyListCell *downPaymentMortgageCell;
//    ZYBusinessApplyListCell *houseMortgageCell;
//    ZYBusinessApplyListCell *customerFundMortgageCell;
//    ZYBusinessApplyListCell *creditMortgageCell;
    
    ZYBusinessApplyListCell *refundCounterFeeCell;
    ZYBusinessApplyListCell *refundConsultingFeeCell;
    ZYBusinessApplyListCell *refundRetainageFeeCell;
}
- (void)viewDidLoad
{
    if(self.isApplicationMatters)
    {
        self.navigationItem.title = @"申请事项";
    }
    [super viewDidLoad];
    [self buildUI];
}
- (void)buildUI
{
    if(self.isApplicationMatters)
    {
        @weakify(self)
        refundCounterFeeCell = [ZYBusinessApplyListCell cellWithActionBlock:^{
            @strongify(self)
            [self performSegueWithIdentifier:@"apply" sender:@(1)];
        }];
        refundCounterFeeCell.cellImageName = @"apply-1";
        refundCounterFeeCell.cellTitleText = @"退手续费";
        refundCounterFeeCell.cellSubTitleText = @"详细介绍";
        [refundCounterFeeCell.cellButtonPressSignal subscribeNext:^(id x) {
            @strongify(self)
            [self performSegueWithIdentifier:@"apply" sender:@(1)];
        }];
        
        refundConsultingFeeCell = [ZYBusinessApplyListCell cellWithActionBlock:^{
            @strongify(self)
            [self performSegueWithIdentifier:@"apply" sender:@(3)];
        }];
        refundConsultingFeeCell.cellImageName = @"apply-2";
        refundConsultingFeeCell.cellTitleText = @"退咨询费";
        refundConsultingFeeCell.cellSubTitleText = @"详细介绍";
        [refundConsultingFeeCell.cellButtonPressSignal subscribeNext:^(id x) {
            @strongify(self)
            [self performSegueWithIdentifier:@"apply" sender:@(3)];
        }];
        
        refundRetainageFeeCell = [ZYBusinessApplyListCell cellWithActionBlock:^{
            @strongify(self)
            [self performSegueWithIdentifier:@"apply" sender:@(4)];
        }];
        refundRetainageFeeCell.cellImageName = @"apply-3";
        refundRetainageFeeCell.cellTitleText = @"退尾款";
        refundRetainageFeeCell.cellSubTitleText = @"详细介绍";
        [refundRetainageFeeCell.cellButtonPressSignal subscribeNext:^(id x) {
            @strongify(self)
            [self performSegueWithIdentifier:@"apply" sender:@(4)];
        }];
        
        ZYSection *section = [ZYSection sectionWithCells:@[refundCounterFeeCell,
                                                           refundConsultingFeeCell,
                                                           refundRetainageFeeCell]];
        self.sections = @[section];
    }
    else
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
        
        ZYSection *section = [ZYSection sectionWithCells:@[foreclosureHouseCell]];
        self.sections = @[section];
    }
    
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
    if([segue.identifier isEqualToString:@"apply"])
    {
        ZYApplicationMattersController *controller = [segue destinationViewController];
        controller.type = [sender longLongValue];
    }
}
@end
