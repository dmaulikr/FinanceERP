//
//  UIView+custom.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (custom)

- (void)roundRectWith:(CGFloat)cornerRadius;

- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

- (CGFloat)X;
- (void)setX:(CGFloat)X;

- (CGFloat)Y;
- (void)setY:(CGFloat)Y;

@end
