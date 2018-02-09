/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */
//
//  EMNavigationController.m
//  ChatDemo-UI2.0
//
//  Created by dhcdht on 14-6-4.
//  Copyright (c) 2014年 dhcdht. All rights reserved.
//

#import "EMNavigationController.h"

@interface EMNavigationController ()

@end

@implementation EMNavigationController
//  当第一次来到这个类进行调用（做类初始化最好）
+(void)initialize{
    //  设置全局导航栏颜色
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    
    bar.barTintColor = [UIColor colorWithRed:57.0/255.0 green:133.0/255.0 blue:255.0/255.0 alpha:1.0];
}
- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self navigationBarThemeInit];
  
}


-(void)navigationBarThemeInit
{

    UIView *statusBarView = [[UIView alloc]   initWithFrame:CGRectMake(0, -20,self.view.bounds.size.width, 20)];
    
    statusBarView.backgroundColor = EdgeStateBarColor;
    
    [self.navigationBar addSubview:statusBarView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}
@end
