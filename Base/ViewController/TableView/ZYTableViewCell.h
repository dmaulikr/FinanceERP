//
//  ZYTableViewCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYTableViewCell : UITableViewCell

@property (nonatomic) CGFloat height;
@property (nonatomic,assign) BOOL lineHidden;
@property (nonatomic, copy) dispatch_block_t actionBlock;
/**
 *  静态cell 创建
 *
 *  @param style       cell style
 *  @param height      cell 高度
 *  @param actionBlock 点击事件
 *
 *  @return 实例化对象
 */
+ (instancetype)cellWithStyle:(UITableViewCellStyle)style height:(CGFloat)height actionBlock:(dispatch_block_t)actionBlock;
/**
 *  静态cell 创建  通过xib创建
 *
 *  @param style       cell style
 *  @param height      cell 高度
 *  @param actionBlock 点击事件
 *
 *  @return 实例化对象
 */
+ (instancetype)cellWithNib:(NSString*)nibName height:(CGFloat)height actionBlock:(dispatch_block_t)actionBlock;
+ (instancetype)cellWithXibHeight:(CGFloat)height actionBlock:(dispatch_block_t)actionBlock;
+ (instancetype)cellWithActionBlock:(dispatch_block_t)actionBlock;
+ (instancetype)cellWithXib;
/**
 *  cell高度
 *
 *  @return cell高度
 */
+ (CGFloat)defaultHeight;

/**
 *  cell复用 标示
 *
 *  @return cell复用 标示
 */
+ (NSString*)defaultIdentifier;

@end
