//
//  NgBridgeInformation.h
//  
//  描述：桥梁信息的映射模型。(自动生成，代码模块1.0v)
//  Created by RockeyCai on 2016-12-22 18:26:21.
//  Copyright (c) 2016年 RockeyCai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface NgBridgeInformation : JSONModel

/**
 * 自增主键
 */
@property (nonatomic,assign) long long Id;

/**
 * 桥梁名称
 */
@property (nonatomic,retain) NSString<Optional> *NgBridgeName;

/**
 * 桥梁分类
 */
@property (nonatomic,retain) NSString<Optional> *NgBridgeType;

/**
 * 跨越方式分类
 */
@property (nonatomic,retain) NSString<Optional> *NgBridgeAcrossType;

/**
 * 桥长(米)
 */
@property (nonatomic,retain) NSString<Optional> *NgBridgeLength;

/**
 * 桥宽(米)
 */
@property (nonatomic,retain) NSString<Optional> *NgBridgeWidth;

/**
 * 建成年份
 */
@property (nonatomic,retain) NSString<Optional> *NgBridgeCreate;

/**
 * 经度
 */
@property (nonatomic,assign) double Lng;

/**
 * 纬度
 */
@property (nonatomic,assign) double Lat;

/**
 * 通航净高(米)
 */
@property (nonatomic,retain) NSString<Optional> *NgBridgeNavigableHight;

/**
 * 通航净宽(米)
 */
@property (nonatomic,retain) NSString<Optional> *NgBridgeNavigableWidth;

/**
 * 最高通航水位(米)
 */
@property (nonatomic,retain) NSString<Optional> *NgBridgeNavigableWaterlevel;

/**
 * 最大跨径(米)
 */
@property (nonatomic,retain) NSString<Optional> *NgBridgeSpan;

/**
 * 梁数
 */
@property (nonatomic,retain) NSString<Optional> *NgBridgeBeamNumber;

/**
 * 通航等级
 */
@property (nonatomic,retain) NSString<Optional> *NgBridgeNavigationLevel;

/**
 * 通航孔径
 */
@property (nonatomic,retain) NSString<Optional> *NgBridgeAperture;

/**
 * 孔数
 */
@property (nonatomic,retain) NSString<Optional> *NgBridgeApertureNumber;

/**
 * 操作人
 */
@property (nonatomic,retain) NSString<Optional> *OperatePerson;

/**
 * 操作时间
 */
@property (nonatomic,retain) NSString<Optional> *OperateTime;

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


-(NSString *)getNgBridgeInfo;

@end

