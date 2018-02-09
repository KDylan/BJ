//
//  EdgeLoginServices.m
//  gd_port
//
//  Created by UEdge on 2017/10/30.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "EdgeLoginServices.h"
#import "NSData+Base64.h"


@interface  EdgeLoginServices()
{
    NSString *_loginCode;
    NSString *_loginPwd;
}
@end

@implementation EdgeLoginServices

- (instancetype)initWithLoginCode:(NSString *)loginCode loginPwd:(NSString *)loginPwd
{
    self = [super init];
    if (self) {
        _loginCode = loginCode ;
        _loginPwd = loginPwd;
    }
    return self;
}

- (NSString *)requestUrl {

    NSString *temp = [NSString stringWithFormat:@"%@/api/UserAuthentication/UserLogin", IPHelper.getDataURL];
    
    return temp;
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
             @"UserCode": _loginCode,
             @"Password": _loginPwd
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
//    NSString *json = [self.requestArgument mj_JSONString];
//    json=[json stringByReplacingOccurrencesOfString:@"{\"" withString:@""];
//    json=[json stringByReplacingOccurrencesOfString:@"\"}" withString:@""];
//    json=[json stringByReplacingOccurrencesOfString:@"\":\"" withString:@"="];
//    json=[json stringByReplacingOccurrencesOfString:@"\",\"" withString:@"&"];
    NSMutableData *postBody=[NSMutableData data];
    [postBody appendData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postBody];//body 数据
    
    EdgeLog(@"request = %@",request);
    return request;
}


//  编码
-(NSString *)banse64Endcode:(NSString *)string{
    
    //  1.将字符串转换成二进制数据
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //  2.返回base64编码结果
    return  [data base64EncodedStringWithOptions:0];
}


@end
