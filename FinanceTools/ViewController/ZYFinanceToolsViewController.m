//
//  ZYFinanceToolsViewController.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/29.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYFinanceToolsViewController.h"

@interface ZYFinanceToolsViewController ()
/**
 *  房贷计算器按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *housingLoanCalculatorButton;
/**
 *  房产询价
 */
@property (weak, nonatomic) IBOutlet UIButton *housePropertyInquiryButton;
/**
 *  过户询价
 */
@property (weak, nonatomic) IBOutlet UIButton *transferInquiryButton;
/**
 *  免费查档
 */
@property (weak, nonatomic) IBOutlet UIButton *consultFilesButton;
/**
 *  预约
 */
@property (weak, nonatomic) IBOutlet UIButton *makeAppointmentButton;

@end

@implementation ZYFinanceToolsViewController

ZY_VIEW_MODEL_GET(ZYFinanceToolsViewModel);

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarHidden = NO;
    
    [self blendViewModel];
}
- (void)blendViewModel
{
    ZYFinanceToolsViewModel *viewModel = self.viewModel;
    /**
     *  功能开启 关闭
     */
    [[RACObserve(viewModel, housingLoanCalculatorFunction) skip:0] subscribeNext:^(NSNumber *hasFunction) {
        _housingLoanCalculatorButton.userInteractionEnabled = [hasFunction boolValue];
        UIImage *image = [hasFunction boolValue]?[UIImage imageNamed:@"tool-ic1"]:[UIImage imageNamed:@"tool-ic1n"];
        [_housingLoanCalculatorButton setImage:image forState:UIControlStateNormal];
    }];
    [[RACObserve(viewModel, housePropertyInquiryFunction) skip:0] subscribeNext:^(NSNumber *hasFunction) {
        _housePropertyInquiryButton.userInteractionEnabled = [hasFunction boolValue];
        UIImage *image = [hasFunction boolValue]?[UIImage imageNamed:@"tool-ic2"]:[UIImage imageNamed:@"tool-ic2n"];
        [_housePropertyInquiryButton setImage:image forState:UIControlStateNormal];
    }];
    [[RACObserve(viewModel, transferInquiryFunction) skip:0] subscribeNext:^(NSNumber *hasFunction) {
        _transferInquiryButton.userInteractionEnabled = [hasFunction boolValue];
        UIImage *image = [hasFunction boolValue]?[UIImage imageNamed:@"tool-ic3"]:[UIImage imageNamed:@"tool-ic3n"];
        [_transferInquiryButton setImage:image forState:UIControlStateNormal];
    }];
    [[RACObserve(viewModel, consultFilesFunction) skip:0] subscribeNext:^(NSNumber *hasFunction) {
        _consultFilesButton.userInteractionEnabled = [hasFunction boolValue];
        UIImage *image = [hasFunction boolValue]?[UIImage imageNamed:@"tool-ic4"]:[UIImage imageNamed:@"tool-ic4n"];
        [_consultFilesButton setImage:image forState:UIControlStateNormal];
    }];
    [[RACObserve(viewModel, makeAppointmentFunction) skip:0] subscribeNext:^(NSNumber *hasFunction) {
        _makeAppointmentButton.userInteractionEnabled = [hasFunction boolValue];
        UIImage *image = [hasFunction boolValue]?[UIImage imageNamed:@"tool-ic5"]:[UIImage imageNamed:@"tool-ic5n"];
        [_makeAppointmentButton setImage:image forState:UIControlStateNormal];
    }];
    [viewModel requestFunctionList];
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
