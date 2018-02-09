//
//  EdgeCollectionModel.h
//  BJShipping
//
//  Created by UEdge on 2017/10/17.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface EdgeCollectionModel : NSObject

@property(nonatomic,assign)BOOL isLogin;
/**编号*/
@property(nonatomic , assign) NSInteger ID;

/**连接*/
@property(nonatomic , retain) NSString *url;

/**按钮图片*/
@property(nonatomic,copy)NSString *buttonImageName;
/**按钮label*/
@property(nonatomic,copy)NSString *buttonLabel;

/**消息数量*/
@property(nonatomic,copy)NSString *messageCount;



/**
 用户类型
 */
@property (nonatomic, assign) UserType userType;

/**
 *  构造方法
 */
-(instancetype)initID:(NSInteger)ID imageName:(NSString *)buttonImageName label:(NSString *)buttonLabel  userType:(UserType)userType;



/**
 *  主页菜单
 *
 *  @return NSArray
 */
+(NSArray *)getHomeCollectionViewMenuArray:(UserType)userType;
/**
 障碍信息

 @return nsarr
 */
//+(NSArray *)getWarnInfoCollectionArray;

@end
