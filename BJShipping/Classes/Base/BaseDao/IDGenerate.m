//
//  IDGenerate.m
//  PhotoAlbum
//  主键生成工具
//  Created by RockeyCai on 14/11/30.
//  Copyright (c) 2014年 RockeyCai. All rights reserved.
//

#import "IDGenerate.h"

@implementation IDGenerate

/**
 *更具时间戳，生成数据
 **/
+(long long )getID
{
    long long ID = 0;
    @synchronized(self){//只能加一把锁
        NSDate *datenow = [NSDate date];
        //UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
        //时间转时间戳的方法:
        ID = [datenow timeIntervalSince1970] * 1000 * 1000;
    }
    return ID;
}

@end
