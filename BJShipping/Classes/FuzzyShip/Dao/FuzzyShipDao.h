//
//  FuzzyShipDao.h
//  
//  描述：船只模糊搜索类模型类的Dao。(自动生成，代码模块1.0v)
//  Created by RockeyCai on 2016-12-26 12:06:34.
//  Copyright (c) 2016年 RockeyCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FuzzyShip;

@interface FuzzyShipDao : NSObject


/**
 *  添加FuzzyShip记录 列表
 *
 *  @param model NgBridgeInformation
 *
 *  @return
 */
+(void)saveFuzzyShipArray:(NSArray *)array;

/**
 *  添加FuzzyShip记录
 *
 *  @param model FuzzyShip
 *
 *  @return
 */
+(BOOL)saveFuzzyShip:(FuzzyShip *)model;

/**
 *  添加FuzzyShip全部记录
 *
 *  @return
 */
+(NSArray *)getFuzzyShipArray;

/**
 *  更新FuzzyShip记录
 *
 *  @param model FuzzyShip
 *
 *  @return
 */
+(BOOL)updFuzzyShip:(FuzzyShip *)model;

/**
 *  删除FuzzyShip记录
 *
 *  @param Id 
 *
 *  @return
 */
+(BOOL)delFuzzyShipById:(long long)Id;
	
@end

