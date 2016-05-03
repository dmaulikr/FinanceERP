//
//  ZYForeclosureHouseSubController.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/21.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYForeclosureHouseSubController.h"
#import "ZYBussinessInfoSections.h"
#import "ZYApplyInfoSections.h"
#import "ZYHousePropertyInfoSections.h"
#import "ZYBothSideInfoSections.h"
#import "ZYOriginalBankSections.h"
#import "ZYCurrentBankSections.h"
#import "ZYOrderInfoSections.h"
#import "ZYApplicationSections.h"
#import "ZYCostInfoSections.h"
#import "ZYStepView.h"
#import "ZYTopTabBar.h"


@interface ZYForeclosureHouseSubController ()

@end

@implementation ZYForeclosureHouseSubController
{
    ZYHousePropertyInfoSections *housePropertyInfoSections;
    ZYBothSideInfoSections *bothSideInfoSections;
    ZYOriginalBankSections *originalBankSections;
    ZYCurrentBankSections *currentBankSections;
    
    NSArray *sectionsArr;
    
    ZYTopTabBar *topBar;
    
    ZYTableViewCell *firstResponderCell;
    
    ZYDoubleButtonCell *buttonView;
}
ZY_VIEW_MODEL_GET(ZYForeclosureHouseSubViewModel)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
}
- (void)buildUI
{
    housePropertyInfoSections = [[ZYHousePropertyInfoSections alloc] initWithTitle:@"物业信息"];
    bothSideInfoSections = [[ZYBothSideInfoSections alloc] initWithTitle:@"买卖双方信息"];
    originalBankSections = [[ZYOriginalBankSections alloc] initWithTitle:@"原贷款银行信息"];
    currentBankSections = [[ZYCurrentBankSections alloc] initWithTitle:@"新贷款银行信息"];
    
    sectionsArr = @[housePropertyInfoSections,
                    bothSideInfoSections,
                    originalBankSections,
                    currentBankSections,];
    [self buildTableViewController];
    
    NSMutableArray *titleArr = [NSMutableArray arrayWithCapacity:4];
    for(ZYSections *sections in sectionsArr)
    {
        [titleArr addObject:sections.title];
    }
    
    topBar = [[ZYTopTabBar alloc] initWithTabs:titleArr];
    topBar.backgroundColor = [UIColor whiteColor];
    topBar.frame = CGRectMake(0, 0, FUll_SCREEN_WIDTH, 50);
    [self.view addSubview:topBar];
    
    [topBar.tabButtonPressedSignal subscribeNext:^(NSNumber *index) {
        [self changePage:index.longLongValue];
    }];
    
    buttonView = [ZYDoubleButtonCell cellWithActionBlock:nil];
    buttonView.frame = CGRectMake(0, FUll_SCREEN_HEIGHT-50-64-[ZYDoubleButtonCell defaultHeight], FUll_SCREEN_WIDTH, [ZYDoubleButtonCell defaultHeight]);
    buttonView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:buttonView];
    buttonView.hidden = !self.edit;
}
- (void)blendSections:(ZYSections*)sections
{
    ZYForeclosureHouseSubViewModel *viewModel = self.viewModel;
    [housePropertyInfoSections blendModel:viewModel.valueModel];
    [bothSideInfoSections blendModel:viewModel.valueModel];
    [originalBankSections blendModel:viewModel.valueModel];
    [currentBankSections blendModel:viewModel.valueModel];
    
    [RACObserve(housePropertyInfoSections, sections) subscribeNext:^(id x) {
        [self reloadTableViewAtIndex:0];
    }];
    [RACObserve(bothSideInfoSections, sections) subscribeNext:^(id x) {
        [self reloadTableViewAtIndex:1];
    }];
    [RACObserve(originalBankSections, sections) subscribeNext:^(id x) {
        [self reloadTableViewAtIndex:2];
    }];
    [RACObserve(currentBankSections, sections) subscribeNext:^(id x) {
        [self reloadTableViewAtIndex:3];
    }];
    
    [[RACSignal merge:@[originalBankSections.searchBySignalSignal,currentBankSections.searchBySignalSignal]] subscribeNext:^(RACTuple *value) {
        [sections cellSearch:value.first withDataSourceSignal:value.second showKey:value.third];
    }];
    [[RACSignal merge:@[originalBankSections.datePickerSignal,currentBankSections.datePickerSignal]] subscribeNext:^(RACTuple *value) {
        [sections cellDatePicker:value.first onlyFutura:value.second];
    }];
    [[buttonView leftButtonPressedSignal] subscribeNext:^(id x) {
        [sections cellLastStep];
    }];
    [[buttonView rightButtonPressedSignal] subscribeNext:^(id x) {
        [sections cellNextStep:[self error]];
    }];
    
    self.edit = _edit;
}
- (void)setEdit:(BOOL)edit
{
    _edit = edit;
    housePropertyInfoSections.edit = edit;
    bothSideInfoSections.edit = edit;
    originalBankSections.edit = edit;
    currentBankSections.edit = edit;
}
- (NSString*)error
{
    NSArray *errorArr = @[housePropertyInfoSections.error,
                          bothSideInfoSections.error,
                          originalBankSections.error,
                          currentBankSections.error];
    NSString *result = nil;
    for(NSString *error in errorArr)
    {
        if(error.length>0&&result==nil)
            result = error;
        else
            continue;
    }
    errorArr = nil;
    return result;
}
- (ZYSections*)sliderController:(ZYSliderViewController*)controller sectionsWithPage:(NSInteger)page
{
    return sectionsArr[page];
}
- (NSInteger)countOfControllerSliderController:(ZYSliderViewController *)controller
{
    return sectionsArr.count;
}
- (CGRect)sliderController:(ZYSliderViewController*)controller frameWithPage:(NSInteger)page
{
    return CGRectMake(page*FUll_SCREEN_WIDTH, 50, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT-100-64);
}
- (void)sliderController:(ZYSliderViewController *)controller changingPage:(NSInteger)index direction:(ZYSliderDirection)direction rate:(CGFloat)rate
{
    topBar.rate = rate;
}
- (void)sliderController:(ZYSliderViewController *)controller didChangePage:(NSInteger)index direction:(ZYSliderDirection)direction
{
    topBar.highlightIndex = index;
}
- (instancetype)initWithModel:(ZYForeclosureHouseValueModel*)model
{
    self = [super init];
    if (self) {
        self.viewModel.valueModel = model;
    }
    return self;
}
@end
