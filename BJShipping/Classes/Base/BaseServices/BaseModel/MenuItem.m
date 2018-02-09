//
//  MenuItem.m
//  GHBusinessSv
//
//  Created by RockeyCai on 2016/10/27.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "MenuItem.h"


@implementation MenuItem

/**
 *  菜单
 *
 *  @return NSArray
 */
+(NSArray *)getMenuList{
    
    NSMutableArray *menuList= [[NSMutableArray alloc] init];
    
    NSInteger ids[] = {MLocation , MScheduling , MSetting };
    NSArray *titleArray = @[ @"位置" ,
                             @"调度",
                             @"设置"];
    NSArray *iconArray = @[ @"radio_but_location" , @"radio_but_conversation" , @"radio_but_setting" ];
    
    for (int ID = 0; ID < titleArray.count ; ID++) {
        
        MenuItem *item =[[MenuItem alloc] initTitle:titleArray[ID] icon:iconArray[ID] type:ids[ID]];
        [menuList addObject:item];
        
    }
    
    return menuList;
}

@end
