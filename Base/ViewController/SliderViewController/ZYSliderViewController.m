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
            if(!self.singelLoad)
            {
                ZYSections *sections = [self sliderController:self sectionsWithPage:i];
                tableViewCtl.sections = sections.sections;
            }
            else
            {
                if(i==0)
                {
                    ZYSections *sections = [self sliderController:self sectionsWithPage:i];
                    tableViewCtl.sections = sections.sections;
                }
            }
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
        _scrollView = [[UIScrollView alloc] initWithFrame:[self frameOfScrollViewSliderController:self]];
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
    if(scrollView!=self.scrollView)
        return;
    
    NSInteger lastPage = _currentPage;
    _currentPage = (NSInteger)((scrollView.contentOffset.x) / width);
    if(_currentPage>lastPage)///向右
    {
        [self sliderController:self didChangePage:_currentPage direction:ZYSliderToRight];
    }
    else if(_currentPage<lastPage)
    {
        [self sliderController:self didChangePage:_currentPage direction:ZYSliderToLeft];
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
        [self sliderController:self changingPage:_currentPage direction:direction rate:rate];
    }
    
    offX = scrollView.contentOffset.x;
}
-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if(!self.singelLoad)
        return;
    if(scrollView!=self.scrollView)
        return;
    
    for (ZYTableViewController *tableCtl in tableViewArr) {
        if([tableCtl isKindOfClass:[ZYTableViewController class]])
        {
            tableCtl.sections = nil;
        }
    }
    
    ZYSections *sections = [self sliderController:self sectionsWithPage:_currentPage];
    ZYTableViewController *tableViewCtl = tableViewArr[_currentPage];
    if([tableViewCtl isKindOfClass:[ZYTableViewController class]])
    {
        tableViewCtl.sections = sections.sections;
    }
}
- (void)changePage:(NSInteger)index
{
    if(index>=totalNumber)
        return;
    [UIView animateWithDuration:0.3 animations:^{
        [self.scrollView setContentOffset:CGPointMake(index*width, 0)];
    } completion:^(BOOL finished) {
        [self scrollViewDidEndDecelerating:self.scrollView];
        [self scrollViewDidScroll:self.scrollView];
    }];
}
- (void)showSection:(BOOL)show sectionIndex:(NSInteger)sectionIndex page:(NSInteger)page
{
    if(page>=tableViewArr.count)
        return;
    ZYTableViewController *tableCtl = [tableViewArr objectAtIndex:page];
    if([tableCtl isKindOfClass:[ZYTableViewController class]])
    {
        [tableCtl showSection:show sectionIndex:sectionIndex];
    }
}
- (void)nextPage
{
    if(_currentPage==totalNumber-1)
        return;
    [self changePage:_currentPage+1];
}
- (void)lastPage
{
    if(_currentPage==0)
        return;
    [self changePage:_currentPage-1];
}
//- (void)reloadFrame
//{
//    for(int i=0;i<totalNumber;i++)
//    {
//        ZYTableViewController *tableViewCtl = tableViewArr[i];
//        if([tableViewCtl isKindOfClass:[ZYTableViewController class]])
//        {
//            CGRect rect = [self sliderController:self frameWithPage:i];
//            tableViewCtl.frame = rect;
//        }
//        else
//        {
//            UIView *view = (UIView*)tableViewCtl;
//            CGRect rect = [self sliderController:self frameWithPage:i];
//            view.frame = rect;
//        }
//    }
//    _scrollView.frame = [self frameOfScrollViewSliderController:self];
//}
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
- (CGRect)frameOfScrollViewSliderController:(ZYSliderViewController*)controller
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
