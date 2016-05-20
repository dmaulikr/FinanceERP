//
//  ZYUserInfoViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"

@interface ZYUserInfoViewModel : ZYViewModel

/**
 *  头像上传
 */
@property(nonatomic,assign)NSInteger fileID;

@property(nonatomic,strong)UIImage *headImage;

@property(nonatomic,strong)NSURL *headImageUrl;

@property(nonatomic,assign)BOOL headImageUploadSuccess;

@property(nonatomic,assign)BOOL loading;

@property(nonatomic,strong)NSString *error;

- (void)uploadHeadImage;


@property(nonatomic,strong)NSArray *titleArr;

@end
