//
//  NgBridgeInformationDao.m
//  
//  描述：桥梁信息的Dao。(自动生成，代码模块1.0v)
//  Created by RockeyCai on 2016-12-22 18:26:21.
//  Copyright (c) 2016年 RockeyCai. All rights reserved.
//

#import "NgBridgeInformationDao.h"
#import "DBHelper.h"
#import "FMDatabase.h"
#import "NgBridgeInformation.h"

//表名
NSString * const TableName = @"NgBridgeInformation";

@interface NgBridgeInformationDao ()

@end

@implementation NgBridgeInformationDao


/**
 *  添加NgBridgeInformation记录
 *
 *  @param model NgBridgeInformation
 *
 *  @return
 */
+(void)saveArray:(NSArray *)array{
    
    if (array) {
        
        for (NgBridgeInformation *model in array) {
            [NgBridgeInformationDao saveNgBridgeInformation:model];
        }
        
    }
}


/**
 *  添加NgBridgeInformation记录
 *
 *  @param model NgBridgeInformation
 *
 *  @return
 */
+(BOOL)saveNgBridgeInformation:(NgBridgeInformation *)model{
    
    BOOL result = NO;
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendString:@" REPLACE into NgBridgeInformation("];
    [sql appendString:@" Id,"];
    [sql appendString:@" JSON "];
    [sql appendString:@" )"];
    [sql appendString:@" VALUES"];
    [sql appendString:@"("];
    [sql appendFormat:@" %@, " , [NSNumber numberWithLongLong:model.Id]];//自增主键
    [sql appendFormat:@" '%@' " , model.toJSONString];
    [sql appendString:@")"];
    result = [[DBHelper getDBHelperSingleton].fmDatabase executeUpdate:sql];
    return result;
}

/**
 *  获取NgBridgeInformation全部记录
 *
 *  @return
 */
+(NSArray *)getNgBridgeInformationArray{
	
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendString:@"select Id,JSON from NgBridgeInformation"];
    
    FMResultSet *rs = [[DBHelper getDBHelperSingleton].fmDatabase executeQuery:sql];
    while ([rs next]) {
        
    	//model.Id = [rs longLongIntForColumn:@"Id"];//自增主键
    	NSString *json = [rs stringForColumn:@"JSON"];
        
        NgBridgeInformation* model = [[NgBridgeInformation alloc] initWithString:json error:nil];
        [array addObject:model];
    }
    [rs close];
    return array;
}



/**
 *  获取最大id的记录
 *
 *  @return
 */
+(long long)getMaxId{
    
    long long Id = 0;
    
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendString:@"select max(Id) Id from NgBridgeInformation"];
    
    FMResultSet *rs = [[DBHelper getDBHelperSingleton].fmDatabase executeQuery:sql];
    while ([rs next]) {
        
        Id = [rs longLongIntForColumn:@"Id"];//自增主键
    }
    [rs close];
    return Id;
}


/**
 *  更新NgBridgeInformation记录
 *
 *  @param model NgBridgeInformation
 *
 *  @return
 */
+(BOOL)updNgBridgeInformation:(NgBridgeInformation *)model{

    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendString:@" update NgBridgeInformation set "];
    [sql appendFormat:@" JSON = \"%@\", " , model.toJSONString];
    [sql appendFormat:@" where Id = %@, " , [NSNumber numberWithLongLong:model.Id]];//主键
    
    //更新NgBridgeInformation记录
    return [[DBHelper getDBHelperSingleton].fmDatabase executeUpdate:sql];
}

/**
 *  删除NgBridgeInformation记录
 *
 *  @param Id
 *
 *  @return
 */
+(BOOL)delNgBridgeInformationById:(long long)Id{

	BOOL result = NO;
	NSString *sql = [NSString stringWithFormat:@"delete from NgBridgeInformation where Id = %lld" , Id];
	//保存文件夹信息到数据表
	result = [[DBHelper getDBHelperSingleton].fmDatabase executeUpdate:sql];
	return result;
}

@end
