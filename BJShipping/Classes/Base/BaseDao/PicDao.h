//
//  PicDao.h
//  
//  描述：微博图片的Dao。(自动生成，代码模块1.0v)
//  Created by RockeyCai on 2015-10-12 23:26:33.
//  Copyright (c) 2015年 RockeyCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PIC;

@interface PicDao : NSObject

/**
 *  添加PIC记录
 *
 *  @param model PIC
 *
 *  @return
 */
+(BOOL)savePIC:(PIC *)model;

/**
 *  添加PIC全部记录
 *
 *  @return
 */
+(NSArray *)getPICArray:(long long)PHOTO_ID;


/**
 *  添加PIC全部记录
 *
 *  @return
 */
+(NSArray *)getPICArrayAll;

/**
 *  更新PIC记录
 *
 *  @param model PIC
 *
 *  @return
 */
+(BOOL)updPIC:(PIC *)model;

/**
 *  删除PIC记录
 *
 *  @param PHOTO_ID 
 *
 *  @return
 */
+(BOOL)delPICByPHOTO_ID:(long long)PHOTO_ID;

/**
 *  数量
 *
 *  @return <#return value description#>
 */
+(int)getCount;

/**
 *  保存数据
 *
 *  @param dataStr <#dataStr description#>
 */
+(void)saveForString:(NSString *)dataStr;

@end

