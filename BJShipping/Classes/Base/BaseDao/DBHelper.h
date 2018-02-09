//
//  DBHelper.h
//  KeepSafe
//
//  Created by RockeyCai on 14-3-28.
//  Copyright (c) 2014年 rockycai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;
@class FMDatabaseQueue;

typedef void (^FMDatabaseBlock)(FMDatabase *);


@interface DBHelper : NSObject

@property (nonatomic,retain) NSString *dbFilePath;
@property (nonatomic,retain) FMDatabase *fmDatabase;
@property (nonatomic,retain) FMDatabaseQueue *fMDatabaseQueue;

/**
 *  初始化数据库
 *  获取单例对象
 *  @return <#return value description#>
 */
+(DBHelper *)getDBHelperSingleton;

//初始化数据库
-(void)databaseInit;

+(FMDatabase *)getFMDatabase;

/**
 * 事务对象
 **/
+(FMDatabaseQueue *)getFMDatabaseQueue;


/**
 * 用于多线程并发处理
 **/
+(void)getFMDatabaseQueue:(FMDatabaseBlock)cb;
@end
