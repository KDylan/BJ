//
//  NewScrollModel.h
//  BJShipping
//
//  Created by UEdge on 2018/2/2.
//  Copyright © 2018年 UEdge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EdgeScycleNewsModel.h"
@interface NewScrollModel : NSObject

// rows模型数组
@property(nonatomic,strong)NSArray *rows;


//  统计总数
@property(nonatomic,assign)NSInteger total;

//  页数
@property(nonatomic,assign)NSInteger page;


@end
