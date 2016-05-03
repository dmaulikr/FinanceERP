//
//  NSNumber+tools.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/7.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (tools)

+ (NSNumber*)numberWithString:(NSString*)string;
/**
 *  超过五位时候 用万元为单位  小于五位的 以元为单位 要求原始数据是以万元为单位
 */
+ (NSString*)showPriceWithTenThousand:(CGFloat)tenThousand;

@end
