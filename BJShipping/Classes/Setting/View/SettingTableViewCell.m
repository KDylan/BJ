//
//  SettingTableViewCell.m
//  GHBusinessSv
//
//  Created by RockeyCai on 2016/11/10.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "SettingTableViewCell.h"
#import "AppHelper.h"

@interface SettingTableViewCell()


@end

@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(DisEnableColor).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, -1, rect.size.width, 1));
    //    [UIColor colorWithHexString:@"e2e2e2"].CGColor
    //下分割线
    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(DisEnableColor).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
