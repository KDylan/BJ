//
//  OnlineServer.h
//  captain
//
//  Created by RockeyCai on 2016/12/28.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OnlineServer : NSObject


/**
 *  获取单例对象
 *  @return <#return value description#>
 */
+ (OnlineServer *)getSingleton;


/**
 启动在线数据请求
 */
-(void)startOnline;


/**
 停止在线数据服务
 */
-(void)stopOnline;

@end
