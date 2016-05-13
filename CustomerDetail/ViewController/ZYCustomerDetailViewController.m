//
//  ZYCustomerDetailViewController.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/13.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerDetailViewController.h"
#import "ZYTopTabBar.h"

@interface ZYCustomerDetailViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *topTabScrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewContentWidth;

@end

@implementation ZYCustomerDetailViewController
{
    NSInteger steps;
    CGFloat stepWidth;
    
    ZYTopTabBar *topBar;
}
ZY_VIEW_MODEL_GET(ZYCustomerDetailViewModel)
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
    self.scrollViewContentWidth.constant = 2.0*FUll_SCREEN_WIDTH;
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
    steps = self.viewModel.customerDetailTabTitles.count;
    topBar = [[ZYTopTabBar alloc] initWithTabs:self.viewModel.customerDetailTabTitles frame:CGRectMake(0, 0, 2.0*FUll_SCREEN_WIDTH, 50)];
    topBar.backgroundColor = [UIColor whiteColor];
    [topBar.tabButtonPressedSignal subscribeNext:^(NSNumber *index) {
        [self changePage:index.longLongValue];
    }];
    stepWidth = topBar.tabWidth+GAP;
    [self.scrollBackView addSubview:topBar];
    
    [self buildTableViewController];
}
- (void)blendViewModel
{
    
}

- (ZYSections*)buildSection:(NSInteger)index
{
    return nil;
}
- (ZYSections*)sliderController:(ZYSliderViewController*)controller sectionsWithPage:(NSInteger)page
{
    return [self buildSection:page];
}
- (NSInteger)countOfControllerSliderController:(ZYSliderViewController *)controller
{
    return self.viewModel.customerDetailTabTitles.count;
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
    return nil;
}
- (void)sliderController:(ZYSliderViewController *)controller changingPage:(NSInteger)index direction:(ZYSliderDirection)direction rate:(CGFloat)rate
{
    topBar.rate = rate;
}
- (void)sliderController:(ZYSliderViewController *)controller didChangePage:(NSInteger)index direction:(ZYSliderDirection)direction
{
    topBar.highlightIndex = index;
    
    CGPoint point = _topTabScrollView.contentOffset;
    if(index>=2&&index<steps-1)
    {
        point.x = (index-2)*stepWidth;
        [_topTabScrollView setContentOffset:point animated:YES];
    }
    else
    {
        if(index<2)
        {
            point.x = 0;
            [_topTabScrollView setContentOffset:point animated:YES];
        }
    }
}

@end
