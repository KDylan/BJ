//
//  BaseService.m
//  MobileProject
//
//  Created by wujunyang on 16/7/22.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "BaseRequestService.h"
//#import "YYModel.h"
#import "IPHelper.h"
#import "AppHelper.h"

@implementation BaseRequestService

//公共头部设置
- (NSDictionary *)requestHeaderFieldValueDictionary
{
    NSDictionary *headerDictionary=@{
                                     @"Authorization":@"C8GNV1NyBGV/JWIUg0+YySCwH3n3yLJR",
                                     @"Content-Type":@"application/x-www-form-urlencoded"
                                     };
    return headerDictionary;
}

/****/
//设置响应参数类型
- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeHTTP;
}


//设置请求参数类型
- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}


/**
 自定义POST请求
 
 @return <#return value description#>
 */
- (NSURLRequest *)doBuildCustomUrlRequest {
    
    NSURL *serverUrl = [NSURL URLWithString:self.requestUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serverUrl
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:30];

    [request setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];//请求头
    [request setValue: Authorization  forHTTPHeaderField:@"Authorization"];//请求头
    
    [request setHTTPMethod:@"POST"];//POST请求
    
    NSString *json = [self.requestArgument mj_JSONString];
    
    
    
    
    if (json) {
        //{"appType":"iosWater","appType1":"iosWater1"} 转为 appType=iosWater&appType1=iosWater1
        
        //login_pwd=F59BD65F7EDAFB087A81D4DCA06C4910&login_type=GHGLBM&login_name=谢灵露&data_limit":440112,"login_department_name=广州港务局黄埔分局&create_group":1,"admin_division=440112&login_department":440112,"login_code=xll
        
        json=[json stringByReplacingOccurrencesOfString:@"{\"" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"\"}" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"{" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"}" withString:@""];
        
        json=[json stringByReplacingOccurrencesOfString:@"\":\"" withString:@"="];
        json=[json stringByReplacingOccurrencesOfString:@"\",\"" withString:@"&"];
        json=[json stringByReplacingOccurrencesOfString:@"\":" withString:@"="];
        json=[json stringByReplacingOccurrencesOfString:@",\"" withString:@"&"];
        
        NSMutableData *postBody=[NSMutableData data];
        [postBody appendData:[json dataUsingEncoding:NSUTF8StringEncoding]];//把bodyString转换为NSData数据
        [request setHTTPBody:postBody];//body 数据
    }
    return request;
}


@end
