//
//  ZYTableViewCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"
#import "UIColor+Hex.h"

@interface ZYTableViewCell ()

@end

@implementation ZYTableViewCell
{
    CALayer *line;
}
+ (instancetype)cellWithStyle:(UITableViewCellStyle)style height:(CGFloat)height actionBlock:(dispatch_block_t)actionBlock {
    ZYTableViewCell *cell = [[[self class] alloc] initWithStyle:style reuseIdentifier:nil];
    cell.height = height;
    cell.actionBlock = actionBlock ?: ^{};
    return cell;
}
+ (instancetype)cellWithXibHeight:(CGFloat)height actionBlock:(dispatch_block_t)actionBlock
{
    return [[self class] cellWithNib:NSStringFromClass([self class]) height:height actionBlock:actionBlock];
}
+ (instancetype)cellWithXib
{
    return [[self class] cellWithNib:NSStringFromClass([self class]) height:[[self class] defaultHeight] actionBlock:nil];
}
+ (instancetype)cellWithNib:(NSString*)nibName height:(CGFloat)height actionBlock:(dispatch_block_t)actionBlock
{
    NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:nibName owner:nil options:nil];
    ZYTableViewCell *cell = [nibs lastObject];
    cell.height = height;
    cell.actionBlock = actionBlock ?: ^{};
    return cell;
}
+ (instancetype)cellWithActionBlock:(dispatch_block_t)actionBlock
{
    ZYTableViewCell *cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.height = [[self class] defaultHeight];
    cell.actionBlock = actionBlock ?: ^{};
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (!self) {
        return nil;
    }
    
    self.height = UITableViewAutomaticDimension;
    self.actionBlock = ^{};
    
    return self;
}


- (void)drawRect:(CGRect)rect
{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextFillRect(context, rect);
//    
//    //上分割线，
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"ffffff"].CGColor);
//    CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
//    
//    //下分割线
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"e2e2e2"].CGColor);
//    
//    CGFloat height = 1/[UIScreen mainScreen].scale;
//    CGContextStrokeRect(context, CGRectMake(0, rect.size.height-height, rect.size.width, height));
    if(self.lineHidden)
    {
        return;
    }
    
    if(line==nil)
    {
        line = [CALayer layer];
        line.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"].CGColor;
        CGFloat height = 1/[UIScreen mainScreen].scale;
        line.frame = CGRectMake(0, rect.size.height-height, rect.size.width, height);
        [self.contentView.layer addSublayer:line];
    }
}

+ (CGFloat)defaultHeight
{
    return 44.f;
}
+ (NSString*)defaultIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)setLineHidden:(BOOL)lineHidden
{
    _lineHidden = lineHidden;
    line.hidden = lineHidden;
}
@end
