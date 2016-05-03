//
//  UIView+custom.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "UIView+custom.h"

@implementation UIView (custom)

- (void)roundRectWith:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    //    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
}

- (CGFloat)width
{
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)height
{
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)X
{
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)X
{
    CGRect rect = self.frame;
    rect.origin.x = X;
    self.frame = rect;
}

- (CGFloat)Y
{
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)Y
{
    CGRect rect = self.frame;
    rect.origin.y = Y;
    self.frame = rect;
}

@end
