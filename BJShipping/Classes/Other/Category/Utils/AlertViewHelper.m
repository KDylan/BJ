//
//  AlertViewHelper.m
//  upload
//
//  Created by RockeyCai on 16/3/19.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "AlertViewHelper.h"

@import UIKit;

static AlertViewHelper *instance = nil;

@interface AlertViewHelper()<UIAlertViewDelegate>

@property (nonatomic,copy) LeftBlock leftBlock;

@property (nonatomic,copy) RightBlock rightBlock;

@property (nonatomic,copy) RightBlockWithText rightBlockWithText;

@end


@implementation AlertViewHelper

+ (AlertViewHelper *)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AlertViewHelper alloc] init];
    });
    
    return instance;
}


/**
 *  显示Alert输入框  默认左边取消按钮，右边确定按钮
 *
 *  @param title      标题
 *  @param rightBlock 确定回调
 *  @param textFieldValue 输入框文本
 */
-(void)showInput:(NSString *)title
      rightBlock:(RightBlockWithText) rightBlockWithText
  textFieldValue:(NSString *)text{
    
    [self showInput:title ? title : @"提示" msg:nil leftTitle:@"取消" leftBlock:nil rigthTitle:@"确定" rightBlock:rightBlockWithText textFieldValue:text];
    
}


/**
 *  显示Alert输入框  默认左边取消按钮，右边确定按钮
 *
 *  @param title      标题
 *  @param rightBlock 确定回调
 */
-(void)showInput:(NSString *)title
      rightBlock:(RightBlockWithText) rightBlockWithText{
    
    [self showInput:title ? title : @"提示" msg:nil leftTitle:@"取消" leftBlock:nil rigthTitle:@"确定" rightBlock:rightBlockWithText];
    
}


/**
 *  显示Alert输入框  默认左边取消按钮，右边确定按钮
 *
 *  @param title      标题
 *  @param msg        提示
 *  @param rightBlock 确定回调
 */
-(void)showInput:(NSString *)title
             msg:(NSString *)msg
      rightBlock:(RightBlockWithText) rightBlockWithText{
    
    [self showInput:title msg:msg leftTitle:@"取消" leftBlock:nil rigthTitle:@"确定" rightBlock:rightBlockWithText];
    
}


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
  textFieldValue:(NSString *)text{
    
    [self showInput:title msg:msg leftTitle:@"取消" leftBlock:nil rigthTitle:@"确定" rightBlock:rightBlockWithText textFieldValue:text];
    
}

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
 rightBlock:(RightBlockWithText) rightBlockWithText{
    
    [self showInput:title msg:msg leftTitle:leftTitle leftBlock:leftBlock rigthTitle:rigthTitle rightBlock:rightBlockWithText textFieldValue:nil];

}


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
      textFieldValue : (NSString *)text
    {
    self.leftBlock = nil;
    self.leftBlock = [leftBlock copy];
    self.rightBlockWithText = nil;
    self.rightBlockWithText = [rightBlockWithText copy];
    UIAlertView *alert = [self buildAlertVew:title msg:msg leftTitle:leftTitle rigthTitle:rigthTitle];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *tf = [alert textFieldAtIndex:0];
    tf.text = text;
    //设置键盘风格
    //tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.returnKeyType = UIReturnKeyDone;
    [alert show];
    
}


/**
 *  显示Alert 默认显示 确定按钮
 *
 *  @param title      标题
 *  @param msg        提示
 */
-(void)show:(NSString *)title msg:(NSString *)msg
{
    [self show:title ? title : @"提示"
           msg:msg
     leftTitle:nil
     leftBlock:nil
    rigthTitle:@"确定"
    rightBlock:nil];
}



/**
 *  显示Alert 默认显示 确定按钮
 *
 *  @param title      标题
 *  @param msg        提示
 *  @param leftBlock  回调
 */
-(void)show:(NSString *)title msg:(NSString *)msg  leftBlock:(LeftBlock) leftBlock
{
    [self show:title ? title : @"提示"
           msg:msg
     leftTitle:@"确定"
     leftBlock:leftBlock
    rigthTitle:nil
    rightBlock:nil];
}



/**
 *  显示Alert 默认显示 取消,确定按钮
 *
 *  @param title      标题
 *  @param msg        提示
 *  @param rightBlock 右边按钮回调
 */
-(void)show:(NSString *)title msg:(NSString *)msg rightBlock:(RightBlock) rightBlock
{
    [self show:title ? title : @"提示"
           msg:msg
     leftTitle:@"取消"
     leftBlock:nil
    rigthTitle:@"确定"
    rightBlock:rightBlock];
}

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
-(void)show:(NSString *)title msg:(NSString *)msg
  leftTitle:(NSString *)leftTitle
  leftBlock:(LeftBlock) leftBlock
 rigthTitle:(NSString *)rigthTitle
 rightBlock:(RightBlock) rightBlock
{
    self.leftBlock = nil;
    self.leftBlock = [leftBlock copy];
    self.rightBlock = nil;
    self.rightBlock = [rightBlock copy];
    UIAlertView *alert = [self buildAlertVew:title msg:msg leftTitle:leftTitle rigthTitle:rigthTitle];
    [alert show];
    
}


-(UIAlertView *)buildAlertVew:(NSString *)title
                          msg:(NSString *)msg
                    leftTitle:(NSString *)leftTitle
                   rigthTitle:(NSString *)rigthTitle{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:leftTitle otherButtonTitles:rigthTitle, nil];
    return alert;
}


- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    
    switch (buttonIndex){
            
        case 0:
            if(self.leftBlock){
                self.leftBlock();
            }
//            self.leftBlock = nil;
            break;
        case 1:
            if(self.rightBlock){
                self.rightBlock();
            }else if(self.rightBlockWithText){
                NSString *text = [alertView textFieldAtIndex:0].text;
                self.rightBlockWithText(text);
            }
//            self.rightBlock = nil;
//            self.rightBlockWithText = nil;
            break;
    }
    self.leftBlock = nil;
    self.rightBlock = nil;
    self.rightBlockWithText = nil;
}

@end
