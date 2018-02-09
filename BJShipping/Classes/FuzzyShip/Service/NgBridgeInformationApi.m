//
//  NgBridgeInformationApi.m
//  
//  描述：桥梁信息的服务模型。(自动生成，代码模块1.0v)
//  Created by RockeyCai on 2016-12-22 18:26:21.
//  Copyright (c) 2016年 RockeyCai. All rights reserved.
//
#import "NgBridgeInformationApi.h"
#import "NgBridgeInformationDao.h"

@interface NgBridgeInformationApi()
{
    NgBridgeInformation *_ngBridgeInformation;
}
@end

@implementation NgBridgeInformationApi

/**
 构造方法

 @param ngBridgeInformation 桥梁信息的模型

 @return 桥梁信息的服务模型
 */
- (id)initWithNgBridgeInformation:(NgBridgeInformation *)ngBridgeInformation{
    self = [super init];
    if (self) {
        _ngBridgeInformation = ngBridgeInformation;
    }
    return self;
}

- (NSString *)requestUrl {
    
    long long Id = [NgBridgeInformationDao getMaxId];
    
    return [NSString stringWithFormat:@"/ProvicePublic/NgBridgeInformation/GetNgBridgeInformationList?Id=%lld" , Id];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
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
