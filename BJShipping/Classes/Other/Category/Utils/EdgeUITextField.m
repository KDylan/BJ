//
//  EdgeUITextField.m
//  gd_port
//
//  Created by UEdge on 2017/11/29.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "EdgeUITextField.h"

@implementation EdgeUITextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.size.width/2-50, bounds.origin.y, bounds.size.width, bounds.size.height);//更好理解些
    return inset;
}

@end
