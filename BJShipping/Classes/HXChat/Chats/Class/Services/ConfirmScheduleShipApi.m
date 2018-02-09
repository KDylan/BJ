//
//  ConfirmScheduleShipApi.m
//  captain
//
//  Created by RockeyCai on 2016/12/28.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "ConfirmScheduleShipApi.h"

@interface ConfirmScheduleShipApi()
{
    NSString *_msg;
}
@end

@implementation ConfirmScheduleShipApi

/**
 构造方法
 
 @param
 
 @return
 */
- (id)initWithMsg:(NSString *)msg{
    self = [super init];
    if (self) {
        _msg = msg;
    }
    return self;
}

- (NSString *)requestUrl {
    /**
    http://192.168.0.153:9009/api/AppProvicePublic/ConfirmScheduleShip?stId=70&shipId=1312933
     **/
    return [NSString stringWithFormat:@"%@/api/AppProvicePublic/ConfirmScheduleShip?%@" ,IPHelper.getDataURL, _msg];
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
 @return
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
