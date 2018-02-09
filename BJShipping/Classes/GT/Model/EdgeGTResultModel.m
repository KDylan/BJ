//
//  EdgeGTResultModel.m
//  gd_port
//
//  Created by UEdge on 2017/11/2.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "EdgeGTResultModel.h"

@implementation EdgeGTResultModel

/**
 设置状态
 
 @return bool
 */
-(BOOL)success{
    if ([self.ERROR_CODE isEqualToString:@"0"]) {
        return YES;
    }else{
        
        return NO;
    }
}


@end
