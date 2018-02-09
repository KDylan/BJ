//
//  imageScrollServices.m
//  BJShipping
//
//  Created by UEdge on 2018/2/2.
//  Copyright © 2018年 UEdge. All rights reserved.
//

#import "imageScrollServices.h"

@implementation imageScrollServices

-(instancetype)initWithImageScrollServices;

{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)requestUrl {
//   http://192.168.0.153:9009/api/BjGateway/GetNewsList?nn_news_type=2

    NSString *temp = [NSString stringWithFormat:@"%@/api/BjGateway/GetNewsList?nn_news_type=2", IPHelper.getDataURL];
    
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
    return @{};
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
 
    EdgeLog(@"request = %@",request);
    return request;
}


@end
