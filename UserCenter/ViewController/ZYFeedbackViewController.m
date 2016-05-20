//
//  ZYFeedbackViewController.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYFeedbackViewController.h"

#define MAX_LENGTH 100

@interface ZYFeedbackViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

@end

@implementation ZYFeedbackViewController
ZY_VIEW_MODEL_GET(ZYFeedbackViewViewModel)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self blendViewModel];
}
- (void)blendViewModel
{
    [[self.textView rac_textSignal] subscribeNext:^(id x) {
        self.viewModel.feedbackText = x;
    }];
    [[RACObserve(self.viewModel, error) skip:1] subscribeNext:^(id x) {
        [self tip:x touch:YES];
    }];
    [[RACObserve(self.viewModel, loading) skip:1] subscribeNext:^(id x) {
        if([x boolValue])
        {
            [self loading:YES];
        }
        else
        {
            [self stop];
        }
    }];
    [[RACObserve(self.viewModel, feedbackSuccess) skip:1] subscribeNext:^(id x) {
        if([x boolValue])
        {
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
        }
    }];
}
- (void)dismiss
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)commitButtonPressed:(id)sender {
    [self.viewModel feedbackRequest];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(textView.text.length+text.length>MAX_LENGTH)///限制长度
    {
        NSMutableString *str = [NSMutableString stringWithString:textView.text];
        [str replaceCharactersInRange:range withString:text];
        textView.text = [str substringToIndex:MAX_LENGTH];
                return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    self.wordLabel.text = [NSString stringWithFormat:@"%lu个字",(unsigned long)textView.text.length];

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
