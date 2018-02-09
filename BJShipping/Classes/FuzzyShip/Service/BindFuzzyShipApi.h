//
//  BindFuzzyShipApi.h
//  captain
//  绑定船只
//  Created by RockeyCai on 2016/12/26.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "BaseRequestService.h"
#import "FuzzyShip.h"

@interface BindFuzzyShipApi : BaseRequestService

/**
 构造方法

 
 @return 船只模糊搜索类模型类的服务模型
 */
- (id)initWithFuzzyShip:(FuzzyShip *)fuzzyShip;

@end
