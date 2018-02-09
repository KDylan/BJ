//
//  AppInfoService.m
//  GHBusinessSv
//
//  Created by RockeyCai on 2016/12/9.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "AppInfoService.h"

@interface  AppInfoService()
{
    NSString *_url;
}
@end

@implementation AppInfoService

- (id)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/ProvicePublic/AppInfo/GetLastVersion?appType=iosCaptain";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}


/**
 请求参数设置
 
 @return <#return value description#>
 */
- (id)requestArgument {
    /** **/
    return @{
             @"appType": @"iosCaptain"
             };
}

@end
