//
//  EdgeUserModel.h
//  gd_port
//
//  Created by UEdge on 2017/10/26.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import <Foundation/Foundation.h>
/*游客：TOURIST
会员：HuiYuan
管理员:001
港航系统水运企业：GHXTSYQY
交通局用户：GHGLBM*/


typedef NS_ENUM(NSInteger, UserType) {
    TOURIST = 0,//游客
    HuiYuan,   //  会员
    Admin,    //  管理员
    GHXTSYQY,//  港航系统水运企业
    GHGLBM    //  交通局用户
};


@interface UserModel : NSObject
/**用户id*/
//@property(nonatomic,assign)long long id;
@property(nonatomic,assign) NSInteger ID;
/**账号*/
@property(nonatomic,copy)NSString *vf_user_code;
/**密码*/
@property(nonatomic,copy)NSString *vf_user_password;
/**手机号*/
@property(nonatomic,copy)NSString *vf_phone;
/**qq*/
@property(nonatomic,copy)NSString *vf_qq;
/**mail*/
@property(nonatomic,copy)NSString *vf_mail;
/**type*/
@property(nonatomic,copy)NSString *vf_user_type;

@property(nonatomic,copy)NSString *operate_person;

@property(nonatomic,copy)NSString *operate_time;


@property(nonatomic,copy)NSString *operate_type;

@property(nonatomic,copy)NSString *back_up1;
@property(nonatomic,copy)NSString *back_up2;
@property(nonatomic,copy)NSString *back_up3;
@property(nonatomic,copy)NSString *back_up4;
@property(nonatomic,copy)NSString *back_up5;


+(UserModel *)getInstance;

/**
 获取登录用户
 
 @return model
 */
+(UserModel *)getUserModel;

/**
 清除用户数据
 */
+(void)cleanUserModel;

/**
 保存用户数据
 */
-(void)saveUserModel;


/**
 用户类型
 */
-(UserType)getUserType;

@end
