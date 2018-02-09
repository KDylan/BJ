/************************************************************
  *  * Hyphenate CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2016 Hyphenate Inc. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of Hyphenate Inc.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from Hyphenate Inc.
  */

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

#import "ConversationListController.h"
#import "ContactListViewController.h"
#import "MapViewController.h"
@interface MainViewController : UITabBarController

@property (nonatomic, strong) ConversationListController *chatListVC;

@property (nonatomic, strong) MapViewController *mapLocationVC;

+ (MainViewController *)shareInstance;

- (void)jumpToChatList;

//- (void)setupUntreatedApplyCount;

- (NSInteger)setupUnreadMessageCount;

- (void)networkChanged:(EMConnectionState)connectionState;

- (void)didReceiveLocalNotification:(UILocalNotification *)notification;

- (void)didReceiveUserNotification:(UNNotification *)notification;

- (void)playSoundAndVibration;

- (void)showNotificationWithMessage:(EMMessage *)message;
/**
 关闭界面
 */
-(void)closeChatAction;
/**
 确定调度
 */
-(void)ConfirmScheduleShip:(NSString *)ship_id stID:(NSString *)st_id;
@end
