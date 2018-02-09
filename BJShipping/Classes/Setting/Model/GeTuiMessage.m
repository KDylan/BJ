//
//  GeTuiMessage.m
//  captain
//
//  Created by RockeyCai on 2016/12/27.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "GeTuiMessage.h"

@implementation GeTuiMessage


/**设置所有属性可选，防止值为空炸了*/
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end
