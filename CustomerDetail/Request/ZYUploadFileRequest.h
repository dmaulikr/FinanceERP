//
//  ZYUploadFileRequest.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/16.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRequest.h"

@interface ZYUploadFileRequest : ZYRequest

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)NSURL *imageUrl;

@property(nonatomic,assign)NSInteger userId;

@end
