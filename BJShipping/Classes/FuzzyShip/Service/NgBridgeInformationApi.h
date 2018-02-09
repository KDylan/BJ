//
//  NgBridgeInformationApi.h
//  
//  描述：桥梁信息的服务模型。(自动生成，代码模块1.0v)
//  Created by RockeyCai on 2016-12-22 18:26:21.
//  Copyright (c) 2016年 RockeyCai. All rights reserved.
//

#import "BaseRequestService.h"
#import "NgBridgeInformation.h"

@interface NgBridgeInformationApi : BaseRequestService

/**
 构造方法

 @param ngBridgeInformation 桥梁信息的模型

 @return 桥梁信息的服务模型
 */
- (id)initWithNgBridgeInformation:(NgBridgeInformation *)ngBridgeInformation;

@end
