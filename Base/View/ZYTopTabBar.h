//
//  ZYTopTabBar.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYTopTabBar : UIView
@property(nonatomic,assign)CGFloat rate;
@property(nonatomic,strong)RACSignal *tabButtonPressedSignal;
@property(nonatomic,strong)NSMutableArray *buttonArr;
@property(nonatomic,assign)NSInteger highlightIndex;

- (instancetype)initWithTabs:(NSArray*)tabs frame:(CGRect)frame;
@end
