//
//  NSNumber+tools.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/7.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "NSNumber+tools.h"

@implementation NSNumber (tools)

+ (NSNumber*)numberWithString:(NSString*)string
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterNoStyle];
    NSNumber *numTemp = [numberFormatter numberFromString:string];
    return numTemp;
}
+ (NSString*)showPriceWithTenThousand:(CGFloat)tenThousand
{
    if([NSString stringWithFormat:@"%d",(int)(tenThousand*10000.f)].length>=5)
        return [NSString stringWithFormat:@"%.2f万元",tenThousand];
    return [NSString stringWithFormat:@"%d元",(int)(tenThousand*10000.f)];
}

@end
