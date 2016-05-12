//
//  ZYBusinessProcessingStatePageModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  每一页显示的数据
 */
@interface ZYBusinessProcessingStatePageModel : NSObject

@property(nonatomic,copy)NSString *businessProcessingStatePageName;

@property(nonatomic,copy)NSString *businessProcessingStatePageFinishDate;
@property(nonatomic,copy)NSString *businessProcessingStatePageHandler;
@property(nonatomic,copy)NSString *businessProcessingStatePageOperrator;
@property(nonatomic,copy)NSString *businessProcessingStatePageHandleDays;
@property(nonatomic,copy)NSString *businessProcessingStatePageRegulationsDays;
@property(nonatomic,copy)NSString *businessProcessingStatePageDifferents;
@property(nonatomic,copy)NSString *businessProcessingStatePageRemark;
@end
