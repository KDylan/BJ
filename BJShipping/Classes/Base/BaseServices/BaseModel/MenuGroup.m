//
//  MenuGroup.m
//  GHBusinessSv
//
//  Created by RockeyCai on 2016/11/9.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "MenuGroup.h"
#import "MenuItem.h"

@implementation MenuGroup


@synthesize headTitle = _headTitle;

@synthesize footerTitle = _footerTitle;

@synthesize itemArray = _itemArray;


-(instancetype)initHeadTitle:(NSString *)headTitle footerTitle:(NSString *)footerTitle{
    self = [super init];
    if (self) {
        _headTitle = headTitle;
        _footerTitle = footerTitle;
    }
    return self;
}


-(instancetype)initHeadTitle:(NSString *)headTitle{
    return [self initHeadTitle:headTitle footerTitle:nil];
}

-(instancetype)initFooterTitle:(NSString *)footerTitle{
    return [self initHeadTitle:nil footerTitle:footerTitle];
}

/**
 *  分组子项数量
 *
 *  @return long
 */
-(long) size
{
    return [_itemArray count];
}


-(void)addItem:(MenuItem *)item
{
    if (_itemArray == nil) {
        _itemArray = [[NSMutableArray alloc] init];
    }
    [_itemArray addObject:item];
}


@end
