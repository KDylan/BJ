//
//  AppHelp.h
//  PhotoAlbum
//
//  Created by RockeyCai on 14/11/27.
//  Copyright (c) 2014年 RockeyCai. All rights reserved.
//

#ifndef AppHelper_h
#define AppHelper_h

#import <Availability.h>

#ifndef __IPHONE_5_0
#warning "This project uses features only available in iOS SDK 5.0 and later."
#endif

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif


static int STATE_D = 0;// 开发
static int STATE_R_Store = 1;// 正式 App Store


//head验证标记
static NSString *Authorization = @"C8GNV1NyBGV/JWIUg0+YySCwH3n3yLJR";

//STATE_R_Store 开发
static NSString *URLS_DATA_STR = @"http://192.168.0.153:9009";//测试地址
static NSString *URLS_DATA_STR_IPV6 = @"http://192.168.0.153:9009";//测试地址IPV6

//STATE_R_Store 正式版本
//static NSString *URLS_DATA_STR = @"http://192.168.0.153:9009";//测试地址
//static NSString *URLS_DATA_STR_IPV6 = @"http://192.168.0.153:9009";//测试地址IPV6


//友盟统计SDK的key
//#define kUmengKey @"596c1896b27b0a2e230000f7"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ISOS7 [[[UIDevice currentDevice] systemVersion] substringWithRange:NSMakeRange(0,1)].intValue >6 ? YES : NO

#define DeviceHeight [[UIScreen mainScreen] bounds].size.height

#define DeviceWidth [[UIScreen mainScreen] bounds].size.width

#define IOS7ButtomHeight (ISOS7 ? (DeviceHeight) : (DeviceHeight-64))
//判断是否为iphone
#define ISiPhone [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

#define KeyTag @"KeyTag"

#define AppId @""

#define MyEmail @""

//主题修改广播
#define ThemeResetNotifaction @"ThemeResetNotifaction"

//主题
#define SelectThemeIndex @"SelectThemeIndex"

//绿色
#define MyBarColor 0x3589FF //0x2BC17A //0x3399CC
//#define MyBarColor 0xFFD700//0xEEAD0E//0xFFB90F
//默认灰色颜色
#define MyGrayColor 0x8f8f8f //0x3399CC

//不可用颜色
#define DisEnableColor  0xe0e1e3

//默认视图背景色
#define DefaultBackgroundColor 0xf2f3f5

//列表颜色
#define TableViewBgColor 0xF2F2F2


#endif
