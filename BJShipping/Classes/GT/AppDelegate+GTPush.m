//
//  AppDelegate+GTPush.m
//  BJShipping
//
//  Created by UEdge on 2018/2/5.
//  Copyright © 2018年 UEdge. All rights reserved.
//
/*{
 "CommandType": "1",
 "CommandDesc": "RequestToUpload",
 "CommandParam": "{}"
 }
 
 {
 "CommandType": 2,
 "CommandDesc": "RequestToUrl",
 "CommandParam": {
 "url": "https://www.baidu.com/"
 }
 }*/
//  --------个推---------------
#define kGtAppId  @"pGoJSoEsvY7Lm4KultU4E9"
#define kGtAppKey  @"hBoAcWDpo661R14YqLVS"
#define kGtAppSecret  @"n7Y8dbU9xw5jYcCvBrh5n5"


#import "AppDelegate+GTPush.h"

#import "FuzzyShip.h"

#import "BaiduLocationServiceHelper.h"

#import "GeTuiMessage.h"


@implementation AppDelegate (GTPush)


/**
 集成个推
 */
-(void)GT_addGtAction{
    
#if !TARGET_OS_SIMULATOR
    // 配置启动SDK
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppId appSecret:kGtAppSecret delegate:self];
    
    //  注册APNS
    [self registerRemoteNotification];
    //是否允许SDK 后台运行（这个一定要设置，否则后台apns不会执行）
    [GeTuiSdk runBackgroundEnable:true];
    
    //  上传位置
    [self uploadLocatonPlace];
    
#endif
}


#pragma mark     ------------------个推通知设置------------------
#pragma mark - 远程通知(推送)回调

/** 远程通知注册成功委托 */
- (void)GT_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    EdgeLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    
    // [ GTSdk ]：向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
    
}
/** 远程通知注册失败委托 */
- (void)GT_application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    EdgeLog(@"\n>>>[DeviceToken Error]:%@\n\n", error.description);
}

/** Background Fetch 接口回调处理 */
- (void)GT_application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    /// Background Fetch   SDK
    [GeTuiSdk resume];
    
    completionHandler(UIBackgroundFetchResultNewData);
}


- (void)GT_userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
{
    EdgeLog(@"消息来了4");
    
    EdgeLog(@"didReceiveNotification：%@", response.notification.request.content.userInfo);
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    
    // 清空个推消息角标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    // [ GTSdk ]：将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:response.notification.request.content.userInfo];
    
    NSDictionary *payload = response.notification.request.content.userInfo;
    
    //  解析数据
    [self parsingPayLoadMes:payload[@"payload"]];
    
#endif
    
    completionHandler();
}

#pragma mark - APP运行中接收到通知(推送)处理 - iOS 10以下版本收到推送

/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
- (void)GT_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    // [ GTSdk ]：将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:userInfo];
    
    // 控制台打印接收APNs信息
    EdgeLog(@"\n>>>[Receive RemoteNotification]:%@\n\n", userInfo);
    
    [self parsingPayLoadMes:userInfo[@"payload"]];
    
    
    completionHandler(UIBackgroundFetchResultNewData);
}


#pragma mark - GeTuiSdkDelegate

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    // [4-EXT-1]: 个推SDK已注册，返回clientId
    EdgeLog(@"\n>>[GTSdk RegisterClient]:%@\n\n", clientId);
    
    if (BBUserDefault.clientId != clientId) {
        BBUserDefault.clientId = clientId;
    }
    
    EdgeLog(@"GeTuiSdk.clientId = %@",GeTuiSdk.clientId);
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    EdgeLog(@"\n>>[GTSdk error]:%@\n\n", [error localizedDescription]);
}

/** SDK收到透传消息回调 */
//  当sdk（app）不在前台时候，个推会给苹果APNS推送消息，当app在线时候给app推送消息
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    
    // [ GTSdk ]：汇报个推自定义事件(反馈透传消息)
    [GeTuiSdk sendFeedbackMessage:90001 andTaskId:taskId andMsgId:msgId];
    
    // 数据转换（接收到的消息）
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    
    EdgeLog(@"========offine======%d",offLine);
    
    if (!offLine) {//  在前台时候，显示提示消息[非离线]
        
        if (payloadMsg) {
            
            GeTuiMessage *mesage = [GeTuiMessage mj_objectWithKeyValues:payloadMsg];
            if (mesage) {
                switch (mesage.CommandType) {
                    case RequestToUpload://1：请求上传gps位置
                    {
                        
                        [[AlertViewHelper getInstance] show:@"提示" msg:@"上传定位"leftTitle:@"取消" leftBlock:^{
                            
                            EdgeLog(@"取消");
                            
                        } rigthTitle:@"确定" rightBlock:^{
                            
                            EdgeLog(@"上传定位");
                            
                            [self uploadLocatonPlace];
                        }];
                        
                    }
                        break;
                    case SchedulingMessages://1：查看通知信息
                    {
                        [[AlertViewHelper getInstance] show:@"提示" msg:@"查看通知"leftTitle:@"取消" leftBlock:^{
                            
                            EdgeLog(@"取消");
                            
                        } rigthTitle:@"确定" rightBlock:^{
                            
                            NSString *url = mesage.CommandParam.url;
                            
                            if (url) {
                                
                                [[EdgeHomeViewController getInstance]showGTWebViewController:url];
                            }
                            
                        }];
                    }
                        break;
                    default:
                        break;
                }
            }
        }
        
    }else{
        
        EdgeLog(@"消息从后台启动->GeTuiSdkDidReceivePayloadData没点击消息");
    }
    
    EdgeLog(@"\n>>[GTSdk ReceivePayload]:%@\n\n", payloadMsg);
}

