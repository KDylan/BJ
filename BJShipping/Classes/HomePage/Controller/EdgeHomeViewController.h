//
//  EdgeHomeViewController.h
//  BJShipping
//
//  Created by UEdge on 2017/12/18.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EdgeHomeViewController : UIViewController

+ (EdgeHomeViewController *)getInstance;

/**
 mainVC是否已经弹出
 */
@property(nonatomic,assign,getter=isPresnted)BOOL isPresnted;


/**
 打开环形聊天界面
 */
-(void)showCharView;

/**
 获取未读消息数量
 */
-(void)hasNewMessage;

/**
 通用访问webView方法
 
 @param url URL
 */
-(void)openWebViewVCWithUrl:(NSString *)url;

/**
 加载个推的webView
 
 @param webURL url
 */
-(void)showGTWebViewController:(NSString *)webURL;

/**
 刷新funcView【下半部分按钮】
 */
-(void)reloadFuncView;

@end
