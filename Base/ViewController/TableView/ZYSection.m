//
//  ZYSection.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSection.h"

@implementation ZYSection

#pragma mark - Cells

+ (instancetype)sectionWithCells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:nil headerView:nil headerHeight:UITableViewAutomaticDimension footerTitle:nil footerView:nil footerHeight:UITableViewAutomaticDimension cells:cells];
}


#pragma mark - Header title

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle cells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:headerTitle headerView:nil headerHeight:UITableViewAutomaticDimension footerTitle:nil footerView:nil footerHeight:UITableViewAutomaticDimension cells:cells];
}

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle cells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:headerTitle headerView:nil headerHeight:UITableViewAutomaticDimension footerTitle:footerTitle footerView:nil footerHeight:UITableViewAutomaticDimension cells:cells];
}

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:headerTitle headerView:nil headerHeight:UITableViewAutomaticDimension footerTitle:nil footerView:footerView footerHeight:footerHeight cells:cells];
}


#pragma mark - Header view

+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight cells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:nil headerView:headerView headerHeight:headerHeight footerTitle:nil footerView:nil footerHeight:UITableViewAutomaticDimension cells:cells];
}

+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight footerTitle:(NSString *)footerTitle cells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:nil headerView:headerView headerHeight:headerHeight footerTitle:footerTitle footerView:nil footerHeight:UITableViewAutomaticDimension cells:cells];
}

+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight footerView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:nil headerView:headerView headerHeight:headerHeight footerTitle:nil footerView:footerView footerHeight:footerHeight cells:cells];
}


#pragma mark - Footer title

+ (instancetype)sectionWithFooterTitle:(NSString *)footerTitle cells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:nil headerView:nil headerHeight:UITableViewAutomaticDimension footerTitle:footerTitle footerView:nil footerHeight:UITableViewAutomaticDimension cells:cells];
}


#pragma mark - Footer view

+ (instancetype)sectionWithFooterView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells {
    return [[self class] sectionWithHeaderTitle:nil headerView:nil headerHeight:UITableViewAutomaticDimension footerTitle:nil footerView:footerView footerHeight:footerHeight cells:cells];
}


#pragma mark - The whole shabang

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle headerView:(UIView *)headerView headerHeight:(CGFloat)headerHeight footerTitle:(NSString *)footerTitle footerView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells {
    ZYSection *section = [[self class] new];
    section.headerTitle = headerTitle;
    section.headerView = headerView;
    section.headerHeight = headerHeight;
    section.footerTitle = footerTitle;
    section.footerView = footerView;
    section.footerHeight = footerHeight;
    section.cells = [cells mutableCopy];
    return section;
}


#pragma mark - Reuse

+ (instancetype)sectionSupportingReuseWithTitle:(NSString *)title cellHeight:(CGFloat)cellHeight cellCount:(CellCountBlock)cellCount cellForRowBlock:(CellForRowBlock)cellForRowBlock actionBlock:(CellActionBlock)actionBlock {
    return [[[self class] alloc] initSectionSupportingReuseWithTitle:title  cellHeight:cellHeight cellCount:cellCount cellForRowBlock:cellForRowBlock actionBlock:actionBlock];
}
+ (instancetype)sectionSupportingReuseWithHeadView:(UIView *)headView headViewHeight:(CGFloat)headViewHeight cellHeight:(CGFloat)cellHeight cellCount:(CellCountBlock)cellCount cellForRowBlock:(CellForRowBlock)cellForRowBlock actionBlock:(CellActionBlock)actionBlock
{
    return [[[self class] alloc] initSectionSupportingReuseWithHeadView:headView headViewHeight:headViewHeight cellHeight:cellHeight cellCount:cellCount cellForRowBlock:cellForRowBlock actionBlock:actionBlock];
}



- (instancetype)initSectionSupportingReuseWithHeadView:(UIView *)headView headViewHeight:(CGFloat)headViewHeight cellHeight:(CGFloat)cellHeight cellCount:(CellCountBlock)cellCount cellForRowBlock:(CellForRowBlock)cellForRowBlock actionBlock:(CellActionBlock)actionBlock
{
    self = [[self class] sectionWithHeaderView:headView headerHeight:headViewHeight cells:nil];
    
    _reuseEnabled = YES;
    _reusedCellCount = cellCount;
    _reusedCellHeight = cellHeight;
    
    _cellForRowBlock = cellForRowBlock;
    _reusedCellActionBlock = actionBlock;
    
    return self;
}

- (instancetype)initSectionSupportingReuseWithTitle:(NSString *)title cellHeight:(CGFloat)cellHeight cellCount:(CellCountBlock)cellCount cellForRowBlock:(CellForRowBlock)cellForRowBlock actionBlock:(CellActionBlock)actionBlock {
    self = [[self class] sectionWithHeaderTitle:title cells:nil];
    
    _reuseEnabled = YES;
    _reusedCellCount = cellCount;
    _reusedCellHeight = cellHeight;
    _cellForRowBlock = cellForRowBlock;
    _reusedCellActionBlock = actionBlock;
    
    return self;
}

@end
