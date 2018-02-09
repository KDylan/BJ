//
//  GeTuiMessage.h
//  captain
//
//  Created by RockeyCai on 2016/12/27.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "JSONModel.h"
#import "GTCommandParamModel.h"

typedef NS_ENUM(NSInteger, GeTuiMessageType) {
    Default = 0,//
    RequestToUpload = 1,//1：请求上传gps位置
    SchedulingMessages = 2,//2：调度信息
};



@interface GeTuiMessage : JSONModel

//{"CommandType":"1","CommandDesc":"CommandDesc","CommandParam":"{}"}
/**
 * 消息类型:
 */
@property (nonatomic,assign) GeTuiMessageType CommandType;

/**
 * 消息类型描述
 */
@property (nonatomic,retain) NSString<Optional> *CommandDesc;

/**
 * 消息扩展参数
 */
@property (nonatomic,strong) GTCommandParamModel *CommandParam;


@end
