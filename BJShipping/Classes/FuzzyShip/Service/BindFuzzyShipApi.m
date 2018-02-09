//
//  BindFuzzyShipApi.m
//  captain
//
//  Created by RockeyCai on 2016/12/26.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "BindFuzzyShipApi.h"

@interface BindFuzzyShipApi()
{
    FuzzyShip *_fuzzyShip;
}
@end

@implementation BindFuzzyShipApi

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
//    http://192.168.0.153:9009/api/AppProvicePublic/BoundShip?shipId=413902409&mobileIdentifier=78651577&shipName=藤县太平4097&clientId=78651577&type=web&ticket=lht&
//    shipId=413902409&mobileIdentifier=78651577&shipName=藤县太平4097&clientId=78651577&type=web&ticket=lht&
    NSMutableString *sb = [NSMutableString new];
    NSString* openUDID = [OpenUDID value];
    NSLog(@"openUDID = %@",openUDID);
    [sb appendFormat:@"shipId=%@" , _fuzzyShip.ship_id];
    [sb appendFormat:@"&shipName=%@" , [_fuzzyShip.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [sb appendFormat:@"&mobileIdentifier=%@" , openUDID];
    [sb appendFormat:@"&clientId=%@" , BBUserDefault.clientId];
    
    //url中文乱码
    return [NSString stringWithFormat:@"%@/api/AppProvicePublic/BoundShip?%@",IPHelper.getDataURL,sb];
   
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
 @returnnil
 */
- (id)requestArgument {
    /****/
    return @{
             //@"PinYinShipName" : _PinYinShipName
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
