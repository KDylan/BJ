//
//  FuzzyShipApi.h
//  
//  描述：船只模糊搜索类模型类的服务模型。(自动生成，代码模块1.0v)
//  Created by RockeyCai on 2016-12-26 12:06:34.
//  Copyright (c) 2016年 RockeyCai. All rights reserved.
//

#import "BaseRequestService.h"
#import "FuzzyShip.h"

@interface FuzzyShipApi : BaseRequestService

/**
 构造方法

 @param pinYinShipName 船只模糊搜索类模型类的模型

 @return 船只模糊搜索类模型类的服务模型
 */
- (id)initWithFuzzyShip:(NSString *)pinYinShipName;

@end
