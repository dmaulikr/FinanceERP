//
//  ZYBusinessApplyListCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/8.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBusinessApplyListCell.h"

@interface ZYBusinessApplyListCell()

@property (strong, nonatomic) UIImageView *cellImageView;
@property (strong, nonatomic) UILabel *cellTitleLabel;
@property (strong, nonatomic) UILabel *cellSubTitleLabel;
@property (strong, nonatomic) UIButton *cellButton;

@end

@implementation ZYBusinessApplyListCell
- (void)awakeFromNib
{
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat width = [ZYBusinessApplyListCell defaultHeight]-2*GAP;
        _cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(GAP, GAP, width, width)];
        [self addSubview:_cellImageView];
        
        CGFloat labelWidth = 100;
        CGFloat labelHeight = 20;
        _cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width+GAP*2, ([ZYBusinessApplyListCell defaultHeight]-labelHeight-labelHeight)/2.f, labelWidth, labelHeight)];
        _cellTitleLabel.font = FONT(17);
        _cellTitleLabel.textColor = YELLOW;
        [self addSubview:_cellTitleLabel];
        
        _cellSubTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width+GAP*2, ([ZYBusinessApplyListCell defaultHeight]-labelHeight-labelHeight)/2.f+labelHeight, labelWidth, labelHeight)];
        _cellSubTitleLabel.font = FONT(13);
        _cellSubTitleLabel.textColor = TITLE_COLOR;
        [self addSubview:_cellSubTitleLabel];
        
        CGFloat buttonWidth = 60;
        CGFloat buttonHeight = 40;
        _cellButton = [[UIButton alloc] initWithFrame:CGRectMake(FUll_SCREEN_WIDTH-GAP-buttonWidth, ([ZYBusinessApplyListCell defaultHeight]-buttonHeight)/2.f, buttonWidth, buttonHeight)];
        _cellButton.backgroundColor = BLUE;
        [_cellButton setTitle:@"申请" forState:UIControlStateNormal];
        [_cellButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cellButton];
        [_cellButton roundRectWith:ROUND_RECT_HEIGHT_RATE*_cellButton.height];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setCellImageName:(NSString *)cellImageName
{
    _cellImageName = cellImageName;
    if(_cellImageView.image==nil)
    {
        _cellImageView.image = [UIImage imageNamed:cellImageName];
    }
}
- (void)setCellTitleText:(NSString *)cellTitleText
{
    _cellTitleText = cellTitleText;
    _cellTitleLabel.text = cellTitleText;
}
- (void)setCellSubTitleText:(NSString *)cellSubTitleText
{
    _cellSubTitleText = cellSubTitleText;
    _cellSubTitleLabel.text = cellSubTitleText;
}
+ (CGFloat)defaultHeight
{
    return 80.f;
}
- (void)buttonPressed:(id)sender {
}
- (RACSignal*)cellButtonPressSignal
{
    if(_cellButtonPressSignal==nil)
    {
        _cellButtonPressSignal = [self rac_signalForSelector:@selector(buttonPressed:)];
    }
    return _cellButtonPressSignal;
}
@end
