//
//  AsyncHelper.h
//  BaseFrame
//  耗时任务帮助类
//  Created by RockeyCai on 16/9/11.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^InBackgroundVoid)();

typedef void (^OnMainUIVoid)();

typedef void (^InBackground)();

typedef void (^OnMainUI)(id obj);

@interface AsyncHelper : NSObject

/**
 *  耗时任务
 */
//@property (nonatomic,copy) InBackground inBackground;

/**
 *  前台UI操作
 */
//@property (nonatomic,copy) OnMainUI onMainUI;

+(void)inBackgroundVoid:(InBackgroundVoid)inBackgroundVoid;

+(void)inBackground:(InBackground)inBackground onMainUI:(OnMainUI)onMainUI;

+(void)onMainUI:(OnMainUI)onMainUI;

/**
 *  延迟执行
 *
 *  @param delayInSeconds delayInSeconds延时秒数
 *  @param onMainUI       执行任务
 */
+(void)after:(double)delayInSeconds onMainUI:(OnMainUI)onMainUI;

@end
