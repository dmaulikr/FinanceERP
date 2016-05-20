//
//  ZYHeadImageCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/16.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYHeadImageCell.h"
#import <UIButton+AFNetworking.h>
#import <MBProgressHUD.h>
#import "ZYImageBrowerController.h"

@interface ZYHeadImageCell()

@property (strong, nonatomic) UILabel *cellTitleLabel;

@property (strong, nonatomic) UIButton *addButton;

@property (strong, nonatomic) UILabel *bgView;

@end

@implementation ZYHeadImageCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellHeadImage = [UIImage imageNamed:@"headImage"];
        self.cellHeadImageUrl = [[NSBundle mainBundle] URLForResource:@"headImage" withExtension:@"png"];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, 0, 100, [ZYHeadImageCell defaultHeight])];
        _cellTitleLabel.textAlignment = NSTextAlignmentRight;
        _cellTitleLabel.font = FONT(14);
        _cellTitleLabel.textColor = TITLE_COLOR;
        [self addSubview:_cellTitleLabel];
        
        
        CGFloat buttonWidth = [ZYHeadImageCell defaultHeight]-2*GAP;
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(_cellTitleLabel.width+2*GAP, GAP, buttonWidth, buttonWidth)];
        [_addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [self addSubview:_addButton];
        
        _bgView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonWidth)];
        _bgView.textColor = [UIColor whiteColor];
        _bgView.font = [UIFont systemFontOfSize:12];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _bgView.userInteractionEnabled = NO;
        _bgView.hidden = YES;
        [_addButton addSubview:_bgView];
        
        UIActivityIndicatorView *hud = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        hud.frame = CGRectMake(0, 0, 30, 30);
        hud.userInteractionEnabled = NO;
        [_bgView addSubview:hud];
        hud.center = _bgView.center;
        
        self.cellUploadSuccess = YES;
        [RACObserve(self, cellUploadSuccess) subscribeNext:^(NSNumber *cellUploadSuccess) {
            if(cellUploadSuccess.boolValue)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.f];
                } completion:^(BOOL finished) {
                    _bgView.hidden = YES;
                    [hud stopAnimating];
                }];
            }
            else
            {
                [UIView animateWithDuration:0.2 animations:^{
                    _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
                } completion:^(BOOL finished) {
                    _bgView.hidden = NO;
                    [hud startAnimating];
                }];
            }
        }];
    }
    return self;
}
+ (CGFloat)defaultHeight
{
    return 80;
}
- (RACSignal*)cellHeadImageButtonPressSignal
{
    if(_cellHeadImageButtonPressSignal==nil)
    {
        _cellHeadImageButtonPressSignal = [[_addButton rac_signalForControlEvents:UIControlEventTouchUpInside] map:^id(id value) {
            ZYImageBrowerImage *image = [[ZYImageBrowerImage alloc] init];
            image.image = self.cellHeadImage;
            image.imageUrl = self.cellHeadImageUrl;
            return @[image];
        }];
    }
    return _cellHeadImageButtonPressSignal;
}
- (void)setCellTitle:(NSString *)cellTitle
{
    _cellTitle = cellTitle;
    _cellTitleLabel.text = cellTitle;
}
- (void)setCellHeadImageUrl:(NSURL *)cellHeadImageUrl
{
    _cellHeadImageUrl = cellHeadImageUrl;
    [_addButton setImageForState:UIControlStateNormal withURL:self.cellHeadImageUrl placeholderImage:[UIImage imageNamed:@"headImage"]];
}
- (void)setCellHeadImage:(UIImage *)cellHeadImage
{
    _cellHeadImage = cellHeadImage;
    [_addButton setImage:cellHeadImage forState:UIControlStateNormal];
}
@end
