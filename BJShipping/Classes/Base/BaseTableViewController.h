//
//  BaseTableViewController.h
//  GHBusinessSv
//
//  Created by RockeyCai on 2016/10/27.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Color.h"
#import "Reachability.h"
#import "MBConstants.h"
#import "MBProgressHUD+MP.h"
//#import "MPTargetConfigMacros.h"
//#import "ImportHelper.h"

@protocol  BBBaseTableViewControllerDataSource<NSObject>

@optional
-(NSMutableAttributedString*)setTitle;
-(UIButton*)set_leftButton;
-(UIButton*)set_rightButton;
-(UIColor*)set_colorBackground;
-(CGFloat)set_navigationHeight;
-(UIView*)set_bottomView;
-(UIImage*)navBackgroundImage;
-(BOOL)hideNavigationBottomLine;
-(UIImage*)set_leftBarButtonItemWithImage;
-(UIImage*)set_rightBarButtonItemWithImage;
@end


@protocol BBBaseTableViewControllerDelegate <NSObject>

@optional
-(void)left_button_event:(UIButton*)sender;
-(void)right_button_event:(UIButton*)sender;
-(void)title_click_event:(UIView*)sender;
@end

@interface BaseTableViewController : UITableViewController<BBBaseTableViewControllerDataSource , BBBaseTableViewControllerDelegate>

-(void)changeNavigationBarTranslationY:(CGFloat)translationY;
-(void)set_Title:(NSMutableAttributedString *)title;
@end
