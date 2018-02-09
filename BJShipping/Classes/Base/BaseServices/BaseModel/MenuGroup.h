//
//  MenuGroup.h
//  GHBusinessSv
//
//  Created by RockeyCai on 2016/11/9.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MenuItem;

@interface MenuGroup : NSObject

/**
 *  组头部标题
 */
@property (retain , nonatomic) NSString *headTitle;
/**
 *  组底部标题
 */
@property (retain , nonatomic) NSString *footerTitle;
/**
 *  组子项个数
 */
@property (assign , nonatomic , readonly) long size;
/**
 *  子项
 */
@property (retain , nonatomic) NSMutableArray *itemArray;


-(instancetype)initHeadTitle:(NSString *)headTitle footerTitle:(NSString *)footerTitle;

-(instancetype)initHeadTitle:(NSString *)headTitle;

-(instancetype)initFooterTitle:(NSString *)footerTitle;


-(void)addItem:(MenuItem *)item;

@end
