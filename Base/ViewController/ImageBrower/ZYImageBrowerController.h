//
//  ZYImageBrowerController.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/17.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewController.h"

@interface ZYImageBrowerImage : NSObject

@property (nonatomic,strong)UIImage *image;

@property (nonatomic,strong)NSURL *imageUrl;
@end

@interface ZYImageBrowerController : ZYViewController
/**
 *  数组不为空时候为浏览模式 为空的时候现实系统相册
 */
@property(nonatomic,strong)NSArray <ZYImageBrowerImage *> *imageArr;

/**
 *  在现实系统相册时候 判断是多选还是单选
 */
@property(nonatomic,assign)BOOL sigleSelected;

@property(nonatomic,strong)RACSignal *sigleSelecedSignal;

@end
