//
//  IDGenerate.h
//  PhotoAlbum
//
//  Created by RockeyCai on 14/11/30.
//  Copyright (c) 2014年 RockeyCai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDGenerate : NSObject

//+(IDGenerate *)getSingleton;

/**
 *更具时间戳，生成数据,线程安全 UInt64
 **/
+(long long )getID;

@end
