//
//  NgBridgeInformationDao.h
//  
//  描述：桥梁信息的Dao。(自动生成，代码模块1.0v)
//  Created by RockeyCai on 2016-12-22 18:26:21.
//  Copyright (c) 2016年 RockeyCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NgBridgeInformation;

extern NSString * const TableName;

@interface NgBridgeInformationDao : NSObject


/**
 *  添加NgBridgeInformation记录
 *
 *  @param model NgBridgeInformation
 *
 *  @return
 */
+(void)saveArray:(NSArray *)array;

/**
 *  添加NgBridgeInformation记录
 *
 *  @param model NgBridgeInformation
 *
 *  @return
 */
+(BOOL)saveNgBridgeInformation:(NgBridgeInformation *)model;

/**
 *  添加NgBridgeInformation全部记录
 *
 *  @return
 */
+(NSArray *)getNgBridgeInformationArray;


/**
 *  获取最大id的记录
 *
 *  @return
 */
+(long long)getMaxId;

/**
 *  更新NgBridgeInformation记录
 *
 *  @param model NgBridgeInformation
 *
 *  @return
 */
+(BOOL)updNgBridgeInformation:(NgBridgeInformation *)model;

/**
 *  删除NgBridgeInformation记录
 *
 *  @param Id 
 *
 *  @return
 */
+(BOOL)delNgBridgeInformationById:(long long)Id;
	
@end

