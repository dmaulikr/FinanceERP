//
//  NSString+tools.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/1.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (tools)

+ (BOOL)checkStringIsEmpty:(NSString *)string;

+ (NSString*)notNil:(NSString*)str;

+ (NSString *)firstCharactor:(NSString *)aString;

+ (NSString *)checkTelephone;

+ (NSString *)checkCardNum;
@end
