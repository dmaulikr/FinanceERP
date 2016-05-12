//
//  ZYForeclosureHouseController.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYForeclosureHouseController.h"
#import "ZYBussinessInfoSections.h"
#import "ZYApplyInfoSections.h"
#import "ZYHousePropertyInfoSections.h"
#import "ZYOriginalBankSections.h"
#import "ZYCurrentBankSections.h"
#import "ZYOrderInfoSections.h"
#import "ZYApplicationSections.h"
#import "ZYCostInfoSections.h"
#import "ZYStepView.h"
#import "ZYTopTabBar.h"
#import "ZYForeclosureHouseSubController.h"
#import "ZYSearchViewController.h"
#import "ZYFadeTransion.h"

@interface ZYForeclosureHouseController ()<UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIView *progressBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;
@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressWidth;

@property (weak, nonatomic) IBOutlet UIScrollView *stepScrollView;

@property (strong, nonatomic)NSMutableArray *viewArr;

@end

@implementation ZYForeclosureHouseController
{
    UIPercentDrivenInteractiveTransition *percentDrivenTransition;
    ZYFadeTransion *transion;
    
    NSArray *sectionsArr;
    
    ZYBussinessInfoSections *bussinessInfoSections;
    ZYApplyInfoSections *applyInfoSections;
    ZYSections *foreclosureHouseInfoSections;
    ZYCostInfoSections *costInfoSections;
    ZYOrderInfoSections *orderInfoSections;
    ZYApplicationSections *applicationSections;
    
    ZYForeclosureHouseSubController *subSliderViewCtl;
    
    NSInteger steps;
    CGFloat stepWidth;
    
    ZYTableViewCell *firstResponderCell;
}
ZY_VIEW_MODEL_GET(ZYForeclosureHouseViewModel)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    transion = [[ZYFadeTransion alloc] init];
    [self buildUI];
    [self blendViewModel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;///关闭手势返回 防止误操作
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
- (void)updateViewConstraints
{
    [super updateViewConstraints];
    self.contentWidth.constant = 1.5*FUll_SCREEN_WIDTH;
}
- (ZYSections*)buildSection:(Class)class
{
    
    ZYForeclosureHouseViewModel *viewModel = self.viewModel;
    if(class == [ZYBussinessInfoSections class])
    {
        ZYBussinessInfoSections *sections = [[class alloc] initWithTitle:@"业务信息"];
        sections.edit = self.edit;
        [sections.showSectionSignal subscribeNext:^(RACTuple *value) {
            [self showSection:[value.first boolValue] sectionIndex:[value.second longLongValue] page:0];
        }];
        [[RACSignal merge:@[sections.pickerByDataSourceSignal,sections.pickerBySignalSignal]] subscribeNext:^(RACTuple *value) {
            [self picker:value];
        }];
        [sections.datePickerSignal subscribeNext:^(RACTuple *value) {
            firstResponderCell = (ZYSelectCell*)value.first;
            [self showDatePickerView:YES];
        }];
        [sections.searchBySignalSignal subscribeNext:^(RACTuple *value) {
            firstResponderCell = (ZYSelectCell*)value.first;
            [self performSegueWithIdentifier:@"search" sender:value];
        }];
        [sections.nextStepSignal subscribeNext:^(RACTuple *value) {
            NSString *error = value.first;
            if(error.length==0)
            {
                [self nextPage];
            }
            else
            {
                [self tip:error touch:NO];
            }
        }];
        [sections.lastStepSignal subscribeNext:^(RACTuple *value) {
            [self lastPage];
        }];
        [sections blendModel:viewModel];
        return sections;
    }
    else if(class == [ZYApplyInfoSections class])
    {
        ZYApplyInfoSections *sections = [[class alloc] initWithTitle:@"申请信息"];
        sections.edit = self.edit;
        [sections.searchBySignalSignal subscribeNext:^(RACTuple *value) {
            firstResponderCell = (ZYSelectCell*)value.first;
            [self performSegueWithIdentifier:@"search" sender:value];
        }];
        [sections.nextStepSignal subscribeNext:^(RACTuple *value) {
            NSString *error = value.first;
            if(error.length==0)
            {
                [self nextPage];
            }
            else
            {
                [self tip:error touch:NO];
            }
        }];
        [sections.lastStepSignal subscribeNext:^(RACTuple *value) {
            [self lastPage];
        }];
        [sections blendModel:viewModel];
        return sections;
    }
    else if(class == [ZYSections class])
    {
        return nil;
    }
    else if(class == [ZYCostInfoSections class])
    {
        ZYCostInfoSections *sections = [[class alloc] initWithTitle:@"费用信息"];
        sections.edit = self.edit;
        [sections.nextStepSignal subscribeNext:^(RACTuple *value) {
            NSString *error = value.first;
            if(error.length==0)
            {
                [self nextPage];
            }
            else
            {
                [self tip:error touch:NO];
            }
        }];
        [sections.lastStepSignal subscribeNext:^(RACTuple *value) {
            [self lastPage];
        }];
        [sections blendModel:viewModel];
        return sections;
    }
    else if(class == [ZYOrderInfoSections class])
    {
        ZYOrderInfoSections *sections = [[class alloc] initWithTitle:@"赎楼清单"];
        sections.edit = self.edit;
        [[sections showSectionSignal] subscribeNext:^(RACTuple *value) {
            [self showSection:[value.first boolValue] sectionIndex:[value.second longLongValue] page:4];
        }];
        [sections.nextStepSignal subscribeNext:^(RACTuple *value) {
            NSString *error = value.first;
            if(error.length==0)
            {
                [self nextPage];
            }
            else
            {
                [self tip:error touch:NO];
            }
        }];
        [sections.lastStepSignal subscribeNext:^(RACTuple *value) {
            [self lastPage];
        }];
        [sections blendModel:viewModel];
        return sections;
    }
    else if(class == [ZYApplicationSections class])
    {
        ZYApplicationSections *sections = [[class alloc] initWithTitle:@"申请办理"];
        sections.edit = self.edit;
        [sections.datePickerSignal subscribeNext:^(RACTuple *value) {
            firstResponderCell = (ZYSelectCell*)value.first;
            [self showDatePickerView:YES];
        }];
        [[(ZYApplicationSections*)sections saveSignal] subscribeNext:^(RACTuple *value) {
            NSString *error = value.first;
            if(error.length==0)
            {
                //保存
            }
            else
            {
                [self tip:error touch:NO];
            }
        }];
        [[(ZYApplicationSections*)sections submitSignal] subscribeNext:^(RACTuple *value) {
            NSString *error = value.first;
            if(error.length==0)
            {
                //提交
            }
            else
            {
                [self tip:error touch:NO];
            }
        }];
        [sections.nextStepSignal subscribeNext:^(RACTuple *value) {
            NSString *error = value.first;
            if(error.length==0)
            {
                [self nextPage];
            }
            else
            {
                [self tip:error touch:NO];
            }
        }];
        [sections.lastStepSignal subscribeNext:^(RACTuple *value) {
            [self lastPage];
        }];
        [sections blendModel:viewModel];
        return sections;
    }
    return nil;
}
- (void)picker:(RACTuple*)value
{
    if([value.first isKindOfClass:[ZYSelectCell class]])
    {
        firstResponderCell = (ZYSelectCell*)value.first;
        self.selecedRow = [(ZYSelectCell*)firstResponderCell selecedIndex];
    }
    if([value.first isKindOfClass:[ZYInputCell class]])
    {
        firstResponderCell = (ZYInputCell*)value.first;
        self.selecedRow = [(ZYInputCell*)firstResponderCell selecedIndex];
    }
    
    NSString *showKey = value.third;
    self.pickerShowValueKey = showKey;
    if([value.second isKindOfClass:[NSArray class]])
    {
        NSArray *dataSource = value.second;
        self.components = @[dataSource];
    }
    else if([value.second isKindOfClass:[RACSignal class]])
    {
        RACSignal *signal = value.second;
        [signal subscribeNext:^(NSArray *dataSource) {
            self.components = @[dataSource];
        }];
    }
    [self showPickerView:YES];
}
- (void)buildUI
{
    self.singelLoad = YES;
    
    [self buildPickerView];
    self.pickerViewTapBlankHidden = YES;
    [self buildDatePickerView];
    self.datePickerViewTapBlankHidden = YES;
    
    NSArray *titles = @[@"业务信息",@"申请信息",@"赎楼信息",@"费用信息",@"赎楼清单",@"申请办理"];
    
    sectionsArr = @[[ZYBussinessInfoSections class],
                    [ZYApplyInfoSections class],
                    [ZYSections class],
                    [ZYCostInfoSections class],
                    [ZYOrderInfoSections class],
                    [ZYApplicationSections class]];
    
    subSliderViewCtl = [[ZYForeclosureHouseSubController alloc] initWithModel:self.viewModel];
    subSliderViewCtl.edit = self.edit;
    ZYSections *sections = [[ZYSections alloc] initWithTitle:@"赎楼信息"];
    [sections.datePickerSignal subscribeNext:^(RACTuple *value) {
        firstResponderCell = (ZYSelectCell*)value.first;
        [self showDatePickerView:YES];
    }];
    [sections.searchBySignalSignal subscribeNext:^(RACTuple *value) {
        firstResponderCell = (ZYSelectCell*)value.first;
        [self performSegueWithIdentifier:@"search" sender:value];
    }];
    [sections.nextStepSignal subscribeNext:^(RACTuple *value) {
        NSString *error = value.first;
        if(error.length==0)
        {
            [self nextPage];
        }
        else
        {
            [self tip:error touch:NO];
        }
    }];
    [sections.lastStepSignal subscribeNext:^(RACTuple *value) {
        [self lastPage];
    }];
    [subSliderViewCtl blendSections:sections];
    
    _viewArr = [NSMutableArray arrayWithCapacity:10];
    
    steps = sectionsArr.count;
    stepWidth = 1.5*FUll_SCREEN_WIDTH/steps;
    int idx = 0;
    for (NSString * title in titles) {
        
        ZYStepView *stepView = [[ZYStepView alloc] initWithPoint:CGPointMake(stepWidth/2.f+idx*stepWidth-30, 0)];
        stepView.title = title;
        stepView.text = [NSString stringWithFormat:@"%lu",(unsigned long)idx+1];
        [_stepScrollView addSubview:stepView];
        [_viewArr addObject:stepView];
        stepView.tag = idx;
        [stepView.tapSignal subscribeNext:^(NSNumber *tag) {
            [self changePage:tag.longLongValue];
        }];
        if(idx==0)
        {
            [stepView highlight:YES];
        }
        idx++;
    }
    if(steps!=0)
        self.progressWidth.constant = (self.contentWidth.constant/steps)/2.f;
    
    [self buildTableViewController];
    
}
- (void)blendViewModel
{
    [RACObserve(self, selecedRow) subscribeNext:^(NSNumber *index) {
        if([firstResponderCell isKindOfClass:[ZYSelectCell class]])
        {
            [(ZYSelectCell*)firstResponderCell setSelecedIndex:index.longLongValue];
        }
        if([firstResponderCell isKindOfClass:[ZYInputCell class]])
        {
            [(ZYSelectCell*)firstResponderCell setSelecedIndex:index.longLongValue];
        }
    }];
    [RACObserve(self, selecedObj) subscribeNext:^(id obj) {
        if([firstResponderCell isKindOfClass:[ZYSelectCell class]])
        {
            [(ZYSelectCell*)firstResponderCell setSelecedObj:obj];
        }
        if([firstResponderCell isKindOfClass:[ZYInputCell class]])
        {
            [(ZYInputCell*)firstResponderCell setSelecedObj:obj];
        }
    }];
    [RACObserve(self, selecedDate) subscribeNext:^(NSDate *date) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [formatter stringFromDate:date];
        if([firstResponderCell isKindOfClass:[ZYSelectCell class]])
        {
            [(ZYSelectCell*)firstResponderCell setCellText:dateStr];
        }
        if([firstResponderCell isKindOfClass:[ZYInputCell class]])
        {
            [(ZYInputCell*)firstResponderCell setCellText:dateStr];
        }
    }];

    RACChannelTo(self.viewModel,projectID) = RACChannelTo(self,projectID);
    [self.viewModel reset];//初始化
    [self.viewModel foreclosureHouseRequest];//请求数据
}

