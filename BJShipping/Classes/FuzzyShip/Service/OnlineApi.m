//
//  OnlineApi.m
//  captain
//
//  Created by RockeyCai on 2016/12/28.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "OnlineApi.h"

@interface OnlineApi()
{
    NSString *_msg;
}
@end

@implementation OnlineApi

/**
 构造方法
 
 @return msg
 */
- (id)initWithMsg:(NSString *)msg{
    self = [super init];
    if (self) {
        _msg = msg;
    }
    return self;
}

- (NSString *)requestUrl {
   
    return [NSString stringWithFormat:@"%@/api/AppProvicePublic/ShipHeartBeat?%@",IPHelper.getDataURL, _msg];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

/**
 - (NSTimeInterval)requestTimeoutInterval
 {
 return 60;
 }
 **/

/**
 请求参数设置
 @return id
 */
- (id)requestArgument {
    /** **/
    return @{
             };
}


/**
 验证服务器返回内容
 
 @return
 
 - (id)jsonValidator {
 return @{
 @"user_name": [NSNumber class],
 @"user_password": [NSNumber class]
 };
 }
 */



@end
