//
//  PicDao.m
//  
//  描述：微博图片的Dao。(自动生成，代码模块1.0v)
//  Created by RockeyCai on 2015-10-12 23:26:33.
//  Copyright (c) 2015年 RockeyCai. All rights reserved.
//

#import "PicDao.h"
#import "DBHelper.h"
#import "FMDatabase.h"
#import "AppHelper.h"

@interface PicDao ()

@end

@implementation PicDao

/**
 *  添加PIC记录
 *
 *  @param model PIC
 *
 *  @return

+(BOOL)savePIC:(PIC *)model{
    
    BOOL result = NO;
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendString:@" insert into PIC("];
    //[sql appendString:@" PHOTO_ID,"];
    [sql appendString:@" PIC_NAME,"];
    [sql appendString:@" ALBUM_ID"];
    [sql appendString:@" )"];
    [sql appendString:@" VALUES"];
    [sql appendString:@"("];
    //[sql appendFormat:@" %@, " , [NSNumber numberWithLongLong:model.PHOTO_ID]];//主键
    [sql appendFormat:@" \"%@\", " , model.PIC_NAME];//名称，带后缀
    [sql appendFormat:@" %@ " , [NSNumber numberWithLongLong:model.ALBUM_ID]];//相册id
    [sql appendString:@")"];
    result = [[DBHelper getDBHelperSingleton].fmDatabase executeUpdate:sql];
    return result;
}
 */
/**
 *  添加PIC全部记录
 *
 *  @return

+(NSArray *)getPICArray:(long long)PHOTO_ID{
	
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableString *sql = [[NSMutableString alloc] init];
//    
//    //是否加载零时数据
//    if([AppConfig getBoolUserDefaults:IsNoLoadTempData]){
//        [sql appendString:@"select PHOTO_ID,PIC_NAME,ALBUM_ID from PIC where 1=1"];
//    }else{
//        [sql appendString:@"select PHOTO_ID,PIC_NAME,ALBUM_ID from PIC_TEMP where 1=1"];
//    }
//    
//    
//    if (PHOTO_ID > 0) {
//        [sql appendFormat:@" and PHOTO_ID < %lld" , PHOTO_ID];
//    }
//    //[sql appendString:@" order by PHOTO_ID desc "];
//    [sql appendFormat:@" order by PHOTO_ID desc limit %d " , ISiPhone ? 30 : 60];
//    
//    FMResultSet *rs = [[DBHelper getDBHelperSingleton].fmDatabase executeQuery:sql];
//    while ([rs next]) {
//    	PIC *model = [[PIC alloc] init];
//    	model.PHOTO_ID = [rs longLongIntForColumn:@"PHOTO_ID"];//主键
//    	model.PIC_NAME = [rs stringForColumn:@"PIC_NAME"];//名称，带后缀
//    	model.ALBUM_ID = [rs longLongIntForColumn:@"ALBUM_ID"];//相册id
//        [array addObject:model];
//    }
//    [rs close];
    return array;
}
  */


/**
 *  添加PIC全部记录
 *
 *  @return

+(NSArray *)getPICArrayAll{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendString:@"select PHOTO_ID,PIC_NAME,ALBUM_ID from PIC where 1=1"];
    [sql appendString:@" order by PHOTO_ID desc"];
    
    FMResultSet *rs = [[DBHelper getDBHelperSingleton].fmDatabase executeQuery:sql];
    while ([rs next]) {
        PIC *model = [[PIC alloc] init];
        model.PHOTO_ID = [rs longLongIntForColumn:@"PHOTO_ID"];//主键
        model.PIC_NAME = [rs stringForColumn:@"PIC_NAME"];//名称，带后缀
        model.ALBUM_ID = [rs longLongIntForColumn:@"ALBUM_ID"];//相册id
        [array addObject:model];
    }
    [rs close];
    return array;
}
 */

/**
 *  更新PIC记录
 *
 *  @param model PIC
 *
 *  @return

+(BOOL)updPIC:(PIC *)model{

    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendString:@" update PIC set "];
    //[sql appendFormat:@" PHOTO_ID = %@, " , [NSNumber numberWithLongLong:model.PHOTO_ID]];//主键
    [sql appendFormat:@" PIC_NAME = \"%@\", " , model.PIC_NAME];//名称，带后缀
    [sql appendFormat:@" ALBUM_ID = %@ " , [NSNumber numberWithLongLong:model.ALBUM_ID]];//相册id
    [sql appendString:@" where 1=1 "];
    //[sql appendFormat:@" and PHOTO_ID = %@ " , [NSNumber numberWithLongLong:model.PHOTO_ID]];//主键
    [sql appendFormat:@" and PIC_NAME = \"%@\" " , model.PIC_NAME];//名称，带后缀
    [sql appendFormat:@" and ALBUM_ID = %@ " , [NSNumber numberWithLongLong:model.ALBUM_ID]];//相册id
    //更新PIC记录
    return [[DBHelper getDBHelperSingleton].fmDatabase executeUpdate:sql];
}
 */
/**
 *  删除PIC记录
 *
 *  @param PHOTO_ID
 *
 *  @return

+(BOOL)delPICByPHOTO_ID:(long long)PHOTO_ID{

	BOOL result = NO;
	NSString *sql = [NSString stringWithFormat:@"delete from PIC where PHOTO_ID = %lld" , PHOTO_ID];
	//保存文件夹信息到数据表
	result = [[DBHelper getDBHelperSingleton].fmDatabase executeUpdate:sql];
	return result;
}
 */

/**
 *  数量
 *
 *  @return <#return value description#>

+(int)getCount{
    
    int count = 0;
//    NSMutableString *sql = [[NSMutableString alloc] init];
//    [sql appendString:@"select count(1) size from "];
//    
//    //是否加载零时数据
//    if([AppConfig getBoolUserDefaults:IsNoLoadTempData]){
//        [sql appendString:@" PIC"];
//    }else{
//        [sql appendString:@" PIC_TEMP"];
//    }
//    
//    FMResultSet *rs = [[DBHelper getDBHelperSingleton].fmDatabase executeQuery:sql];
//    while ([rs next]) {
//       count = [rs intForColumn:@"size"];
//    }
//    [rs close];
    return count;
}
 */

/**
 *  保存数据
 *
 *  @param dataStr <#dataStr description#>

+(void)saveForString:(NSString *)dataStr{
    
    NSArray *array = [dataStr componentsSeparatedByString:@";"];
    
    for (NSString *data in array) {
        
        NSArray *temp = [data componentsSeparatedByString:@"|"];
        if(temp && temp.count == 2){
            NSMutableString *sql = [[NSMutableString alloc] init];
            [sql appendString:@" insert into PIC("];
            [sql appendString:@" PHOTO_ID,"];
            [sql appendString:@" PIC_NAME,"];
            [sql appendString:@" ALBUM_ID"];
            [sql appendString:@" )"];
            [sql appendString:@" VALUES"];
            [sql appendString:@"("];
            [sql appendFormat:@" %@, " , temp[0]];//主键
            [sql appendFormat:@" \"%@\", " , temp[1]];//名称，带后缀
            [sql appendString:@" 3609172263467128 "];//相册id
            [sql appendString:@")"];
            NSLog(@"%@" ,sql);
            BOOL result = [[DBHelper getDBHelperSingleton].fmDatabase executeUpdate:sql];
            NSLog(@"data：%@ -- %@" ,data, result ? @"成功": @"失败");
        }
    }
}
 */

@end