- (ZYSections*)sliderController:(ZYSliderViewController*)controller sectionsWithPage:(NSInteger)page
{
    ZYSections *sections = [self buildSection:sectionsArr[page]];
    return sections;
}
- (NSInteger)countOfControllerSliderController:(ZYSliderViewController *)controller
{
    return sectionsArr.count;
}
- (CGRect)sliderController:(ZYSliderViewController*)controller frameWithPage:(NSInteger)page
{
    return CGRectMake(page*FUll_SCREEN_WIDTH, 0, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT-64-50);
}
- (CGRect)frameOfScrollViewSliderController:(ZYSliderViewController *)controller
{
    return CGRectMake(0, 50+64, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT-64-50);
}
- (UIView*)sliderController:(ZYSliderViewController *)controller customViewWithpage:(NSInteger)page
{
    if(page==2)
    {
        return subSliderViewCtl.view;
    }
    return nil;
}
- (void)sliderController:(ZYSliderViewController *)controller changingPage:(NSInteger)index direction:(ZYSliderDirection)direction rate:(CGFloat)rate
{
    self.progressWidth.constant = stepWidth/2.f+(1.5*FUll_SCREEN_WIDTH-stepWidth)*rate;
}
- (void)sliderController:(ZYSliderViewController *)controller didChangePage:(NSInteger)index direction:(ZYSliderDirection)direction
{
    for(int i=0;i<_viewArr.count;i++)
    {
        ZYStepView *view = _viewArr[i];
        if(i<=index)
        {
            [view highlight:YES];
        }
        else
        {
            [view highlight:NO];
        }
    }
    
    CGPoint point = _stepScrollView.contentOffset;
    

    if(index>=2&&index<steps-1)
    {
        point.x = (index-2)*stepWidth;
        [self.stepScrollView setContentOffset:point animated:YES];
    }
    else
    {
        if(index<2)
        {
            point.x = 0;
            [self.stepScrollView setContentOffset:point animated:YES];
        }
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"search"])
    {
        ZYSearchViewController *controller = [segue destinationViewController];
        RACSignal *signal = [(RACTuple*)sender second];
        NSString *key = [(RACTuple*)sender third];
        ZYSearchViewModel *viewModel = [ZYSearchViewModel viewModelWithSignal:signal];
        @weakify(self)
        [[RACObserve(viewModel, searchSelecedObj) skip:1] subscribeNext:^(id x) {
            @strongify(self)
            self.selecedObj = x;
        }];
        viewModel.showPropertyKey = key;
        controller.viewModel = viewModel;
        segue.destinationViewController.transitioningDelegate = self;
    }
}
#pragma mark - 转场动画
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    transion.animation = YES;
    return transion;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    transion.animation = YES;
    return transion;
}
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return percentDrivenTransition;
}
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return percentDrivenTransition;
}

@end
