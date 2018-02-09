//
//  MenuItem.h
//  GHBusinessSv
//
//  Created by RockeyCai on 2016/10/27.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "BaseTableViewItem.h"


typedef NS_ENUM(NSInteger, MuneItemType) {
    MLocation = 0,//位置
    MScheduling,//调度
    MSetting,//设置
};


@interface MenuItem : BaseTableViewItem

/**
 *  菜单
 *
 *  @return NSArray
 */
+(NSArray *)getMenuList;

@end
