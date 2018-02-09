//
//  AppInfo.h
//  
//  描述：app版本更新信息的映射模型。(自动生成，代码模块1.0v)
//  Created by RockeyCai on 2016-12-9 14:58:31.
//  Copyright (c) 2016年 RockeyCai. All rights reserved.
//

#import "JSONModel.h"

@interface AppInfo : JSONModel

/**
 * 主键
 */
@property (nonatomic,assign) long long Id;

/**
 * 平台类型
 */
@property (nonatomic,retain) NSString<Optional> *AppType;

/**
 * 更新描述
 */
@property (nonatomic,retain) NSString<Optional> *ChangeLog;

/**
 * 下载地址
 */
@property (nonatomic,retain) NSString<Optional> *DownloadUrl;

/**
 * 版本号
 */
@property (nonatomic,assign) NSString<Optional> *Version;

/**
 * 操作时间
 */
@property (nonatomic,retain) NSString<Optional> *OperateTime;

/**
 * 操作人
 */
@property (nonatomic,retain) NSString<Optional> *OperatePerson;

/**
 * 操作类型
 */
@property (nonatomic,retain) NSString<Optional> *OperateType;

/**
 * 备用字段1
 */
@property (nonatomic,retain) NSString<Optional> *BackUp1;

/**
 * 备用字段2
 */
@property (nonatomic,retain) NSString<Optional> *BackUp2;

/**
 * 备用字段3
 */
@property (nonatomic,retain) NSString<Optional> *BackUp3;

/**
 * 备用字段4
 */
@property (nonatomic,retain) NSString<Optional> *BackUp4;

/**
 * 备用字段5
 */
@property (nonatomic,retain) NSString<Optional> *BackUp5;

@end