/** SDK收到sendMessage消息回调 *///6eb0c8c2490e1f535351f4f3f682d0e6b6d3ff65c1794721072e7f6d187d0383
- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result {
    // 发送上行消息结果反馈
    NSString *msg = [NSString stringWithFormat:@"sendmessage=%@,result=%d", messageId, result];
    EdgeLog(@"\n>>[GTSdk DidSendMessage]:%@\n\n", msg);
    
}

/** SDK运行状态通知 */
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
    // 通知SDK运行状态
    EdgeLog(@"\n>>[GTSdk SdkState]:%u\n\n", aStatus);
}

/** SDK设置推送模式回调 */
- (void)GeTuiSdkDidSetPushMode:(BOOL)isModeOff error:(NSError *)error {
    if (error) {
        EdgeLog(@"\n>>[GTSdk SetModeOff Error]:%@\n\n", [error localizedDescription]);
        return;
    }
    
    EdgeLog(@"\n>>[GTSdk SetModeOff]:%@\n\n", isModeOff ? @"开启" : @"关闭");
}

//  监听别名绑定是否成功
- (void)GeTuiSdkDidAliasAction:(NSString *)action result:(BOOL)isSuccess sequenceNum:(NSString *)aSn error:(NSError *)aError {
    if ([kGtResponseBindType isEqualToString:action]) {
        EdgeLog(@"绑定结果 ：%@ !, sn : %@", isSuccess ? @"成功" : @"失败", aSn);
        if (!isSuccess) {
            EdgeLog(@"失败原因: %@", aError);
        }
    } else if ([kGtResponseUnBindType isEqualToString:action]) {
        EdgeLog(@"解除绑定结果 ：%@ !, sn : %@", isSuccess ? @"成功" : @"失败", aSn);
        if (!isSuccess) {
            EdgeLog(@"失败原因: %@", aError);
        }
    }
}

/**
 解析PayLoad数据
 
 @param PayLoad dict
 */
-(void)parsingPayLoadMes:(NSDictionary *)PayLoad{
    GeTuiMessage *mesage = [GeTuiMessage mj_objectWithKeyValues:PayLoad];
    if (mesage) {
        switch (mesage.CommandType) {
            case RequestToUpload://1：请求上传gps位置
            {
                EdgeLog(@"上传位置");
                //  上传位置
                [self uploadLocatonPlace];
            }
                break;
                
            case SchedulingMessages://1：查看通知信息
            {
                EdgeLog(@"打开页面");
                
                NSString *url = mesage.CommandParam.url;
                if (url) {
                    
                    [[EdgeHomeViewController getInstance]showGTWebViewController:url];
                }
                
            }
                break;
            default:
                break;
        }
        
    }
    
}

-(void)uploadLocatonPlace{
    
    //      上传船舶定位
    if (BBUserDefault.ship) {//  已经绑定船舶
        
        EdgeLog(@"开始上传定位");
        //上传位置信息
        [[BaiduLocationServiceHelper getSingleton] sendGSPInfo];
        
    }else{
        
        EdgeLog(@"请先绑定船舶再传数据服务");
    }
}


/**
 注册消息APNS通知声音
 */
-(void)registerRemoteNotification{
    /*
     警告：该方法需要开发者自定义，以下代码根据APP支持的iOS系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的iOS系统都能获取到DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                EdgeLog(@"request authorization succeeded!");
            }
            if (granted) {
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
        
        
#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
}

/**
 绑定个推别名
 */
-(void)GT_bindAlias{
    
    FuzzyShip *ship = [FuzzyShip getShipInfo];
    if (ship) {
        // 绑定别名
        [GeTuiSdk bindAlias:ship.ship_id andSequenceNum:ship.ship_id];
    }
}


/**
 解绑个推别名
 */
-(void)GT_unBindAlias{
    
    FuzzyShip *ship = [FuzzyShip getShipInfo];
    if (ship) {
        // 绑定别名
        [GeTuiSdk unbindAlias:ship.ship_id  andSequenceNum:[NSString stringWithFormat:@"%@",ship.ship_id ] andIsSelf:YES];
    }
}



@end
