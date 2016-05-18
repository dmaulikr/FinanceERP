//
//  ZYHeadImageCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/16.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"

@interface ZYHeadImageCell : ZYTableViewCell

@property(nonatomic,strong)RACSignal *cellHeadImageButtonPressSignal;

@property(nonatomic,copy)NSString *cellTitle;

@property(nonatomic,strong)NSURL *cellHeadImageUrl;

@property(nonatomic,strong)UIImage *cellHeadImage;

@property(nonatomic,assign)BOOL cellUploadSuccess;

@end
