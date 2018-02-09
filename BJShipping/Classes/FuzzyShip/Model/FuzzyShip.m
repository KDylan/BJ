//
//  FuzzyShip.m
//  
//  描述：船只模糊搜索类模型类的映射模型。(自动生成，代码模块1.0v)
//  Created by RockeyCai on 2016-12-26 12:06:34.
//  Copyright (c) 2016年 RockeyCai. All rights reserved.
//

#import "FuzzyShip.h"

@implementation FuzzyShip



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


/**
 获取绑定船只
 
 @return model
 */
+(FuzzyShip *)getShipInfo{
    
    NSString *json = BBUserDefault.ship;
    
    if (json) {
        
        return [FuzzyShip mj_objectWithKeyValues:json];
    }
    return nil;
}



@end

