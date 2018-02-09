//
//  FuzzyShipModel.h
//  BJShipping
//
//  Created by UEdge on 2018/2/5.
//  Copyright © 2018年 UEdge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FuzzyShipModel : NSObject


// rows模型数组
@property(nonatomic,strong)NSArray *result;


//  是否成功
@property(nonatomic,assign,getter=isSuccess)BOOL success;

//  错误信息
@property(nonatomic,retain)NSString *errorMessage;


@end
