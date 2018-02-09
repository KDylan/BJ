//
//  OnlineServer.m
//  captain
//  心跳数据
//  Created by RockeyCai on 2016/12/28.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "OnlineServer.h"
#import "MSWeakTimer.h"
#import "FuzzyShip.h"
#import "OnlineApi.h"


static OnlineServer *onlineServer = nil;

@interface OnlineServer()

@property (strong, nonatomic) MSWeakTimer *timer;


@end

@implementation OnlineServer


/**
 *  获取单例对象
 *  @return <#return value description#>
 */
+ (OnlineServer *)getSingleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        onlineServer = [[OnlineServer alloc] init];
    });
    
    return onlineServer;
}


/**
 启动在线数据请求
 */
-(void)startOnline{
    
    if ( BBUserDefault.ship) {// 船舶绑定后
        //启动计时器
        [self timerInit];
    }
}



/**
 停止在线数据服务
 */
-(void)stopOnline{
    
    if(self.timer){
        //启动计时器
        self.timer = nil;
    }
}




-(void)timerInit{
    
    if(self.timer){
        self.timer = nil;
    }
    //时间任务 间隔两分钟执行一次
    self.timer = [MSWeakTimer scheduledTimerWithTimeInterval:2 * 60
                                                      target:self
                                                    selector:@selector(sendOnlinState:)
                                                    userInfo:nil
                                                     repeats:YES
                                               dispatchQueue:dispatch_get_main_queue()];
}



/**
 *  发送在线状态
 *
 *  @param userinfo <#userinfo description#>
 */
-(void)sendOnlinState:(id)userinfo{
    
    NSMutableString *q = [NSMutableString new];
    [q appendFormat:@"shipId=%@" , [FuzzyShip getShipInfo].ship_id];
    [q appendFormat:@"&mobileIdentifier=%@" , [OpenUDID value]];
    
    OnlineApi *api = [[OnlineApi alloc] initWithMsg:[q stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSString *json = request.responseString;
        
        if (json) {
            
            NSDictionary *dic = [EdgeJsonHelper dictionaryWithJsonString:json];
            
            BOOL success = [dic objectForKey:@"success"];
            
            if (success) {
                
                BBUserDefault.onlineNum = ++BBUserDefault.onlineNum;
                //发送广播，触发更新
                [[NSNotificationCenter defaultCenter] postNotificationName:@"onlyReloadTable4onlineOrGps" object:nil];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        EdgeLog(@"心跳清除求失败");
    }];
    
    
}


@end
