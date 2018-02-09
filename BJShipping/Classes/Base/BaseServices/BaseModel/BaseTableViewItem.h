//
//  BaseTableViewItem.h
//  iPhoto
//  表格项目
//  Created by RockeyCai on 16/4/18.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseTableViewItem : NSObject

/**
 *  id
 */
@property (assign , nonatomic)long long ID;
/**
 *  图标
 */
@property (retain , nonatomic)NSString *icon;
/**
 *  标题
 */
@property (retain , nonatomic)NSString *title;
/**
 *  描述
 */
@property (retain , nonatomic)NSString *detail;
/**
 *  类型
 */
@property (assign , nonatomic) NSInteger type;

/**
 *  Cell样式
 */
@property (assign , nonatomic) UITableViewCellAccessoryType tableViewCellAccessoryType;

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
                    type:(NSInteger)type accessoryType:(UITableViewCellAccessoryType)accessoryType;
-(instancetype)initTitle:(NSString *)title icon:(NSString *)icon type:(NSInteger)type accessoryType:(UITableViewCellAccessoryType)accessoryType;
-(instancetype)initTitle:(NSString *)title icon:(NSString *)icon type:(NSInteger)type;
-(instancetype)initTitle:(NSString *)title icon:(NSString *)icon;
-(instancetype)initTitle:(NSString *)title;
-(instancetype)initValut:(int)ID title:(NSString *)title icon:(NSString *)icon;
-(instancetype)initValut:(int)ID title:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType;

/**
 *  获取图片
 *
 *  @return <#return value description#>
 */
-(UIImage*) iconImg;


@end
