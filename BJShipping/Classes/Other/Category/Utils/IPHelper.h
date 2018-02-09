//
//  IPHelper.h
//  GHBusinessSv
//
//  Created by RockeyCai on 2017/8/24.
//  Copyright © 2017年 RockeyCai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPHelper : NSObject



/**
 *  单例方法
 *
 *  @return IPHelper
 */
+ (IPHelper *)getInstance;

+ (BOOL)isIpv6;

/**
 获取ipv6还是v4 的接口地址
 */
+(NSString *)getDataURL;

@end
