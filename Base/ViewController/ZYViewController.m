//
//  ZYViewController.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYViewModel.h"

@interface ZYViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)UIView *pickerBgView;
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIDatePicker *datePickerView;
@property(nonatomic,strong)UIActionSheet *actionSheet;
@end

@implementation ZYViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        /**
         *  默认隐藏
         */
        _tabBarHidden = YES;
    }
    return self;
}
- (void)awakeFromNib
{
    /**
     *  直接通过故事板 跳转 需要通过此方法初始化
     */
    _tabBarHidden = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:_tabBarHidden];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

#pragma mark - action sheet view

- (void)showActionSheet:(NSArray*)buttonTitles
{
    [self showPickerView:NO];
    
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    for(NSString *title in buttonTitles)
    {
        [self.actionSheet addButtonWithTitle:title];
    }
    if(self.tabBarHidden)
    {
        [self.actionSheet showInView:self.view];
    }
    else
    {
        [self.actionSheet showFromTabBar:self.tabBarController.tabBar];
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)///取消按钮
        return;
    self.actionSheetRow = buttonIndex-1;///去除取消按钮
}

#pragma mark - picker date view

- (void)buildDatePickerView
{
    if(self.pickerBgView==nil)
    {
        self.pickerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT)];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped)];
        self.pickerBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        [self.pickerBgView addGestureRecognizer:singleTap];
        [self.view addSubview:self.pickerBgView];
        self.pickerBgView.hidden = YES;
    }
    
    self.datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, FUll_SCREEN_HEIGHT, FUll_SCREEN_WIDTH, 216)];
    self.datePickerView.datePickerMode = UIDatePickerModeDate;
    self.datePickerView.backgroundColor = [UIColor whiteColor];
    self.datePickerView.minimumDate = [NSDate date];
    [self.datePickerView addTarget:self action:@selector(datePickerViewChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.datePickerView];
}
- (void)datePickerViewChanged:(UIDatePicker*)datePicker
{
    self.selecedDate = datePicker.date;
}
- (void)setShowDateBefore:(BOOL)showDateBefore
{
    _showDateBefore = showDateBefore;
    if(!showDateBefore)
    {
        self.datePickerView.minimumDate = [NSDate date];
    }
}
- (void)showDatePickerView:(BOOL)show
{
    if(show)
    {
        self.pickerBgView.hidden = !_datePickerViewTapBlankHidden;
        [self.view bringSubviewToFront:self.pickerBgView];
        [self.view bringSubviewToFront:self.datePickerView];
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect rect = self.datePickerView.frame;
            rect.origin.y = FUll_SCREEN_HEIGHT-rect.size.height;
            self.datePickerView.frame = rect;
            self.pickerBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        } completion:^(BOOL finished) {
        }];
    }
    else
    {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect rect = self.datePickerView.frame;
            rect.origin.y = FUll_SCREEN_HEIGHT;
            self.datePickerView.frame = rect;
            self.pickerBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        } completion:^(BOOL finished) {
            self.pickerBgView.hidden = YES;
        }];
    }
}
#pragma mark - picker view

- (void)buildPickerView
{
    if(self.pickerBgView==nil)
    {
        self.pickerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT)];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped)];
        self.pickerBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        [self.pickerBgView addGestureRecognizer:singleTap];
        [self.view addSubview:self.pickerBgView];
        self.pickerBgView.hidden = YES;
    }
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, FUll_SCREEN_HEIGHT, FUll_SCREEN_WIDTH, 216)];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self.view addSubview:self.pickerView];
    
    @weakify(self)///监听自身row变化 便于初始化选择行
    [[RACObserve(self, selecedRow) skip:1] subscribeNext:^(NSNumber *row) {
        @strongify(self)
        if(self.components.count==0)
            return;
        if(row.longLongValue>=[self.components[0] count])
            return;
       [self.pickerView selectRow:row.longLongValue inComponent:0 animated:NO];
    }];
}
- (void)fingerTapped
{
    [self showPickerView:NO];
    [self showDatePickerView:NO];
}
- (void)showPickerView:(BOOL)show
{
    if(show)
    {
        self.pickerBgView.hidden = !_pickerViewTapBlankHidden;
        [self.view bringSubviewToFront:self.pickerBgView];
        [self.view bringSubviewToFront:self.pickerView];
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect rect = self.pickerView.frame;
            rect.origin.y = FUll_SCREEN_HEIGHT-rect.size.height;
            self.pickerView.frame = rect;
            self.pickerBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect rect = self.pickerView.frame;
            rect.origin.y = FUll_SCREEN_HEIGHT;
            self.pickerView.frame = rect;
            self.pickerBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        } completion:^(BOOL finished) {
            self.pickerBgView.hidden = YES;
        }];
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.components.count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.components[component] count];
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    id  obj = self.components[component][row];
    if([obj isKindOfClass:[NSString class]])
    {
        return obj;
    }
    else if(_pickerShowValueKey.length>0)
    {
        return [obj valueForKey:_pickerShowValueKey];
    }
    return @"";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component==0)
    {
        self.selecedRow = row;
        self.selecedObj = self.components[component][row];
    }
}
- (void)setComponents:(NSArray *)components
{
    _components = components;
    [self.pickerView reloadAllComponents];
}

-(void)keyboardWillShow:(NSNotification*)aNotification{}
-(void)keyboardWillHidden:(NSNotification*)aNotification{}
#pragma mark - tabbar 隐藏方法
- (void)setTabBarHidden:(BOOL)tabBarHidden
{
    _tabBarHidden = tabBarHidden;
    [self.tabBarController.tabBar setHidden:_tabBarHidden];
}
#pragma mark - hud方法
- (void)loading:(BOOL)touch
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled = touch;
    hud.removeFromSuperViewOnHide = YES;
}
- (void)stop
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
- (void)tip:(NSString*)tip touch:(BOOL)touch
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = touch;
    hud.labelText = tip;
    [hud hide:YES afterDelay:1.0];
}
@end
