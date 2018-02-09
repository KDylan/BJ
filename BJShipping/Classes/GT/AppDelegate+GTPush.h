//
//  AppDelegate+GTPush.h
//  BJShipping
//
//  Created by UEdge on 2018/2/5.
//  Copyright © 2018年 UEdge. All rights reserved.
//

#import "AppDelegate.h"
#import <GTSDK/GeTuiSdk.h>

@interface AppDelegate (GTPush)<GeTuiSdkDelegate>
/**获取个推url*/
//@property(nonatomic,strong)NSString *gt_url;

/**
 绑定个推别名
 */
-(void)GT_bindAlias;


/**
 解绑个推别名
 */
-(void)GT_unBindAlias;

/**
 注册消息APNS通知声音
 */
-(void)registerRemoteNotification;
/**
 集成个推
 */
-(void)GT_addGtAction;

- (void)GT_userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler;
/** 远程通知注册成功委托 */
- (void)GT_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

/** 远程通知注册失败委托 */
- (void)GT_application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

/** Background Fetch 接口回调处理 */
- (void)GT_application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
- (void)GT_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId;

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error;

/** SDK收到透传消息回调 */
//  当sdk（app）不在前台时候，个推会给苹果APNS推送消息，当app在线时候给app推送消息
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId;

/** SDK收到sendMessage消息回调 *///6eb0c8c2490e1f535351f4f3f682d0e6b6d3ff65c1794721072e7f6d187d0383
- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result;

/** SDK运行状态通知 */
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus;

/** SDK设置推送模式回调 */
- (void)GeTuiSdkDidSetPushMode:(BOOL)isModeOff error:(NSError *)error;

//  监听别名绑定是否成功
- (void)GeTuiSdkDidAliasAction:(NSString *)action result:(BOOL)isSuccess sequenceNum:(NSString *)aSn error:(NSError *)aError;
@end
