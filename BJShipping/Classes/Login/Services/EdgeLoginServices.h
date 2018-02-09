//
//  EdgeLoginServices.h
//  gd_port
//
//  Created by UEdge on 2017/10/30.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "BaseRequestService.h"

@interface EdgeLoginServices : BaseRequestService

/**
 登录用户名

 @param code 用户名
 @param pwd 密码
 @return id
 */
- (instancetype)initWithLoginCode:(NSString *)code loginPwd:(NSString *)pwd;


@end
