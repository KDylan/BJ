//
//  FuzzyShip.h
//  
//  描述：船只模糊搜索类模型类的映射模型。(自动生成，代码模块1.0v)
//  Created by RockeyCai on 2016-12-26 12:06:34.
//  Copyright (c) 2016年 RockeyCai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FuzzyShip : NSObject

/**
 * 主键
 */
@property (nonatomic,assign) NSInteger ID;

/**
 * 
 */
@property (nonatomic,retain) NSString *sog;

/**
 * 
 */
@property (nonatomic,retain) NSString *cog;

/**
 * 
 */
@property (nonatomic,retain) NSString *ship_id;

/**
 * 纬度
 */
@property (nonatomic,assign) double lat;

/**
 * 经度 22.236611666666668
 */
@property (nonatomic,assign) double lng;

/**
 * 
 */
@property (nonatomic,retain) NSString *hdg;

/**
 * 船名
 */
@property (nonatomic,retain) NSString *name;

/**
 * 
 */
@property (nonatomic,assign) float length;

/**
 * 
 */
@property (nonatomic,retain) NSString *ship_type;

/**
 * 
 */
@property (nonatomic,retain) NSString *data_source;

/**
 * 
 */
@property (nonatomic,retain) NSString *last_time;


/**
 获取绑定船只
 
 @return FuzzyShip
 */
+(FuzzyShip *)getShipInfo;

@end

