//
//  EdgeFlowViewModel.m
//  BJShipping
//
//  Created by UEdge on 2017/10/17.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "EdgeFlowViewModel.h"

@implementation EdgeFlowViewModel



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


+(instancetype)flowDataWithDict:(NSDictionary *)dict{
   
    EdgeFlowViewModel *flowData = [EdgeFlowViewModel mj_objectWithKeyValues:dict];
   
    return flowData;
}



+(NSMutableArray *)getScrollImageMuArr{

    NSMutableArray *imageMUArr = [NSMutableArray array];

    NSArray *arr = @[
            @{
                @"titleIndex":@"0",@"imageName":@"0",@"Scroll_Url":@"https://www.baidu.com/"
                },
            @{
                @"titleIndex":@"1",@"imageName":@"1",@"Scroll_Url":@"http://news.baidu.com/"
                },
            @{
                @"titleIndex":@"2",@"imageName":@"2",@"Scroll_Url":@"https://tieba.baidu.com/index.html"
                },
            @{
                @"titleIndex":@"3",@"imageName":@"3",@"Scroll_Url":@"https://zhidao.baidu.com/"
                },
            @{
                @"titleIndex":@"4",@"imageName":@"4",@"Scroll_Url":@"http://music.baidu.com/"
                },
            @{
                @"titleIndex":@"5",@"imageName":@"5",@"Scroll_Url":@"http://image.baidu.com/"
                }
            ];
    for (NSDictionary *dict in arr) {
        
        EdgeFlowViewModel *flowModel = [EdgeFlowViewModel flowDataWithDict:dict];
        
        [imageMUArr addObject:flowModel];
    }
    
    return imageMUArr;
}
@end
