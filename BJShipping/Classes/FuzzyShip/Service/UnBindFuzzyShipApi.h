//
//  UnBindFuzzyShipApi.h
//  captain
//
//  Created by RockeyCai on 2016/12/27.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "BaseRequestService.h"
#import "FuzzyShip.h"

@interface UnBindFuzzyShipApi : BaseRequestService
/**
 构造方法
 
 @param FuzzyShip 船只模糊搜索类模型类的模型
 
 @return 船只模糊搜索类模型类的服务模型
 */
- (id)initWithFuzzyShip:(FuzzyShip *)fuzzyShip;

@end
