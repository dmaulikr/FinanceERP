//
//  ZYViewController.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <UIKit/UIKit.h>
///RAC框架
#import <ReactiveCocoa.h>
#import <MBProgressHUD.h>

///获取viewModel 使用下面两个宏
#define ZY_VIEW_MODEL_GET(Class)\
\
- (Class*)viewModel\
{\
    if(_viewModel==nil)\
    {\
        _viewModel = [[Class alloc] init];\
    }\
    return _viewModel;\
}\

#define ZY_VIEW_MODEL_GET_DECODE(Class)\
- (Class*)viewModel\
{\
    if(_viewModel==nil)\
    {\
        NSData *_data = [[NSData alloc] initWithContentsOfFile:[ZYTools getDirectoryForDocuments:@"model" modelKey:NSStringFromClass([Class class])]];\
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:_data];\
        _viewModel = [unarchiver decodeObjectForKey:NSStringFromClass([Class class])];\
        [unarchiver finishDecoding];\
        if(_viewModel==nil)\
        {\
            _viewModel = [[Class alloc] init];\
        }\
    }\
    return _viewModel;\
}\

#define ZY_VIEW_MODEL_ENCODE(Class)\
- (void)encode\
{\
    NSMutableData *data = [[NSMutableData alloc] init];\
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];\
    [archiver encodeObject:_viewModel forKey:NSStringFromClass([Class class])];\
    [archiver finishEncoding];\
    [data writeToFile:[ZYTools getDirectoryForDocuments:@"model" modelKey:NSStringFromClass([Class class])] atomically:YES];\
}\

#define ZY_VIEW_MODEL_PROPERTY(Class)\
@property(nonatomic,strong)Class *viewModel;\

@interface ZYViewController : UIViewController

@property(nonatomic,assign)BOOL tabBarHidden;
/**
 *  picker数据源 双层数组 可以不是string对象 但是要指明key
 */
@property(nonatomic,strong)NSArray *components;
@property(nonatomic,strong)NSString *pickerShowValueKey;
@property(nonatomic,assign)BOOL pickerViewTapBlankHidden;

- (void)showPickerView:(BOOL)show;
/**
 *  暂时只支持 单列数据读取
 */
@property(nonatomic,assign)NSInteger selecedRow;///选择的行
@property(nonatomic,strong)id selecedObj;///选择的对象
/**
 *  actionSheet 数据源
 */

@property(nonatomic,assign)NSInteger actionSheetRow;
- (void)showActionSheet:(NSArray*)buttonTitles;


- (void)buildPickerView;///根据需要 创建


@property(nonatomic,strong)NSDate *selecedDate;
@property(nonatomic,assign)BOOL showDateBefore;// 是否显示之前的日期
- (void)buildDatePickerView;///时间选择
- (void)showDatePickerView:(BOOL)show;

@property(nonatomic,assign)BOOL datePickerViewTapBlankHidden;
//逐个页面加载 很多页面时候 这样可以提高进入页面速度
@property(nonatomic,assign)BOOL singelLoad;
/**
 *  键盘
 */
-(void)keyboardWillShow:(NSNotification*)aNotification;
-(void)keyboardWillHidden:(NSNotification*)aNotification;
/**
 *  加载。。
 *
 *  @param touch hud是否可以触摸 可以的话 hud就获取触摸响应 后面的层无法接收触摸
 */
- (void)loading:(BOOL)touch;
/**
 *  停止加载
 */
- (void)stop;
/**
 *  提示
 *
 *  @param tip   提示
 *  @param touch hud是否可以触摸 可以的话 hud就获取触摸响应 后面的层无法接收触摸
 */
- (void)tip:(NSString*)tip touch:(BOOL)touch;

@end
