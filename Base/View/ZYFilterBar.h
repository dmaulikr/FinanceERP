//
//  ZYFilterBar.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/21.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYFilterBar;

@protocol ZYFilterBarDelegate <NSObject>

- (NSArray*)filterBarTitles:(ZYFilterBar*)bar;
- (void)filterBarTitles:(ZYFilterBar*)bar selecedIndex:(NSInteger)selecedIndex;
- (NSArray*)filterBar:(ZYFilterBar*)bar itemsWithIndex:(NSInteger)index level:(NSInteger)level;
- (NSInteger)filterBar:(ZYFilterBar*)bar levelCountWithIndex:(NSInteger)index;
- (BOOL)filterBar:(ZYFilterBar*)bar selecedWithIndex:(NSInteger)index level:(NSInteger)level row:(NSInteger)row object:(id)object;
@end

@interface ZYFilterBar : UIView

@property(nonatomic,assign)id<ZYFilterBarDelegate>delegate;

- (instancetype)initWithController:(UIViewController*)ctl frame:(CGRect)frame delegate:(id)delegate;

- (void)hidden;

- (void)changeTitle:(NSString*)title atIndex:(NSInteger)index;

@property(nonatomic,strong)NSString *showKey;

- (void)reloadDataSource;
@end
