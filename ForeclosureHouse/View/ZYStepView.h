//
//  ZYStepView.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYStepView : UIView
- (void)highlight:(BOOL)highlight;
@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)UIColor *highlightColor;
@end
