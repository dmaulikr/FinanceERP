//
//  ZYMacroDefinition.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#ifndef ZYMacroDefinition_h
#define ZYMacroDefinition_h

//#define HOST @"http://192.168.0.100:8080/"
#define HOST @"http://192.168.0.212:8888/"
//#define HOST @"http://172.16.63.68:8080/"

#define FUll_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define FUll_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define GAP 8

#define BLUE [UIColor colorWithHexString:@"0086d1"]
#define ORANGE [UIColor colorWithHexString:@"FF5715"]
#define YELLOW [UIColor colorWithHexString:@"F9BF00"]

#define TITLE_COLOR [UIColor colorWithHexString:@"333333"]
#define TEXT_COLOR [UIColor colorWithHexString:@"999999"]

#define FONT(font) [UIFont systemFontOfSize:font]
/**
 *  圆角比例 对照目标layer 高度
 */
#define ROUND_RECT_HEIGHT_RATE 0.2

#define LOGIN_NOTIFICATION @"loginNotification"
#define LOGOUT_NOTIFICATION @"logoutNotification"

#endif /* ZYMacroDefinition_h */
