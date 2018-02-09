//
//  micsro.h
//  gd_port
//
//  Created by UEdge on 2017/11/17.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#ifndef micsro_h
#define micsro_h

#define MAS_SHORTHAND  //  不用mas
#define MAS_SHORTHAND_GLOBALS    //  不用包装
//中文字体
#define CHINESE_FONT_NAME  @"Heiti SC"
#define CHINESE_SYSTEM(x) [UIFont fontWithName:CHINESE_FONT_NAME size:x]

/**屏幕宽度*/
#define Screen_W [UIScreen mainScreen].bounds.size.width
/**屏幕高度*/
#define Screen_H [UIScreen mainScreen].bounds.size.height

//  定义颜色
#define EdgeBackGroundColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];

#define EdgeGloupColor EdgeBackGroundColor(235,240,241);

#define EdgeStateBarColor [UIColor colorWithRed:59.0/255.0 green:139.0/255.0 blue:251.0/255.0 alpha:1.0];


//#define  userDefaults [NSUserDefaults standardUserDefaults];

//绿色
#define MyBarColor 0x3589FF //0x2BC17A //0x3399CC


#import "AsyncHelper.h"
#import "UIView+EdgeExpention.h"
#import "UIBarButtonItem+EdgeExention.h"
#import "UIImage+UIImage.h"
#import "EdgeGVUserDefaults.h"
#import "EdgeTimeHelper.h"
#import "UIAlertController+EdgeAlertController.h"
#import "AlertViewHelper.h"
#import "AppHelper.h"
#import "IPHelper.h"
#import "UIImage+UIImage.h"

#import "EdgeJsonHelper.h"

#import "MPUmengHelper.h"

#import "UIViewController+HUD.h"

#import "OpenUDID.h"
//  自定义输出格式
#ifdef DEBUG

#define EdgeLog(...) NSLog(__VA_ARGS__)

#else

#define EdgeLog(...)

#endif

#endif /* micsro_h */
