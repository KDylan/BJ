//
//  EdgeJsonHelper.h
//  gd_port
//
//  Created by UEdge on 2018/1/23.
//  Copyright © 2018年 UEdge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EdgeJsonHelper : NSObject

/**
 json-Dict

 @param jsonString json
 @return Dict
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;



/**
 Dict-jsonStr
 
 @param dict dict
 @return String
 */
+(NSString *)jsonStringFromDictionary:(NSDictionary *)dict;

@end
