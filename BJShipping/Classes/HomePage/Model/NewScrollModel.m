//
//  NewScrollModel.m
//  BJShipping
//
//  Created by UEdge on 2018/2/2.
//  Copyright © 2018年 UEdge. All rights reserved.
//

#import "NewScrollModel.h"

@implementation NewScrollModel

//数组中需要转换的模型类
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"rows" : @"EdgeScycleNewsModel"
             };
}

@end
