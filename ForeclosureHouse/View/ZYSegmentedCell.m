//
//  ZYSegmentedCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSegmentedCell.h"

@interface ZYSegmentedCell()

//@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *cellSegmentedControl;

@property (strong, nonatomic) UILabel *cellTitleLabel;
@property (strong, nonatomic) UISegmentedControl *cellSegmentedControl;

@end

@implementation ZYSegmentedCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        RACChannelTo(self,cellSegmentedSelecedIndex) = RACChannelTo(_cellSegmentedControl,selectedSegmentIndex);
        
        _cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, 0, 100, [ZYSegmentedCell defaultHeight])];
        _cellTitleLabel.textAlignment = NSTextAlignmentRight;
        _cellTitleLabel.font = FONT(14);
        _cellTitleLabel.textColor = TITLE_COLOR;
        [self addSubview:_cellTitleLabel];
        
        CGFloat height = 29;
        _cellSegmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(_cellTitleLabel.width+2*GAP, ([ZYSegmentedCell defaultHeight]-height)/2.f, FUll_SCREEN_WIDTH-_cellTitleLabel.width-3*GAP, height)];
        [_cellSegmentedControl addTarget:self action:@selector(segmentedPressed:) forControlEvents:UIControlEventValueChanged];
        _cellSegmentedControl.tintColor = BLUE;
        [self addSubview:_cellSegmentedControl];
        
        RACChannelTo(_cellSegmentedControl,selectedSegmentIndex) = RACChannelTo(self, cellSegmentedSelecedIndex);
    }
    return self;
}

- (void)setCellTitle:(NSString *)cellTitle
{
    _cellTitle = cellTitle;
    _cellTitleLabel.text = cellTitle;
}
- (void)setCellSegmentedTitles:(NSArray *)cellSegmentedTitles
{
    _cellSegmentedTitles = cellSegmentedTitles;
    [_cellSegmentedControl removeAllSegments];
    [cellSegmentedTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_cellSegmentedControl insertSegmentWithTitle:obj atIndex:idx animated:NO];
    }];
}
- (void)segmentedPressed:(UISegmentedControl*)sender {
}
- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    super.userInteractionEnabled = userInteractionEnabled;
    if(userInteractionEnabled)
    {
        _cellSegmentedControl.tintColor = BLUE;
    }
    else
    {
        _cellSegmentedControl.tintColor = TEXT_COLOR;
    }
}
@end
