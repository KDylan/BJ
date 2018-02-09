//
//  EdgeScycleNewsModel.m
//  BJShipping
//
//  Created by UEdge on 2018/2/2.
//  Copyright © 2018年 UEdge. All rights reserved.
//

#import "EdgeScycleNewsModel.h"

@implementation EdgeScycleNewsModel


- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    if (oldValue == nil) {
        return @"";  // 以字符串类型为例
    }
    return oldValue;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}

@end
