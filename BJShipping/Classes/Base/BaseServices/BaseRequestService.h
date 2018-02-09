//
//  BaseService.h
//  MobileProject 继承于YTKBaseRequest 可以处理一些共同的事情
//
//  Created by wujunyang on 16/7/22.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKBaseRequest.h"
#import "AppHelper.h"

@interface BaseRequestService : YTKBaseRequest


/**
 自定义POST请求
 
 @return <#return value description#>
 */
- (NSURLRequest *)doBuildCustomUrlRequest;

@end
