//
//  UIColor+Hex.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

@interface UIColor (Hex)

/**
 *  十六进制色值
 *
 *  @param color 十六进制色值字符串
 *  @param alpha 透明度
 *
 *  @return 颜色实体类
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
/**
 *  十六进制色值
 *
 *  @param color 十六进制色值字符串
 *
 *  @return 颜色实体类
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

@end
