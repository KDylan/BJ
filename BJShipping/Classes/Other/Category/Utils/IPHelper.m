//
//  IPHelper.m
//  GHBusinessSv
//
//  Created by RockeyCai on 2017/8/24.
//  Copyright © 2017年 RockeyCai. All rights reserved.
//

#import "IPHelper.h"
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
#import "AppHelper.h"

static IPHelper *instance = nil;

@implementation IPHelper

/**
 *  单例方法
 *
 *  @return IPHelper
 */
+ (IPHelper *)getInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[IPHelper alloc] init];
        //instance
    });
    
    return instance;
}


+ (BOOL)isIpv6{
    
    NSArray *searchArray =
    @[ IOS_VPN @"/" IP_ADDR_IPv6,
       IOS_VPN @"/" IP_ADDR_IPv4,
       IOS_WIFI @"/" IP_ADDR_IPv6,
       IOS_WIFI @"/" IP_ADDR_IPv4,
       IOS_CELLULAR @"/" IP_ADDR_IPv6,
       IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
//    NSLog(@"addresses: %@", addresses);
    
    __block BOOL isIpv6 = NO;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         
//         NSLog(@"---%@---%@---",key, addresses[key] );
         
         if ([key rangeOfString:@"ipv6"].length > 0  && ![[NSString stringWithFormat:@"%@",addresses[key]] hasPrefix:@"(null)"] ) {
             
             if ( ![addresses[key] hasPrefix:@"fe80"]) {
                 isIpv6 = YES;
             }
         }
         
     } ];
    
    return isIpv6;
}


+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                        
//                        NSLog(@"ipv4 %@",name);
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
//                        NSLog(@"ipv6 %@",name);
                        
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}


/**
 获取ipv6还是v4 的接口地址
 */
+(NSString *)getDataURL{
    
    if(IPHelper.isIpv6){
        return URLS_DATA_STR_IPV6;
    }else{
        //ipv4
        return URLS_DATA_STR;
    }
    
}


@end
