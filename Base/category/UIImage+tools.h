//
//  UIImage+tools.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/18.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (tools)
+ (NSURL*)saveImage:(UIImage*)image withFileName:(NSString*)fileName;
@end
