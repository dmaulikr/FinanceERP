//
//  ZYSliderViewController.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/29.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYTableViewController.h"
#import "ZYSections.h"
/**
 滑动 方向
 */
typedef enum : NSUInteger {
    ZYSliderToLeft = 0,
    ZYSliderToRight = 1,
} ZYSliderDirection;

@interface ZYSliderViewController : ZYViewController

@property(nonatomic,assign)NSInteger currentPage;
/**
 *  子类重写该方法
 *
 *  @param controller 当前类
 *
 *  @return 返回childViewController数目
 */
- (NSInteger)countOfControllerSliderController:(ZYSliderViewController*)controller;
/**
 *  自定义view  也需要传入一个sections 占位 方便计算
 */
- (ZYSections*)sliderController:(ZYSliderViewController*)controller sectionsWithPage:(NSInteger)page;
- (CGRect)sliderController:(ZYSliderViewController*)controller frameWithPage:(NSInteger)page;

- (UIView*)sliderController:(ZYSliderViewController*)controller customViewWithpage:(NSInteger)page;

- (void)sliderController:(ZYSliderViewController*)controller didChangePage:(NSInteger)index direction:(ZYSliderDirection)direction;
- (void)sliderController:(ZYSliderViewController*)controller changingPage:(NSInteger)index direction:(ZYSliderDirection)direction rate:(CGFloat)rate;

- (void)buildTableViewController;

- (void)changePage:(NSInteger)index;

- (void)nextPage;
- (void)lastPage;

- (void)reloadTableViewAtIndex:(NSInteger)index;

- (void)showSection:(BOOL)show sectionIndex:(NSInteger)sectionIndex page:(NSInteger)page;
@end
