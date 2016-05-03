//
//  ZYSection.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ZYSection : NSObject

typedef UITableViewCell * (^CellForRowBlock)(UITableView *tableView, NSInteger row);
typedef NSInteger  (^CellCountBlock)(UITableView *tableView, NSInteger section);
typedef void (^CellActionBlock)(UITableView *tableView,NSInteger row);

@property (nonatomic, strong) NSMutableArray *cells;

@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic) CGFloat headerHeight;
@property (nonatomic) CGFloat footerHeight;

@property (nonatomic, readonly) BOOL reuseEnabled;

@property (nonatomic, readonly) CGFloat reusedCellHeight;
@property (nonatomic, copy, readonly) CellForRowBlock cellForRowBlock;
@property (nonatomic, copy, readonly) CellActionBlock reusedCellActionBlock;
@property (nonatomic, copy, readonly) CellCountBlock reusedCellCount;

@property (nonatomic)BOOL hasFold;///默认未折叠

#pragma mark - section 类方法

+ (instancetype)sectionWithCells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight footerTitle:(NSString *)footerTitle cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight footerView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells;
+ (instancetype)sectionWithFooterTitle:(NSString *)footerTitle cells:(NSArray *)cells;
+ (instancetype)sectionWithFooterView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells;


#pragma mark - 支持复用

+ (instancetype)sectionSupportingReuseWithTitle:(NSString *)title cellHeight:(CGFloat)cellHeight cellCount:(CellCountBlock)cellCount cellForRowBlock:(CellForRowBlock)cellForRowBlock actionBlock:(CellActionBlock)actionBlock;
+ (instancetype)sectionSupportingReuseWithHeadView:(UIView *)headView headViewHeight:(CGFloat)headViewHeight cellHeight:(CGFloat)cellHeight cellCount:(CellCountBlock)cellCount cellForRowBlock:(CellForRowBlock)cellForRowBlock actionBlock:(CellActionBlock)actionBlock;

@end
