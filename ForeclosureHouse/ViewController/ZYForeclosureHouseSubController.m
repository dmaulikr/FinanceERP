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
#import "ZYSellerInfoSections.h"
#import "ZYBuyerInfoSections.h"
#import "ZYOriginalBankSections.h"
#import "ZYCurrentBankSections.h"
#import "ZYOrderInfoSections.h"
#import "ZYApplicationSections.h"
#import "ZYCostInfoSections.h"
#import "ZYStepView.h"
#import "ZYTopTabBar.h"


@interface ZYForeclosureHouseSubController ()

@property(nonatomic,strong)NSString *error;

@property(nonatomic,weak)ZYSections *currentSections;
@end

@implementation ZYForeclosureHouseSubController
{
    NSArray *sectionsArr;
    
    ZYTopTabBar *topBar;
    
    ZYDoubleButtonCell *buttonView;
    
    ZYSections *mainSections;
}
ZY_VIEW_MODEL_GET(ZYForeclosureHouseViewModel)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
}
- (ZYSections*)buildSection:(Class)class
{
    ZYForeclosureHouseViewModel *viewModel = self.viewModel;
    if(class == [ZYHousePropertyInfoSections class])
    {
        ZYHousePropertyInfoSections *sections = [[class alloc] initWithTitle:@"物业信息"];
        [sections blendModel:viewModel];
        sections.edit = self.edit;
        return sections;
    }
    else if(class == [ZYSellerInfoSections class])
    {
        ZYSellerInfoSections *sections = [[class alloc] initWithTitle:@"卖方信息"];
        [sections blendModel:viewModel];
        sections.edit = self.edit;
        return sections;
    }
    else if(class == [ZYBuyerInfoSections class])
    {
        ZYBuyerInfoSections *sections = [[class alloc] initWithTitle:@"买方信息"];
        [sections blendModel:viewModel];
        sections.edit = self.edit;
        return sections;
    }
    else if(class == [ZYOriginalBankSections class])
    {
        ZYOriginalBankSections *sections = [[class alloc] initWithTitle:@"原贷款银行信息"];
        [sections blendModel:viewModel];
        sections.edit = self.edit;
        [sections.searchBySignalSignal subscribeNext:^(RACTuple *value) {
            [mainSections cellSearch:value.first withDataSourceSignal:value.second showKey:value.third];
        }];
        [sections.datePickerSignal subscribeNext:^(RACTuple *value) {
            [mainSections cellDatePicker:value.first onlyFutura:value.second];
        }];
        return sections;
    }
    else if(class == [ZYCurrentBankSections class])
    {
        ZYCurrentBankSections *sections = [[class alloc] initWithTitle:@"新贷款银行信息"];
        [sections blendModel:viewModel];
        sections.edit = self.edit;
        [sections.searchBySignalSignal subscribeNext:^(RACTuple *value) {
            [mainSections cellSearch:value.first withDataSourceSignal:value.second showKey:value.third];
        }];
        [sections.datePickerSignal subscribeNext:^(RACTuple *value) {
            [mainSections cellDatePicker:value.first onlyFutura:value.second];
        }];
        return sections;
    }
    return nil;
}
- (void)buildUI
{
    
    self.singelLoad = YES;
    
    [self buildPickerView];
    self.pickerViewTapBlankHidden = YES;
    [self buildDatePickerView];
    self.datePickerViewTapBlankHidden = YES;
    
    NSArray *titles = @[@"物业信息",@"卖方信息",@"买方信息",@"原贷款银行",@"新贷款银行"];

    sectionsArr = @[[ZYHousePropertyInfoSections class],
                    [ZYSellerInfoSections class],
                    [ZYBuyerInfoSections class],
                    [ZYOriginalBankSections class],
                    [ZYCurrentBankSections class]];
    
    topBar = [[ZYTopTabBar alloc] initWithTabs:titles frame:CGRectMake(0, 0, FUll_SCREEN_WIDTH, 50)];
    topBar.backgroundColor = [UIColor whiteColor];
    [topBar.tabButtonPressedSignal subscribeNext:^(NSNumber *index) {
        [self changePage:index.longLongValue];
    }];
    [self.view addSubview:topBar];
    
    [topBar.tabButtonPressedSignal subscribeNext:^(NSNumber *index) {
        [self changePage:index.longLongValue];
    }];
    
    [self buildTableViewController];
    
    buttonView = [ZYDoubleButtonCell cellWithActionBlock:nil];
    buttonView.frame = CGRectMake(0, FUll_SCREEN_HEIGHT-50-64-[ZYDoubleButtonCell defaultHeight], FUll_SCREEN_WIDTH, [ZYDoubleButtonCell defaultHeight]);
    buttonView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:buttonView];
    RAC(buttonView,hidden) = [RACObserve(self,edit) map:^id(NSNumber *value) {
        return @(!value.boolValue);
    }];
    
    [[buttonView leftButtonPressedSignal] subscribeNext:^(id x) {
        if(self.currentPage==0)
        {
            [mainSections cellLastStep];
        }
        else
        {
            [self lastPage];
        }
    }];
    [[buttonView rightButtonPressedSignal] subscribeNext:^(id x) {
        
        if([[self.currentSections valueForKey:@"error"] length]==0)
        {
            if(self.currentPage == sectionsArr.count-1)
            {
                [mainSections cellNextStep:nil];
            }
            else
            {
                [self nextPage];
            }
        }
        else
        {
            [self tip:[self.currentSections valueForKey:@"error"] touch:NO];
        }
    }];
}
- (void)blendSections:(ZYSections*)sections
{
//    ZYForeclosureHouseViewModel *viewModel = self.viewModel;
    mainSections = sections;
    
}
- (ZYSections*)sliderController:(ZYSliderViewController*)controller sectionsWithPage:(NSInteger)page
{
    self.currentSections = [self buildSection:sectionsArr[page]];
    return self.currentSections;
}
- (NSInteger)countOfControllerSliderController:(ZYSliderViewController *)controller
{
    return sectionsArr.count;
}
- (CGRect)sliderController:(ZYSliderViewController*)controller frameWithPage:(NSInteger)page
{
    return CGRectMake(page*FUll_SCREEN_WIDTH, 0, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT-100-64);
}
- (CGRect)frameOfScrollViewSliderController:(ZYSliderViewController *)controller
{
    return CGRectMake(0, 50, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT-100-64);
}
- (void)sliderController:(ZYSliderViewController *)controller changingPage:(NSInteger)index direction:(ZYSliderDirection)direction rate:(CGFloat)rate
{
    topBar.rate = rate;
}
- (void)sliderController:(ZYSliderViewController *)controller didChangePage:(NSInteger)index direction:(ZYSliderDirection)direction
{
    topBar.highlightIndex = index;
}
- (instancetype)initWithModel:(ZYForeclosureHouseViewModel*)model
{
    self = [super init];
    if (self) {
        _viewModel = model;
    }
    return self;
}
@end
