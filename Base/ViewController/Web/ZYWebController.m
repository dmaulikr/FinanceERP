//
//  ZYWebController.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/3.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYWebController.h"
#import <NJKWebViewProgress.h>

@interface ZYWebController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (strong, nonatomic)NJKWebViewProgress *progressProxy;

@end

@implementation ZYWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"广告";
    
    [_progressView setProgress:0 animated:NO];
    
    _progressProxy = [[NJKWebViewProgress alloc] init]; // instance variable
    self.webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    if(self.url.length>0)
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
        [self.webView loadRequest:request];
    }
}
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [self.progressView setProgress:progress animated:NO];
    if(progress==1)
    {
        _progressView.hidden = YES;
    }
    else
    {
        _progressView.hidden = NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
