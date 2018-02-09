//
//  EdgeFlowViewModel.h
//  BJShipping
//
//  Created by UEdge on 2017/10/17.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EdgeFlowViewModel : NSObject
///**标题文字*/
//@property(nonatomic,copy)NSString *titleIndex;
///**图片文字*/
//@property(nonatomic,copy)NSString *imageName;
//
///**图片文字*/
//@property(nonatomic,copy)NSString *Scroll_Url;

@property(nonatomic,assign)NSInteger ID;

@property(nonatomic,copy)NSString *nn_news_title;

@property(nonatomic,copy)NSString *nn_news_content;

@property(nonatomic,copy)NSString *nn_news_time;

@property(nonatomic,copy)NSString *nn_news_date;

@property(nonatomic,copy)NSString *nn_news_writer;

@property(nonatomic,copy)NSString *nn_news_user;

@property(nonatomic,copy)NSString *nn_news_count;

@property(nonatomic,copy)NSString *nn_news_end_time;

@property(nonatomic,copy)NSString *nn_news_type;

@property(nonatomic,copy)NSString *nn_news_source;

@property(nonatomic,copy)NSString *nn_news_rec;

@property(nonatomic,copy)NSString *operate_person;


@property(nonatomic,copy)NSString *operate_time;

@property(nonatomic,copy)NSString *operate_type;

@property(nonatomic,copy)NSString *back_up1;

@property(nonatomic,copy)NSString *back_up2;

@property(nonatomic,copy)NSString *back_up3;

@property(nonatomic,copy)NSString *back_up4;

@property(nonatomic,copy)NSString *back_up5;



+(instancetype)flowDataWithDict:(NSDictionary *)dict;



/**
 滚动视图图片数据

 @return muarr
 */
+(NSMutableArray *)getScrollImageMuArr;

@end
