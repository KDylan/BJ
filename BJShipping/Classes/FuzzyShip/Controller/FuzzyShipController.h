//
//  FuzzyShipController.h
//  
//  描述：船只模糊搜索类模型类的UIViewController。(自动生成，代码模块1.0v)
//  Created by RockeyCai on 2016-12-26 12:06:34.
//  Copyright (c) 2016年 RockeyCai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
//#import "FuzzyShip.h"

@interface FuzzyShipController : BaseTableViewController

//@property (nonatomic , strong) FuzzyShip *item;

@property (nonatomic , retain) NSMutableArray *fuzzyShipArray;

@property (nonatomic , copy) void (^bindOkCb)();

@end

