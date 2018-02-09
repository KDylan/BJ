//
//  EdgeUserModel.m
//  gd_port
//
//  Created by UEdge on 2017/10/26.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "UserModel.h"

static UserModel *instance = nil;

@implementation UserModel

+(UserModel *)getInstance{
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserModel alloc]init];
    });
    return instance;
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
   
    if (oldValue == nil) {
        return @"";  // 以字符串类型为例
    }
    return oldValue;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}

/**
 获取登录用户
 
 @return model
 */
+(UserModel *)getUserModel{
    
    NSString *json = BBUserDefault.userModelJSON;

    NSDictionary *dict = [EdgeJsonHelper dictionaryWithJsonString:json];
    if (json) {
        UserModel *userModel = [UserModel mj_objectWithKeyValues:dict];
        return userModel;
    }
    return nil;
}


/**
 清除用户数据
 */
+(void)cleanUserModel{
    
    BBUserDefault.userModelJSON = nil;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user removeObjectForKey:@"isLogin"];
}
/**
 保存用户数据
 */
-(void)saveUserModel{
    
    NSString *json = [self mj_JSONString];
    
    BBUserDefault.userModelJSON = json;
}


/**
 获取用户信息
 
 @return str
 */
+(NSString *)getUserInfo{
    
        
        //    &userId=cwh&userNum=27074&unitId=44000000&groupId=9&isAppOrWechat=1
        //    &userId=cwh&userNum=27074&unitId=44000000&groupId=9&isAppOrWechat=1
        
        NSString *userJson = BBUserDefault.userModelJSON;
        
        NSDictionary *userDict = [EdgeJsonHelper dictionaryWithJsonString:userJson];
        
        NSString *userId =  [userDict valueForKey:@"userId"];
        NSString *userNum =  [userDict valueForKey:@"userNum"];
        NSString *unitId =  [userDict valueForKey:@"unitId"];
        NSString *groupId =  [userDict valueForKey:@"groupId"];
        
        NSString *userInfoStr = [NSString stringWithFormat:@"&userId=%@&userNum=%@&unitId=%@&groupId=%@&isAppOrWechat=1",userId,userNum,unitId,groupId];
        
        return userInfoStr;
}

/**
 登录用户角色
 用户角色分类
 游客：TOURIST
 会员：HuiYuan
 管理员:001
 港航系统水运企业：GHXTSYQY
 交通局用户：GHGLBM
 @return string
 */
-(NSString *)vf_user_type{
    
    if ([_vf_user_type isEqualToString:@"GHGLBM"]) {
        return @"交通局用户";
    }else if ([_vf_user_type isEqualToString:@"GHXTSYQY"]) {
        return @"港航系统水运企业";
    }else if([_vf_user_type isEqualToString:@"001"]){
        return @"管理员";
    }else if([_vf_user_type isEqualToString:@"HuiYuan"]){
        return @"会员";
    }else{
        return @"游客";
    }
}


/**
 用户类型
 */
-(UserType)getUserType{
    
    if ([_vf_user_type isEqualToString:@"GHGLBM"]) {
        return GHGLBM;//交通局用户
    }else if ([_vf_user_type isEqualToString:@"GHXTSYQY"]) {
        return GHXTSYQY;//港航系统水运企业
    }else if([_vf_user_type isEqualToString:@"001"]){
        return Admin; // 管理员
    }else if([_vf_user_type isEqualToString:@"HuiYuan"]){
        return HuiYuan; // 会员
    }else{
        return TOURIST;//游客
    }
}

-(NSString *)vf_phone{
    if (_vf_phone.length<=0) {
       
        _vf_phone = @"未绑定";
    }
    return _vf_phone;
}

-(NSString *)vf_qq{
    if (_vf_qq.length<=0) {
        
        _vf_qq = @"未绑定";
    }
    return _vf_qq;
}

-(NSString *)vf_mail{
    if (_vf_mail.length<=0) {
        
        _vf_mail = @"未绑定";
    }
    return _vf_mail;
}
@end
