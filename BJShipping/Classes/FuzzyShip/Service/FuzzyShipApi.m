//
//  FuzzyShipApi.m
//  
//  描述：船只模糊搜索类模型类的服务模型。(自动生成，代码模块1.0v)
//  Created by RockeyCai on 2016-12-26 12:06:34.
//  Copyright (c) 2016年 RockeyCai. All rights reserved.
//
#import "FuzzyShipApi.h"

@interface FuzzyShipApi()
{
    NSString *_PinYinShipName;
}
@end

@implementation FuzzyShipApi

/**
 构造方法

 @param pinYinShipName 船只模糊搜索类模型类的模型

 @return 船只模糊搜索类模型类的服务模型
 */
- (id)initWithFuzzyShip:(NSString *)pinYinShipName{
    self = [super init];
    if (self) {
        _PinYinShipName = pinYinShipName;
    }
    return self;
}

- (NSString *)requestUrl {
    //url中文乱码
//    return [NSString stringWithFormat:@"/Common/MapOCX/FuzzyShip?PinYinShipName=%@" , [_PinYinShipName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    return [NSString stringWithFormat:@"%@/api/BjShipManage/GetFuzzyShipByPinYinShipName?PinYinShipName=%@&type=web&ticket=lht" ,IPHelper.getDataURL,[_PinYinShipName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
 @return nil
 */
- (id)requestArgument {
    /****/
    return @{
              @"PinYinShipName" : _PinYinShipName
             };
     
}


/****/
//设置响应参数类型
- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeJSON;
}


//设置请求参数类型
- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeHTTP;
}


@end
