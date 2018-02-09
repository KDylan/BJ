//
//  SettingFooterView.h
//  GHBusinessSv
//
//  Created by RockeyCai on 2016/11/10.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LogoutActionBlock)(id);


@interface SettingFooterView : UIView

@property (nonatomic,strong) LogoutActionBlock logoutActionBlock;


+(instancetype )instanceSettingFooterView:(LogoutActionBlock)logoutActionBlock;

@end
