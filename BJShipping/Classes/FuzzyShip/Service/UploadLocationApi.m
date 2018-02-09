//
//  UploadLocationApi.m
//  captain
//
//  Created by RockeyCai on 2016/12/27.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "UploadLocationApi.h"

@interface UploadLocationApi()
{
    NSString *_testHelperState;
    NSString *_shipId;
    NSString *_userId;
    NSString *_lat;
    NSString *_lng;
    NSString *_gpsTime;
}

@end

@implementation UploadLocationApi

/**
 构造方法
 
 @param testHelperState false
 @param shipId 船名id
 @param userId userid
 @param lat 纬度
 @param gpsTime 精度
 @return id
 */
- (instancetype)initWithtestHelperState:(NSString *)testHelperState shipId:(NSString *)shipId  userId:(NSString *)userId lat:(NSString *)lat lng:(NSString *)lng  gpsTime:(NSString *)gpsTime{
    
    self = [super init];
    if (self) {
        _testHelperState = testHelperState ;
        _shipId = shipId;
        _userId = userId ;
        _lat = lat;
        _lng = lng ;
        _gpsTime = gpsTime;
    }
    return self;
}

- (NSString *)requestUrl {
    
    //    http://192.168.0.153:9009/api/BjShipManage/PositionAssistant
    return [NSString stringWithFormat:@"%@/api/BjShipManage/PositionAssistant",IPHelper.getDataURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

/**
 请求参数设置
 @return id
 */
- (id)requestArgument {
    return @{
             @"testHelperState": _testHelperState,
             @"shipId": _shipId,
             @"userId": _userId,
             @"lat": _lat,
             @"lng": _lng,
             @"gpsTime": _gpsTime,
             };
}




/**
 自定义请求
 
 @return id
 */
- (NSURLRequest *)buildCustomUrlRequest {
    
    NSURL *serverUrl = [NSURL URLWithString:self.requestUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serverUrl
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:30];
    
    [request setValue: @"application/json" forHTTPHeaderField:@"Content-Type"];//请求头
    [request setValue: Authorization  forHTTPHeaderField:@"Authorization"];//请求头
    
    [request setHTTPMethod:@"POST"];//POST请求
    
    NSString *json = [EdgeJsonHelper jsonStringFromDictionary:self.requestArgument];
    
    NSMutableData *postBody=[NSMutableData data];
    [postBody appendData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postBody];//body 数据
    
    EdgeLog(@"request = %@",request);
    return request;
}


@end
