//
//  UnBindFuzzyShipApi.m
//  captain
//
//  Created by RockeyCai on 2016/12/27.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "UnBindFuzzyShipApi.h"
//#import "OpenUDID.h"

@interface UnBindFuzzyShipApi()
{
    FuzzyShip *_fuzzyShip;
}
@end

@implementation UnBindFuzzyShipApi

/**
 构造方法
 
 @param fuzzyShip 船只模糊搜索类模型类的模型
 
 @return 船只模糊搜索类模型类的服务模型
 */
- (id)initWithFuzzyShip:(FuzzyShip *)fuzzyShip{
    self = [super init];
    if (self) {
        _fuzzyShip = fuzzyShip;
    }
    return self;
}

- (NSString *)requestUrl {

    NSMutableString *sb = [NSMutableString new];
    NSString* openUDID = [OpenUDID value];

    [sb appendFormat:@"shipId=%@" , _fuzzyShip.ship_id];
    [sb appendFormat:@"&mobileIdentifier=%@" , openUDID];
    
    return [NSString stringWithFormat:@"%@/api/AppProvicePublic/UnBoundShip?%@",IPHelper.getDataURL,sb];
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
