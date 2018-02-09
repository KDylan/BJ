//
//  FuzzyShipDao.m
//  
//  描述：船只模糊搜索类模型类的Dao。(自动生成，代码模块1.0v)
//  Created by RockeyCai on 2016-12-26 12:06:34.
//  Copyright (c) 2016年 RockeyCai. All rights reserved.
//

#import "FuzzyShipDao.h"
#import "DBHelper.h"
#import "FMDatabase.h"

#import "FuzzyShip.h"

@interface FuzzyShipDao ()

@end

@implementation FuzzyShipDao


/**
 *  添加FuzzyShip记录 列表
 *
 *  @param model NgBridgeInformation
 *
 *  @return
 */
+(void)saveFuzzyShipArray:(NSArray *)array{
    
    if (array) {
        
        for (FuzzyShip *model in array) {
            [FuzzyShipDao saveFuzzyShip:model];
        }
        
    }
}


/**
 *  添加FuzzyShip记录
 *
 *  @param model FuzzyShip
 *
 *  @return
 */
+(BOOL)saveFuzzyShip:(FuzzyShip *)model{
    
    BOOL result = NO;
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendString:@" REPLACE into FuzzyShip("];
    //[sql appendString:@" AutoId,"];//sqlite自增主键
    [sql appendString:@" Id,"];//原表主键 主键
    [sql appendString:@" JSON "];
    [sql appendString:@" )"];
    [sql appendString:@" VALUES"];
    [sql appendString:@"("];
    //[sql appendFormat:@" \"%@\" ,", " , [NSNumber numberWithLongLong:[IDGenerate getID]]];//如果没表没设置自增，则要自己设置自增主键
    [sql appendFormat:@" \"%@\" ," , [NSNumber numberWithLongLong:model.ID]];//主键
    [sql appendFormat:@" '%@' " , [model mj_JSONString]];//对象json结果(此处有bug，待解决双引号和单引号问题)
    [sql appendString:@")"];
    result = [[DBHelper getDBHelperSingleton].fmDatabase executeUpdate:sql];
    return result;
}

/**
 *  获取FuzzyShip全部记录
 *
 *  @return
 */
+(NSArray *)getFuzzyShipArray{
	
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendString:@"select AutoId,Id,JSON from FuzzyShip"];
    
    FMResultSet *rs = [[DBHelper getDBHelperSingleton].fmDatabase executeQuery:sql];
    while ([rs next]) {
    	//转换对象
    	NSString *json = [rs stringForColumn:@"JSON"];    
        FuzzyShip* model = [FuzzyShip mj_objectWithKeyValues:json];
    	[array addObject:model];
    }
    [rs close];
    return array;
}

/**
 *  更新FuzzyShip记录
 *
 *  @param model FuzzyShip
 *
 *  @return
 */
+(BOOL)updFuzzyShip:(FuzzyShip *)model{

    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendString:@" update FuzzyShip set "];
    [sql appendFormat:@" JSON = \"%@\" " , model.mj_JSONString];
    [sql appendFormat:@" where Id = %@, " , [NSNumber numberWithLongLong:model.ID]];//主键
    return [[DBHelper getDBHelperSingleton].fmDatabase executeUpdate:sql];
}

/**
 *  删除FuzzyShip记录
 *
 *  @param Id 主键
 *
 *  @return
 */
+(BOOL)delFuzzyShipById:(long long)Id{

	BOOL result = NO;
	NSString *sql = [NSString stringWithFormat:@"delete from FuzzyShip where Id = %lld" , Id];
	//删除数据
	result = [[DBHelper getDBHelperSingleton].fmDatabase executeUpdate:sql];
	return result;
}

@end
