//
//  NSString+JSON2Param.m
//  GHBusinessSv
//
//  Created by RockeyCai on 2017/8/4.
//  Copyright © 2017年 RockeyCai. All rights reserved.
//

#import "NSString+JSON2Param.h"

@implementation NSString (JSON2Param)


-(NSString *)json2Param{
    
    NSString *json= [self stringByReplacingOccurrencesOfString:@"{\"" withString:@""];
    json=[json stringByReplacingOccurrencesOfString:@"\"}" withString:@""];
    json=[json stringByReplacingOccurrencesOfString:@"\":\"" withString:@"="];
    json=[json stringByReplacingOccurrencesOfString:@"\",\"" withString:@"&"];
    
    return json;
}



@end
