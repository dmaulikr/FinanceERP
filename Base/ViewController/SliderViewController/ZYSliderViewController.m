//
//  ZYSliderViewController.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/29.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSliderViewController.h"



@interface ZYSliderViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;

@end

@implementation ZYSliderViewController
{
    NSMutableArray *tableViewArr;
    
    NSInteger currentPage;
    CGFloat width;
    CGFloat height;
    
    ///childController的数目
    NSInteger totalNumber;
    /**
     *  scoll偏移量 判断方向
     */
    CGFloat offX;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)buildTableViewController
{
    totalNumber = [self countOfControllerSliderController:self];
    
    width = self.view.width;
    height = self.view.height;
    
    tableViewArr = [NSMutableArray arrayWithCapacity:10];
    for(int i=0;i<totalNumber;i++)
    {
        UIView *view = [self sliderController:self customViewWithpage:i];
        if(view==nil)
        {
            ZYTableViewController *tableViewCtl = [[ZYTableViewController alloc]init];
            CGRect rect = [self sliderController:self frameWithPage:i];
            tableViewCtl.frame = rect;
            [self.scrollView addSubview:tableViewCtl.view];
            ZYSections *sections = [self sliderController:self sectionsWithPage:i];
            tableViewCtl.sections = sections.sections;
            [tableViewArr addObject:tableViewCtl];
        }
        else
        {
            CGRect rect = [self sliderController:self frameWithPage:i];
            view.frame = rect;
            [self.scrollView addSubview:view];
            [tableViewArr addObject:view];
        }
    }
    self.scrollView.contentOffset = CGPointMake(0, 0);//起始位置。
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width*totalNumber, self.scrollView.height);
}
- (void)reloadTableViewAtIndex:(NSInteger)index
{
    ZYTableViewController *tableViewCtl = tableViewArr[index];
    if([tableViewCtl isKindOfClass:[ZYTableViewController class]])
    {
        ZYSections *sections = [self sliderController:self sectionsWithPage:index];
        tableViewCtl.sections = sections.sections;
    }
}
- (UIScrollView*)scrollView
{
    if(_scrollView==nil)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, FUll_SCREEN_WIDTH,FUll_SCREEN_HEIGHT)];
        _scrollView.userInteractionEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = YES;
        //        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger lastPage = currentPage;
    currentPage = (NSInteger)((scrollView.contentOffset.x) / width);
    if(currentPage>lastPage)///向右
    {
        [self sliderController:self didChangePage:currentPage direction:ZYSliderToRight];
    }
    else if(currentPage<lastPage)
    {
        [self sliderController:self didChangePage:currentPage direction:ZYSliderToLeft];
    }
    else
    {
        ZYSliderDirection direction;
        if(scrollView.contentOffset.x>offX)
        {
            direction = ZYSliderToRight;
        }
        else
        {
            direction = ZYSliderToLeft;
        }
        CGFloat rate = scrollView.contentOffset.x/(scrollView.contentSize.width-width);
        [self sliderController:self changingPage:currentPage direction:direction rate:rate];
    }
    
    offX = scrollView.contentOffset.x;
}
- (void)changePage:(NSInteger)index
{
    if(index>=totalNumber)
        return;
    [self.scrollView setContentOffset:CGPointMake(index*width, 0) animated:YES];
}
- (void)showSection:(BOOL)show sectionIndex:(NSInteger)sectionIndex page:(NSInteger)page
{
    ZYTableViewController *tableCtl = [tableViewArr objectAtIndex:page];
    if([tableCtl isKindOfClass:[ZYTableViewController class]])
    {
        [tableCtl showSection:show sectionIndex:sectionIndex];
    }
}
- (void)nextPage
{
    if(currentPage==totalNumber-1)
        return;
    [self changePage:currentPage+1];
}
- (void)lastPage
{
    if(currentPage==0)
        return;
    [self changePage:currentPage-1];
}
#pragma mark - 重写以下方法

- (NSInteger)countOfControllerSliderController:(ZYSliderViewController*)controller
{
    return 0;
}
- (ZYSections*)sliderController:(ZYSliderViewController*)controller sectionsWithPage:(NSInteger)page
{
    return nil;
}

- (CGRect)sliderController:(ZYSliderViewController*)controller frameWithPage:(NSInteger)page
{
    return CGRectZero;
}
- (void)sliderController:(ZYSliderViewController*)controller didChangePage:(NSInteger)index direction:(ZYSliderDirection)direction
{
    
}
- (void)sliderController:(ZYSliderViewController*)controller changingPage:(NSInteger)index direction:(ZYSliderDirection)direction rate:(CGFloat)rate
{
    
}
- (UIView*)sliderController:(ZYSliderViewController*)controller customViewWithpage:(NSInteger)page
{
    return nil;
}
@end
