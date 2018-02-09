//
//  EdgeJsonHelper.m
//  gd_port
//
//  Created by UEdge on 2018/1/23.
//  Copyright © 2018年 UEdge. All rights reserved.
//

#import "EdgeJsonHelper.h"

@implementation EdgeJsonHelper

/**
 jsonStr-Dict
 
 @param jsonString json
 @return Dict
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        
        EdgeLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}


/**
 字典转json

 @param dict dict
 @return String
 */
+(NSString *)jsonStringFromDictionary:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
//    NSRange range = {0,jsonString.length};
//    
//    //去掉字符串中的空格
//    
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
//    
//    NSRange range2 = {0,mutStr.length};
//    
//    //去掉字符串中的换行符
//    
//    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
@end
