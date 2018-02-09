//
//  AsyncHelper.m
//  BaseFrame
//
//  Created by RockeyCai on 16/9/11.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "AsyncHelper.h"

@implementation AsyncHelper


+(void)inBackgroundVoid:(InBackgroundVoid)inBackgroundVoid{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        inBackgroundVoid();
    });
    
}


+(void)inBackground:(InBackground)inBackground onMainUI:(OnMainUI)onMainUI{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
            inBackground();
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            onMainUI(inBackground);
        });
    });
    
}

+(void)onMainUI:(OnMainUI)onMainUI{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 更新界面
        onMainUI(nil);
    });
}

/**
 *  延迟执行
 *
 *  @param delayInSeconds delayInSeconds延时秒数
 *  @param onMainUI       执行任务
 */
+(void)after:(double)delayInSeconds onMainUI:(OnMainUI)onMainUI{
    
//    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        onMainUI(nil);
    });

}


@end
