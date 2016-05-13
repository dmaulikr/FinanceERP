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
/**
 *  当前步骤对应的id
 */
@property(nonatomic,assign)NSInteger businessProcessingStatePageStepID;
/**
 *  当前步骤对应的名称
 */
@property(nonatomic,copy)NSString *businessProcessingStatePageName;

/**
 *  当前步骤 完成时间
 */
@property(nonatomic,copy)NSString *businessProcessingStatePageFinishDate;
/**
 *  办理人
 */
@property(nonatomic,copy)NSString *businessProcessingStatePageHandler;
/**
 *  操作人
 */
@property(nonatomic,copy)NSString *businessProcessingStatePageOperrator;
/**
 *  操作天数
 */
@property(nonatomic,copy)NSString *businessProcessingStatePageHandleDays;
/**
 *  规定天数
 */
@property(nonatomic,copy)NSString *businessProcessingStatePageRegulationsDays;
/**
 *  差异
 */
@property(nonatomic,copy)NSString *businessProcessingStatePageDifferents;
/**
 *  备注
 */
@property(nonatomic,copy)NSString *businessProcessingStatePageRemark;
@end
