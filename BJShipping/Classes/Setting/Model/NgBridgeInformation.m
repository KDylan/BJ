//
//  NgBridgeInformation.m
//  
//  描述：桥梁信息的映射模型。(自动生成，代码模块1.0v)
//  Created by RockeyCai on 2016-12-22 18:26:21.
//  Copyright (c) 2016年 RockeyCai. All rights reserved.
//

#import "NgBridgeInformation.h"

@implementation NgBridgeInformation

/**
 * 自增主键
 */
@synthesize Id = _Id;

/**
 * 桥梁名称
 */
@synthesize NgBridgeName = _NgBridgeName;

/**
 * 桥梁分类
 */
@synthesize NgBridgeType = _NgBridgeType;

/**
 * 跨越方式分类
 */
@synthesize NgBridgeAcrossType = _NgBridgeAcrossType;

/**
 * 桥长(米)
 */
@synthesize NgBridgeLength = _NgBridgeLength;

/**
 * 桥宽(米)
 */
@synthesize NgBridgeWidth = _NgBridgeWidth;

/**
 * 建成年份
 */
@synthesize NgBridgeCreate = _NgBridgeCreate;

/**
 * 经度
 */
@synthesize Lng = _Lng;

/**
 * 纬度
 */
@synthesize Lat = _Lat;

/**
 * 通航净高(米)
 */
@synthesize NgBridgeNavigableHight = _NgBridgeNavigableHight;

/**
 * 通航净宽(米)
 */
@synthesize NgBridgeNavigableWidth = _NgBridgeNavigableWidth;

/**
 * 最高通航水位(米)
 */
@synthesize NgBridgeNavigableWaterlevel = _NgBridgeNavigableWaterlevel;

/**
 * 最大跨径(米)
 */
@synthesize NgBridgeSpan = _NgBridgeSpan;

/**
 * 梁数
 */
@synthesize NgBridgeBeamNumber = _NgBridgeBeamNumber;

/**
 * 通航等级
 */
@synthesize NgBridgeNavigationLevel = _NgBridgeNavigationLevel;

/**
 * 通航孔径
 */
@synthesize NgBridgeAperture = _NgBridgeAperture;

/**
 * 孔数
 */
@synthesize NgBridgeApertureNumber = _NgBridgeApertureNumber;

/**
 * 操作人
 */
@synthesize OperatePerson = _OperatePerson;

/**
 * 操作时间
 */
@synthesize OperateTime = _OperateTime;

/**
 * 操作类型
 */
@synthesize OperateType = _OperateType;

/**
 * 备用字段1
 */
@synthesize BackUp1 = _BackUp1;

/**
 * 备用字段2
 */
@synthesize BackUp2 = _BackUp2;

/**
 * 备用字段3
 */
@synthesize BackUp3 = _BackUp3;

/**
 * 备用字段4
 */
@synthesize BackUp4 = _BackUp4;

/**
 * 备用字段5
 */
@synthesize BackUp5 = _BackUp5;

-(NSString *)getNgBridgeInfo{
    
    NSMutableString *str = [NSMutableString new];
    
    if (_NgBridgeNavigableHight) {
        [str appendFormat:@"净高%@米" , _NgBridgeNavigableHight];
    }
    
    if (_NgBridgeNavigableWidth) {
        
        if (_NgBridgeNavigableHight) {
            [str appendString:@","];
        }
        
        [str appendFormat:@"净宽%@米" , _NgBridgeNavigableWidth];
    }
    
   return str;
}

@end

