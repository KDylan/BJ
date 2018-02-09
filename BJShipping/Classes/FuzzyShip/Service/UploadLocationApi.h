//
//  UploadLocationApi.h
//  captain
//
//  Created by RockeyCai on 2016/12/27.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "BaseRequestService.h"

@interface UploadLocationApi : BaseRequestService

//- (id)initWithMsg:(NSString *)msg;

/**
 构造方法

 @param testHelperState false
 @param shipId 船名id
 @param userId userid
 @param lat 纬度
 @param gpsTime 精度
 @return id
 */
- (instancetype)initWithtestHelperState:(NSString *)testHelperState shipId:(NSString *)shipId  userId:(NSString *)userId lat:(NSString *)lat lng:(NSString *)lng  gpsTime:(NSString *)gpsTime;

@end
