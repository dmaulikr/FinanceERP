//
//  ZYBussinessProcessingStateEditController.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/12.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBussinessProcessingStateEditController.h"
#import "ZYTableViewController.h"

@interface ZYBussinessProcessingStateEditController ()

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;

@end

@implementation ZYBussinessProcessingStateEditController
{
    ZYSelectCell *firstResponderCell;
}
ZY_VIEW_MODEL_GET(ZYBussinessProcessingStateEditViewModel)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildUI];
    [self blendViewModel];
}
- (void)buildUI
{
    [self buildDatePickerView];
    self.datePickerViewTapBlankHidden = YES;
    
    ZYTableViewController *tableViewCtl = [[ZYTableViewController alloc] init];
    tableViewCtl.frame = CGRectMake(0, 30+64, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT-64-30);
    [self.view addSubview:tableViewCtl.view];
    [self addChildViewController:tableViewCtl];
    
    ZYBusinessProcessingStateEditSections *sections = [[ZYBusinessProcessingStateEditSections alloc] initWithTitle:@"业务动态"];
    sections.edit = YES;
    [sections blendModel:self.viewModel.businessProcessingStatePageModel];
    tableViewCtl.sections = sections.sections;
    
    [sections.datePickerSignal subscribeNext:^(RACTuple *value) {
        firstResponderCell = value.first;
        BOOL onlyFutura = [value.second boolValue];
        self.showDateBefore = !onlyFutura;
        [self showDatePickerView:YES];
    }];
    
}
- (void)blendViewModel
{
    RACChannelTo(self.viewModel,businessProcessingID) = RACChannelTo(self, businessProcessingID);
    
    [[RACObserve(self.viewModel, loading) skip:1] subscribeNext:^(NSNumber *loading) {
        if(loading.boolValue)
        {
            [self loading:NO];
        }
        else
        {
            [self stop];
        }
    }];
    [[RACObserve(self.viewModel, businessProcessingState) skip:1] subscribeNext:^(NSString *state) {
        self.stateLabel.text = state;
    }];
    [[RACObserve(self.viewModel, businessProcessingDays) skip:1] subscribeNext:^(NSNumber *days) {
        NSString *dayStr = [NSString stringWithFormat:@"%@",days];
        NSString *fullStr = [NSString stringWithFormat:@"总历时:%@天",dayStr];
        NSRange range = [fullStr rangeOfString:dayStr];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:fullStr];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range];
        [attStr addAttribute:NSForegroundColorAttributeName value:ORANGE range:range];
        self.daysLabel.attributedText = attStr;
    }];
    
    [[RACObserve(self, selecedDate) skip:1] subscribeNext:^(NSDate *date) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [formatter stringFromDate:date];
        [firstResponderCell setCellText:dateStr];
    }];
    
    [self.viewModel requestBusinessProcessingState];
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
