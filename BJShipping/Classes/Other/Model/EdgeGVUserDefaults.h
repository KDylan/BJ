//
//  EdgeGVUserDefaults.h
//  gd_port
//
//  Created by UEdge on 2017/10/26.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "GVUserDefaults.h"

#define BBUserDefault [GVUserDefaults standardUserDefaults]

@interface GVUserDefaults(BBProperties)

//最后一次登录用户名
@property (nonatomic,weak) NSString *lastLoginName;
//最后一次登录密码
@property (nonatomic,weak) NSString *lastPassword;

//登录用户对象JSON
@property (nonatomic,weak) NSString *userModelJSON;

//环信用户名
@property (nonatomic,weak) NSString *hxUserName;
//环信密码
@property (nonatomic,weak) NSString *hxPassword;
//创建群权限 1有 0没有
@property (nonatomic,weak) NSString *createGroup;

//全局缓存用户名称 key是username val 是昵称
@property (nonatomic , retain)NSDictionary *userDict;

//查询条件
@property (nonatomic , retain)id getHxGroupMemberFilterType;

/**是否登录*/
@property (nonatomic,assign) BOOL isLogin;

#pragma mark --是否是第一次启动APP程序
@property (nonatomic,assign) BOOL isNoFirstLaunch;


//用户icon 的json数据
@property (nonatomic,weak) NSString *usericonmujson;
//用户滚动新闻数据
@property (nonatomic,weak) NSString *titlenewsmujson;
//  办事指南json
@property (nonatomic,weak) NSString *workViewItemArrayResultJSON;

//  船舶名称
@property (nonatomic,weak) NSString *ship;

//个图标记
@property (nonatomic,weak) NSString *clientId;


/**
 上传在线次数
 */
@property (nonatomic,assign) int onlineNum;

/**
 上传gps次数
 */
@property (nonatomic,assign) int gpsNum;

//  数据库版本
@property (nonatomic,assign) int oldDBVersion;

@end
