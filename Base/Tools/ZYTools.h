//
//  ZYTools.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/26.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>

#define userNameKeychainName @"YvZ73Nkp"
#define passwordKeychainName @"nUa40rxz"

#define __BASE64( text )        [ZYTools base64StringFromText:text]
#define __TEXT( base64 )        [ZYTools textFromBase64String:base64]
@interface ZYTools : NSObject
/******************************************************************************
 函数名称 : + (NSString *)base64StringFromText:(NSString *)text
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)text    文本
 输出参数 : N/A
 返回参数 : (NSString *)    base64格式字符串
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64StringFromText:(NSString *)text;

/******************************************************************************
 函数名称 : + (NSString *)textFromBase64String:(NSString *)base64
 函数描述 : 将base64格式字符串转换为文本
 输入参数 : (NSString *)base64  base64格式字符串
 输出参数 : N/A
 返回参数 : (NSString *)    文本
 备注信息 :
 ******************************************************************************/
+ (NSString *)textFromBase64String:(NSString *)base64;
/**
 *  根据当前安装版本生成一个唯一字符串
 *
 *  @return 唯一标示
 */
+ (NSString *)appVersionToken;
/**
 *  钥匙串 存储用户的账号密码
 */
+ (id)getKeychain:(NSString *)service;
+ (void)saveKeychain:(NSString *)service data:(id)data;
+ (BOOL)hasAccountAndPassword;

+ (NSString*)getDirectoryForDocuments:(NSString*)dir;
/**
 *  清除缓存
 */
+ (BOOL)clearCache;
/**
 *  检查是否登陆
 */
+ (BOOL)checkLogin;
@end
