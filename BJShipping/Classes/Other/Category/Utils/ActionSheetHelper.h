//
//  ActionSheetHelper.h
//  iPhoto
//
//  Created by RockeyCai on 16/4/27.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

typedef void (^CancelBlock)();

typedef void (^OKBlock)();

typedef void (^OtherBlock)(NSInteger);

@interface ActionSheetHelper : NSObject


/**
 *  ActionSheetHelper单例方法
 *
 *  @return ActionSheetHelper
 */
+ (ActionSheetHelper *)getInstance;

/**
 *  显示 UIActionSheet 默认显示确定，取消按钮
 *
 *  @param title       标题
 *  @param okBlock     确定回调
 *  @param view        承载父页面
 */
-(void)showTitle:(NSString *)title
         okBlock:(OKBlock)okBlock
           view : (UIView*)view;


/**
 *  显示 UIActionSheet
 *
 *  @param title       标题
 *  @param cancleTitle 取消标题
 *  @param cancelBlock 取消回调
 *  @param okTitle     确定标题
 *  @param okBlock     确定回调
 *  @param view        承载父页面
 */
-(void)showTitle:(NSString *)title
cancelButtonTitle:(NSString *)cancleTitle
     cancelBlock:(CancelBlock)cancelBlock
   okButtonTitle:(NSString *)okTitle
         okBlock:(OKBlock)okBlock
            view:(UIView*)view;

/**
 *  显示 UIActionSheet
 *
 *  @param title       标题
 *  @param otherButtonTitles     其他标题集合
 *  @param otherBlock  其他回调
 *  @param view        承载父页面
 */
-(void)showTitle:(NSString *)title
otherButtonTitles:(NSArray *)otherButtonTitles
      otherBlock:(OtherBlock)otherBlock
            view:(UIView *)view;

/**
 *  显示 UIActionSheet
 *
 *  @param title       标题
 *  @param cTitle      取消标题
 *  @param cancelBlock 取消回调
 *  @param otherButtonTitles     其他标题集合
 *  @param otherBlock  其他回调
 *  @param view        承载父页面
 */
-(void)showTitle:(NSString *)title
cancelButtonTitle:(NSString *)cancelTitle
     cancelBlock:(CancelBlock)cancelBlock
otherButtonTitles:(NSArray *)otherButtonTitles
      otherBlock:(OtherBlock)otherBlock
            view:(UIView *)view;

@end
