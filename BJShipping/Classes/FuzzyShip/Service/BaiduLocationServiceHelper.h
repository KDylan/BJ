//
//  BaiduLocationServiceHelper.h
//  captain
//
//  Created by RockeyCai on 2016/12/27.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaiduLocationServiceHelper : NSObject


/**
 *  获取单例对象
 *  @return <#return value description#>
 */
+ (BaiduLocationServiceHelper *)getSingleton;

/**
 上传位置信息
 */
-(void)sendGSPInfo;

@end
