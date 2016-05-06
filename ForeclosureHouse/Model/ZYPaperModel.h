//
//  ZYPaperModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/5.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYStoreModel.h"

@interface ZYPaperModel : ZYStoreModel

@property(nonatomic,strong)NSString *orderInfoPaperTitle;
@property(nonatomic,assign)NSInteger orderInfoPaperCount;
@property(nonatomic,assign)NSInteger orderInfoPaperCopyCount;
@property(nonatomic,strong)NSString *orderInfoPaperContent;

@end
