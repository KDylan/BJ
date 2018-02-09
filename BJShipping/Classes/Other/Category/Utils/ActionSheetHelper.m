//
//  ActionSheetHelper.m
//  iPhoto
//  UIActionSheet帮助类
//  Created by RockeyCai on 16/4/27.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "ActionSheetHelper.h"

static ActionSheetHelper *instance = nil;

@interface ActionSheetHelper()<UIActionSheetDelegate>

@property (nonatomic,strong) CancelBlock cancelBlock;

@property (nonatomic,strong) OKBlock okBlock;

@property (nonatomic,strong) OtherBlock otherBlock;

@end

@implementation ActionSheetHelper

/**
 *  ActionSheetHelper 单例方法
 *
 *  @return ActionSheetHelper
 */
+ (ActionSheetHelper *)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ActionSheetHelper alloc] init];
    });
    
    return instance;
}

/**
 *  显示 UIActionSheet 默认显示确定，取消按钮
 *
 *  @param title       标题
 *  @param okBlock     确定回调
 *  @param view        承载父页面
 */
-(void)showTitle:(NSString *)title
         okBlock:(OKBlock)okBlock
           view : (UIView*)view
{
    
    [self showTitle:title
  cancelButtonTitle:@"取消"
        cancelBlock:nil
      okButtonTitle:@"确定"
            okBlock:okBlock
               view:view];
}



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
            view:(UIView*)view
{
    self.okBlock = okBlock;
    
    [self showTitle:title
  cancelButtonTitle:cancleTitle
        cancelBlock:cancelBlock
  otherButtonTitles:@[okTitle]
         otherBlock:nil
               view:view];
}

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
            view:(UIView *)view
{
    
    [self showTitle:title
  cancelButtonTitle:@"取消"
        cancelBlock:nil
  otherButtonTitles:otherButtonTitles
         otherBlock:otherBlock
               view:view];
}


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
            view:(UIView *)view
{
    self.cancelBlock = cancelBlock;
    
    self.otherBlock = otherBlock;
    
    // 创建时不指定按钮
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title
                                                       delegate:self
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:nil];
    // 逐个添加按钮（比如可以是数组循环）
    for (NSString *oTitle in otherButtonTitles) {
        [sheet addButtonWithTitle:oTitle];
    }
    // 同时添加一个取消按钮
    [sheet addButtonWithTitle:cancelTitle];
    // 将取消按钮的index设置成我们刚添加的那个按钮，这样在delegate中就可以知道是那个按钮
    sheet.cancelButtonIndex = sheet.numberOfButtons-1;
    //[sheet showFromRect:view.bounds inView:view animated:YES];
    [sheet showInView:view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //取消
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        if (self.cancelBlock) {
            self.cancelBlock();
            
            self.otherBlock = nil;
            self.okBlock = nil;
            self.cancelBlock = nil;
        }
        return;
    }
    
    if (self.otherBlock) {
        self.otherBlock(buttonIndex);
        
        self.otherBlock = nil;
        self.okBlock = nil;
        self.cancelBlock = nil;
        return;
    }
    
    if (self.okBlock) {
        self.okBlock();
        
        self.otherBlock = nil;
        self.okBlock = nil;
        self.cancelBlock = nil;
        return;
    }
}



@end
