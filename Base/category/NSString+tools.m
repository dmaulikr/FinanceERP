//
//  NSString+tools.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/1.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "NSString+tools.h"

@implementation NSString (tools)

+ (BOOL)checkStringIsEmpty:(NSString *)string
{
    if(string == nil)
    {
        return YES;
    }
    if([string isKindOfClass:[NSString class]] == NO)
    {
        return YES;
    }
    
    return [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""];
}
+ (NSString*)notNil:(NSString*)str
{
    if(str==nil)
        return @"";
    return str;
}
+ (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    if(pinYin.length>0)
        return [pinYin substringToIndex:1];
    else
        return nil;
}
+ (NSString *)checkTelephone
{
    return @"1[0-9]{10}";
}
+ (NSString *)checkCardNum
{
    return @"^(\\d{14}|\\d{17})(\\d|[xX])$";
}
@end
