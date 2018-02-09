//
//  AlertViewHelper.h
//  upload
//  UIAlert帮助类
//  Created by RockeyCai on 16/3/19.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^LeftBlock)();

typedef void (^RightBlock)();

typedef void (^RightBlockWithText)(NSString *);


/**
 *  UIAlert帮助类
 */
@interface AlertViewHelper : NSObject

+ (AlertViewHelper *)getInstance;

/**
 *  显示Alert输入框  默认左边取消按钮，右边确定按钮
 *
 *  @param title      标题
 *  @param rightBlock 确定回调
 *  @param textFieldValue 输入框文本
 */
-(void)showInput:(NSString *)title
      rightBlock:(RightBlockWithText) rightBlockWithText
  textFieldValue:(NSString *)text;


/**
 *  显示Alert输入框  默认左边取消按钮，右边确定按钮
 *
 *  @param title      标题
 *  @param rightBlockWithText 确定回调
 */
-(void)showInput:(NSString *)title
      rightBlock:(RightBlockWithText) rightBlockWithText;

/**
 *  显示Alert输入框  默认左边取消按钮，右边确定按钮
 *
 *  @param title      标题
 *  @param msg        提示
 *  @param rightBlock 确定回调
 */
-(void)showInput:(NSString *)title
             msg:(NSString *)msg
      rightBlock:(RightBlockWithText) rightBlock;

/**
 *  显示Alert输入框  默认左边取消按钮，右边确定按钮
 *
 *  @param title      标题
 *  @param msg        提示
 *  @param rightBlock 确定回调
 *  @param textFieldValue 输入框文本
 */
-(void)showInput:(NSString *)title
             msg:(NSString *)msg
      rightBlock:(RightBlockWithText) rightBlockWithText
  textFieldValue:(NSString *)text;

/**
 *  显示Alert输入框  默认左边取消按钮，右边确定按钮
 *
 *  @param title      标题
 *  @param msg        提示
 *  @param leftTitle  左边按钮
 *  @param leftBlock  左边回调
 *  @param rigthTitle 右边按钮
 *  @param rightBlock 右边回调
 */
-(void)showInput:(NSString *)title
             msg:(NSString *)msg
       leftTitle:(NSString *)leftTitle
       leftBlock:(LeftBlock) leftBlock
      rigthTitle:(NSString *)rigthTitle
      rightBlock:(RightBlockWithText) rightBlock;

/**
 *  显示Alert输入框  默认左边取消按钮，右边确定按钮
 *
 *  @param title      标题
 *  @param msg        提示
 *  @param leftTitle  左边按钮
 *  @param leftBlock  左边回调
 *  @param rigthTitle 右边按钮
 *  @param rightBlock 右边回调
 *  @param textFieldValue 输入框文本
 */
-(void)showInput:(NSString *)title
             msg:(NSString *)msg
       leftTitle:(NSString *)leftTitle
       leftBlock:(LeftBlock) leftBlock
      rigthTitle:(NSString *)rigthTitle
      rightBlock:(RightBlockWithText) rightBlockWithText
 textFieldValue : (NSString *)text;



/**
 *  显示Alert 默认显示 确定按钮
 *
 *  @param title      标题
 *  @param msg        提示
 */
-(void)show:(NSString *)title msg:(NSString *)msg;



/**
 *  显示Alert 默认显示 确定按钮
 *
 *  @param title      标题
 *  @param msg        提示
 *  @param leftBlock  回调
 */
-(void)show:(NSString *)title msg:(NSString *)msg  leftBlock:(LeftBlock) leftBlock;

/**
 *  显示Alert 默认显示 取消,确定按钮
 *
 *  @param title      标题
 *  @param msg        提示
 *  @param rightBlock 右边按钮回调
 */
-(void)show:(NSString *)title
        msg:(NSString *)msg
 rightBlock:(RightBlock) rightBlock;

/**
 *  显示Alert
 *
 *  @param title      标题
 *  @param msg        提示
 *  @param leftTitle  左边按钮提示
 *  @param leftBlock  左边按钮回调
 *  @param rigthTitle 右边按钮提示
 *  @param rightBlock 右边按钮回调
 */
-(void)show:(NSString *)title
        msg:(NSString *)msg
  leftTitle:(NSString *)leftTitle
  leftBlock:(LeftBlock) leftBlock
 rigthTitle:(NSString *)rigthTitle
 rightBlock:(RightBlock) rightBlock;

@end
