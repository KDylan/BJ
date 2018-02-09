//
//  AppDelegate.h
//  BJShipping
//
//  Created by UEdge on 2017/10/17.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainViewController.h"

#import "EdgeNavigationController.h"

#import <BaiduMapAPI_Map/BMKMapComponent.h>

#import "EdgeHomeViewController.h"
// iOS10  UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

#import <UserNotifications/UserNotifications.h>

#endif


/** @brief 登录状态变更的通知 */
#define Not_AppDelegate_userAccountDidLoginFromOtherDevice @"Not_AppDelegate_userAccountDidLoginFromOtherDevice"


@interface AppDelegate : UIResponder <UIApplicationDelegate,EMChatManagerDelegate,UNUserNotificationCenterDelegate,BMKGeneralDelegate>
{
    // iOS 10通知中心
    UNUserNotificationCenter *_notificationCenter;
}

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)shareInstance;

@property (strong, nonatomic) EdgeNavigationController *navigationController;

@property (strong, nonatomic) MainViewController *mainController;

// 从新登陆
-(void)reloginIn;

/**
 绑定个推别名
 */
-(void)bindAlias;


/**
 解绑个推别名
 */
-(void)unBindAlias;

@end

