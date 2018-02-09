//
//  AppDelegate.m
//  BJShipping
//
//  Created by UEdge on 2017/10/17.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#define Appkey @"comit-water#ghbusinesssv"
//#define Appkey @"1179171108178224#moblow"

#if DEBUG

#define apnsCerName @"BJ_aps_dev"

#else

#define apnsCerName @"BJ_aps_push"

#endif

#import "AppDelegate.h"

#import "EdgeRootViewController.h"
#import "EdgeLoginViewController.h"

#import "ChatDemoHelper.h"
#import <Hyphenate/Hyphenate.h>

#import "AppDelegate+EaseMob.h"

#import "AppDelegate+GTPush.h"

#import "OnlineServer.h"


@interface AppDelegate ()
{
    BMKMapManager* _mapManager;
}

@end

static AppDelegate *instance = nil;

@implementation AppDelegate

+ (AppDelegate *)shareInstance
{
    
    return instance;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    instance = self;
#pragma mark ------  注册环信操作
    
    //  注册环信操作
    [self registerHX_Action];
    
    //  环信登录通知【注册环信】
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions appkey:Appkey apnsCertName:apnsCerName otherConfig:nil];
    
#pragma mark ------  注册个推
    //  注册个推推送
    [self GT_addGtAction];
    // 注册消息声音
    [self registerRemoteNotification];
    
#pragma mark ------  自定义配置方法
    
    [self configAction];
    
    return YES;
}

/**
 注册环信操作
 */
-(void)registerHX_Action{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *appkey = [ud stringForKey:@"identifier_appkey"];
    if (!appkey) {
        appkey = appkey;
        [ud setObject:appkey forKey:@"identifier_appkey"];
    }
}
/**
 环境配置
 */
-(void)configAction{
    
    //  添加根控制器
    [self addRootViewController];
    //  键盘控制
    [self configureBoardManager];
    
    //启动友盟统计
    [MPUmengHelper UMAnalyticStart];
   
    //  初始化百度地图
    [self baiduInit];
    //  别的设备登录监听
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloginHXOrLogout) name:Not_AppDelegate_userAccountDidLoginFromOtherDevice object:nil];
}


/**
 百度初始化
 应用AK：Dk6C2WdiYQ5FGsyLrq5ItOG71HZBxw3R
 应用名称：
 北江航运服务-ios
 应用类型： iOS端
 */
-(void)baiduInit{
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"Dk6C2WdiYQ5FGsyLrq5ItOG71HZBxw3R"  generalDelegate:self];
    if (!ret) {
        NSLog(@"百度授权失败");
    }
}

/**
 添加根控制器
 */
-(void)addRootViewController{
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    EdgeHomeViewController *rootVC = [[EdgeHomeViewController alloc]init];
    
    EdgeNavigationController *nav = [[EdgeNavigationController alloc]initWithRootViewController:rootVC];
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
}


//  重新登录
-(void)reloginIn{
    
    EdgeLog(@"重新登录");
    
    GVUserDefaults *gv = BBUserDefault;
    
    [[ChatDemoHelper shareHelper] loginWithUsername:gv.hxUserName password:gv.hxPassword];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    
}

#pragma mark--------------------  环信通知设置  -----------------------

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    EdgeLog(@"消息来了1 didReceiveRemoteNotification");
    if (_mainController) {
        [_mainController jumpToChatList];
    }
    //  环信推送
    [self easemobApplication:application didReceiveRemoteNotification:userInfo];
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    EdgeLog(@"消息来了2 didReceiveLocalNotification");
    
    if (_mainController) {
        [_mainController didReceiveLocalNotification:notification];
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    EdgeLog(@"消息来了3 willPresentNotification");
    
    //  通过环信的MessageType判断谁发的消息
    if ([[notification.request.content.userInfo allKeys] containsObject:@"MessageType"]) {//  环信
        //  环信
        NSDictionary *userInfo = notification.request.content.userInfo;
        [self easemobApplication:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo];
        
    }else{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
        completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
#endif
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
{
    EdgeLog(@"消息来了4 didReceiveNotificationResponse");
    
    EdgeLog(@"didReceiveNotification：%@", response.notification.request.content.userInfo);
    
    //  通过环信的MessageType判断谁发的消息
    if ([[response.notification.request.content.userInfo allKeys] containsObject:@"payload"]) {//  判断消息是个推发送的
        [self GT_userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:(void (^)())completionHandler];
    }else{//环信
        
        if (_mainController) {
            [_mainController didReceiveUserNotification:response.notification];
            EdgeLog(@"显示环信聊天界面");
            [[EdgeHomeViewController getInstance] showCharView];
        }
        
    }
    
    completionHandler();
}


/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // 环信服务器注册deviceToken
    [self application:application HXdidRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    //  注册个推
    [self GT_application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    
}
/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    EdgeLog(@"\n>>>[DeviceToken Error]:%@\n\n", error.description);
    
    // 环信服务器注册deviceToken
    [self application:application HXdidFailToRegisterForRemoteNotificationsWithError:error];
    
    //  注册个推
    [self GT_application:application didFailToRegisterForRemoteNotificationsWithError:error];
}


#pragma mark 键盘收回管理
-(void)configureBoardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    //manager.keyboardDistanceFromTextField=60;
    manager.enableAutoToolbar = NO;
}

/**
 绑定个推别名
 */
-(void)bindAlias{
    [self GT_bindAlias];
}


/**
 解绑个推别名
 */
-(void)unBindAlias{
    
    [self GT_unBindAlias];
}


/**
 应用程序入活动状态执行
 
 @param application <#application description#>
 */
- (void)applicationDidBecomeActive:(UIApplication *)application{
    EdgeLog(@"启动心跳数据服务");
    //启动心跳数据服务
    [[OnlineServer getSingleton] startOnline];
}

/**
 当应用程序将要入非活动状态执行
 
 @param application <#application description#>
 */
- (void)applicationWillResignActive:(UIApplication *)application
{
     EdgeLog(@"停止心跳数据服务");
    //停止心跳数据服务
    [[OnlineServer getSingleton] stopOnline];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
    
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
