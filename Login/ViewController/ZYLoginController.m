//
//  ZYLoginController.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYLoginController.h"

@interface ZYLoginController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ZYLoginController
{
    CAGradientLayer *loginGradient;
}
ZY_VIEW_MODEL_GET(ZYLoginViewModel)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
    [self blendViewModel];
}
- (void)buildUI
{
    ZYLoginViewModel *viewModel = self.viewModel;
    [_loginButton roundRectWith:_loginButton.height*ROUND_RECT_HEIGHT_RATE];
    [_accountTextField roundRectWith:_accountTextField.height*ROUND_RECT_HEIGHT_RATE];
    _accountTextField.text = viewModel.userName;
    [_passwordTextField roundRectWith:_passwordTextField.height*ROUND_RECT_HEIGHT_RATE];
    _passwordTextField.text = viewModel.password;
    
    loginGradient = [CAGradientLayer layer];
    loginGradient.frame = CGRectMake(0, 0, _loginButton.width, _loginButton.height);
    loginGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:@"FFC900"].CGColor,(id)[UIColor colorWithHexString:@"FFA404"].CGColor,nil];
    [_loginButton.layer addSublayer:loginGradient];
    
    CAGradientLayer *bgGradient = [CAGradientLayer layer];
    bgGradient.frame = CGRectMake(0, 0, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT);
    bgGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:@"43b0d4"].CGColor,
                             (id)[UIColor colorWithHexString:@"3690ad"].CGColor,nil];
    [self.view.layer insertSublayer:bgGradient atIndex:0];
}
- (void)blendViewModel
{
    @weakify(self)
    ZYLoginViewModel *viewModel = self.viewModel;
    [[[RACSignal merge:@[RACObserve(viewModel, password),RACObserve(viewModel, userName)]] map:^id(id value) {
        @strongify(self)
        return @(self.accountTextField.text.length!=0&&self.passwordTextField.text.length!=0);
    }] subscribeNext:^(NSNumber *login) {
        _loginButton.userInteractionEnabled = login.boolValue;
        if(login.boolValue)
        {
            loginGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:@"FFC900"].CGColor,(id)[UIColor colorWithHexString:@"FFA404"].CGColor,nil];
        }
        else
        {
            loginGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:@"e3e3e3"].CGColor,(id)[UIColor colorWithHexString:@"c3c3c3"].CGColor,nil];
        }
    }];
    RAC(viewModel,userName) = self.accountTextField.rac_textSignal;
    RAC(viewModel,password) = self.passwordTextField.rac_textSignal;
    
    [[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self loading];
        [[viewModel login] subscribeNext:^(ZYUser *user) {
            [self stop];
            [viewModel saveUserNameAndPassword];
            if(user.loginState==ZYUserLoginSuccess)
            {
                //登陆成功通知
                [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_NOTIFICATION object:user];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } error:^(NSError *error) {
            [self stop];
            [self tip:error.domain];
        } completed:^{
        }];
    }];
}
- (IBAction)loginButtonPressed:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
