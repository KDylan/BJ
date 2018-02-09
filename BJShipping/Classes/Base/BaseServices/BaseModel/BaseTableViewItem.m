//
//  BaseTableViewItem.m
//  iPhoto
//
//  Created by RockeyCai on 16/4/18.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "BaseTableViewItem.h"

@implementation BaseTableViewItem


@synthesize ID = _ID;

@synthesize icon = _icon;

@synthesize title = _title;

@synthesize type = _type;

@synthesize detail = _detail;

@synthesize tableViewCellAccessoryType = _tableViewCellAccessoryType;

/**
 *  构造方法
 *
 *  @param ID            编码
 *  @param title         标题
 *  @param detail        描述
 *  @param icon          icon图片
 *  @param type          类型
 *  @param accessoryType Cell类型
 *
 *  @return BaseTableViewItem
 */
-(instancetype)initValut:(int)ID title:(NSString *)title detail:(NSString *)detail icon:(NSString *)icon
                    type:(NSInteger)type accessoryType:(UITableViewCellAccessoryType)accessoryType
{
    self = [super init];
    if (self) {
        _ID = ID;
        _title = title;
        _detail = detail;
        _icon = icon;
        _type = type;
        _tableViewCellAccessoryType = accessoryType;
    }
    return self;
}

-(instancetype)initTitle:(NSString *)title icon:(NSString *)icon type:(NSInteger)type accessoryType:(UITableViewCellAccessoryType)accessoryType
{
    return [self initValut:0 title:title detail:nil icon:icon type:type accessoryType:accessoryType];
}

-(instancetype)initTitle:(NSString *)title icon:(NSString *)icon type:(NSInteger)type
{
    return [self initValut:0 title:title detail:nil icon:icon type:type accessoryType:UITableViewCellAccessoryNone];
}

-(instancetype)initTitle:(NSString *)title icon:(NSString *)icon
{
    return [self initTitle:title icon:icon type:0];
}

-(instancetype)initTitle:(NSString *)title{
    return [self initTitle:title icon:nil type:0];
}


-(instancetype)initValut:(int)ID title:(NSString *)title icon:(NSString *)icon
{
    return [self initValut:ID title:title detail:nil icon:icon type:0 accessoryType:UITableViewCellAccessoryNone];
}

-(instancetype)initValut:(int)ID title:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType{
    return [self initValut:ID title:title detail:nil icon:nil type:0 accessoryType:accessoryType];
}

/**
 *  获取图片
 *
 *  @return UIImage
 */
-(UIImage*) iconImg
{
    return _icon == nil ? nil : [UIImage imageNamed:_icon];
}


@end
