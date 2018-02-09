//
//  ResultModel.h
//  GHBusinessSv
//
//  Created by RockeyCai on 2016/12/5.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//
/**
 成功：{
 success:"true",
 errorMessage:"",
 result:{
 //这里是json格式
 }//如果有结果集
 }
 失败：{
 success:"false",
 errorMessage:"错误信息"
 result:{}
 }
 **/

#import "JSONModel.h"

@interface ResultModel : JSONModel

@property (assign , nonatomic) BOOL success;

@property (retain , nonatomic) NSString<Optional>* errorMessage;

@property (retain , nonatomic) id<Optional> result;

@end
