//
//  EdgeLoginViewController.h
//  gd_port
//
//  Created by UEdge on 2017/10/26.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBBaseViewController.h"
#import "UserModel.h"

@interface EdgeLoginViewController : BBBaseViewController
/**用户登录*/
@property(assign,nonatomic,getter=isLogin)BOOL isLogin;



+ (EdgeLoginViewController *)shareInstance;
/**
 登录功能

 @param userName user
 @param passWorad password
 */
//-(void)loginActionWithUserName:(NSString *)userName Password:(NSString *)passWorad;


@end
