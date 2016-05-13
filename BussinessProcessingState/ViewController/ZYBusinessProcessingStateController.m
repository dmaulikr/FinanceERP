//
//  ZYBusinessProcessingStateController.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBusinessProcessingStateController.h"
#import "ZYStepView.h"
#import "ZYBussinessProcessingContentCell.h"
#import "ZYBusinessProcessingStateSections.h"

@interface ZYBusinessProcessingStateController ()

@property (weak, nonatomic) IBOutlet UIView *progressBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;
@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressWidth;
@property (weak, nonatomic) IBOutlet UIScrollView *stepScrollView;

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;

@property (strong, nonatomic)NSMutableArray *viewArr;
@end

@implementation ZYBusinessProcessingStateController
{
    NSInteger steps;
    CGFloat stepWidth;
}
ZY_VIEW_MODEL_GET(ZYBusinessProcessingStateViewModel)
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
    self.contentWidth.constant = 2.0*FUll_SCREEN_WIDTH;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
    [self blendViewModel];
}
- (void)buildUI
{
    self.singelLoad = YES;
}
- (void)blendViewModel
{
    [[RACObserve(self.viewModel, businessProcessingStateArr) skip:1] subscribeNext:^(NSArray *businessProcessingStateArr) {
        if(_viewArr==nil)
        {
            _viewArr = [NSMutableArray arrayWithCapacity:10];
        }
        
        [self removeViewFromSuperView:_viewArr];
        
        steps = businessProcessingStateArr.count;
        stepWidth = self.contentWidth.constant/steps;

        int idx = 0;
        for (ZYBusinessProcessingStatePageModel * model in businessProcessingStateArr) {

            ZYStepView *stepView = [[ZYStepView alloc] initWithPoint:CGPointMake(stepWidth/2.f+idx*stepWidth-30, 0)];
            stepView.title = model.businessProcessingStatePageName;
            stepView.text = [NSString stringWithFormat:@"%lu",(unsigned long)idx+1];
            stepView.tag = idx;
            [_stepScrollView addSubview:stepView];
            [_viewArr addObject:stepView];
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
    }];
    RACChannelTo(self.viewModel,businessProcessingID) = RACChannelTo(self,businessProcessingID);
    
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
    [[RACObserve(self.viewModel, businessProcessingStateIndex) skip:1] subscribeNext:^(NSNumber *page) {
        [self changePage:page.longLongValue];
    }];
    
    
    [self.viewModel requestBusinessProcessingState];
}
- (void)removeViewFromSuperView:(NSArray*)arr
{
    [arr enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        [view removeFromSuperview];
    }];
}
- (ZYSections*)buildSection:(NSInteger)index
{
    ZYBusinessProcessingStatePageModel *model = self.viewModel.businessProcessingStateArr[index];
    ZYBusinessProcessingStateSections *sections = [[ZYBusinessProcessingStateSections alloc] initWithTitle:model.businessProcessingStatePageName];
    RACChannelTo(sections,edit) = RACChannelTo(self,edit);
    [sections blendModel:model];
    return sections;
}
- (ZYSections*)sliderController:(ZYSliderViewController*)controller sectionsWithPage:(NSInteger)page
{
    return [self buildSection:page];
}
- (NSInteger)countOfControllerSliderController:(ZYSliderViewController *)controller
{
    return self.viewModel.businessProcessingStateArr.count;
}
- (CGRect)sliderController:(ZYSliderViewController*)controller frameWithPage:(NSInteger)page
{
    return CGRectMake(page*FUll_SCREEN_WIDTH, 0, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT-64-50-30);
}
- (CGRect)frameOfScrollViewSliderController:(ZYSliderViewController *)controller
{
    return CGRectMake(0, 50+64+30, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT-64-50-30);
}
- (UIView*)sliderController:(ZYSliderViewController *)controller customViewWithpage:(NSInteger)page
{
    return nil;
}
- (void)sliderController:(ZYSliderViewController *)controller changingPage:(NSInteger)index direction:(ZYSliderDirection)direction rate:(CGFloat)rate
{
    self.progressWidth.constant = stepWidth/2.f+(self.contentWidth.constant-stepWidth)*rate;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
