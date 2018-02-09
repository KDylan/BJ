//
//  DBHelper.m
//  KeepSafe
//  获取数据库实例的单例
//  Created by RockeyCai on 14-3-28.
//  Copyright (c) 2014年 rockycai. All rights reserved.
//

#import "DBHelper.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
//#import "GVUserDefaults+BBProperties.h"

#define DBVersion @"DBVersion"//数据库版本号
#define kDBFilePath @"db.sqlite" //@".db.sqlite"
#define DBName @"db"

static DBHelper *dbHelper = nil;
//数据库版本，用于验证是否需要更新数据库
static const int DBVersionValue = 1;

@implementation DBHelper

@synthesize dbFilePath = _dbFilePath;
@synthesize fmDatabase = _fmDatabase;

/**
 *  初始化数据库
 *  获取单例对象
 *  @return <#return value description#>
 */
+ (DBHelper *)getDBHelperSingleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbHelper = [[DBHelper alloc] init];
        //初始化数据库
        [dbHelper databaseInit];
    });
    
    return dbHelper;
}

+(FMDatabase *)getFMDatabase
{
    return dbHelper.fmDatabase;
}


/**
 * 事务对象
 **/
+(FMDatabaseQueue *)getFMDatabaseQueue
{
    if (!dbHelper.fMDatabaseQueue) {
        dbHelper.fMDatabaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbHelper.dbFilePath];
    }
    return dbHelper.fMDatabaseQueue;
}


/**
 * 事务对象 用于多线程
 **/
+(void)getFMDatabaseQueue:(FMDatabaseBlock)cb
{
    if (!dbHelper.fMDatabaseQueue) {
        dbHelper.fMDatabaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbHelper.dbFilePath];
    }
    [dbHelper.fMDatabaseQueue inDatabase:^(FMDatabase *db) {
        //打开数据库
        if ([db open]) {
            //数据库建表，插入语句
            cb(db);
            [db close];
        }
        else
        {
            NSLog(@"打开数据库失败！");
        }
    }];
    
    dbHelper.fMDatabaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbHelper.dbFilePath];
    [dbHelper.fMDatabaseQueue inDatabase:^(FMDatabase *db){
        // access db
    }];
}



//初始化数据库
-(void)databaseInit
{
    //沙盒中sql文件的路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    self.dbFilePath = [docPath stringByAppendingPathComponent:kDBFilePath];
    
    int oldDBVersion = [GVUserDefaults standardUserDefaults].oldDBVersion; //[AppConfig getStringUserDefaults:DBVersion];//获取数据库版本号
    

    //判断配置文件中版本号是否相等，如果不相等，复制文件，如果相等，不处理更新
    if (DBVersionValue > oldDBVersion ) {
        
        //原始sql文件路径
        NSString *sqlFilePath = [[NSBundle mainBundle] pathForResource:DBName ofType:@"sqlite"];
        
        NSFileManager *fm = [NSFileManager defaultManager];//文件管理器
        BOOL existed = [fm fileExistsAtPath:self.dbFilePath];
        //NSError *err = nil;
        //删除原有数据库
        if (existed) {
            [fm removeItemAtPath:self.dbFilePath error:nil];
        }
    
//        if(!err && [fm fileExistsAtPath:self.dbFilePath] == NO)//如果sql文件不在doc下，copy过来
        if([fm fileExistsAtPath:self.dbFilePath] == NO)//如果sql文件不在doc下，copy过来
        {
            NSError *error = nil;
            if([fm copyItemAtPath:sqlFilePath toPath:self.dbFilePath error:&error] == NO)
            {
                NSLog(@"数据库初始化失败---Fail to create database：%@",[error localizedDescription]);
            }
            //设置数据库版本
            [GVUserDefaults standardUserDefaults].oldDBVersion = DBVersionValue;
        }
    }
    
    //初始化数据库方法
    self.fmDatabase = [FMDatabase databaseWithPath:self.dbFilePath];
    if (![self.fmDatabase open]){
        NSLog(@"数据库打开失败");
    }else
    {
        //初始化类型数据
        if (oldDBVersion != DBVersionValue ) {
        }
    }
    
}

@end
