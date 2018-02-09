//
//  EdgeNavigationController.m
//  BJShipping
//
//  Created by UEdge on 2017/10/18.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "EdgeNavigationController.h"

@interface EdgeNavigationController ()

@end

@implementation EdgeNavigationController

//  当第一次来到这个类进行调用（做类初始化最好）
+(void)initialize{
    //  设置全局导航栏图片
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];//  选择哪一个类进行设置
    [bar setBackgroundImage:[UIImage imageNamed:@"navImage_Plus"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 如果滑动移除控制器的功能失效，清空代理（让导航控制器重新设置这个功能）
    self.interactivePopGestureRecognizer.delegate = nil;
  
    //  修改主题
    [self navigationBarThemeInit];
    
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //  设置判断
    if (self.childViewControllers.count > 0) {
        
        //  隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//          [btn setBackgroundColor:[UIColor redColor]];
        btn.size = CGSizeMake(15,21);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        //  内容靠左显示
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //  设置内边距
        [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        
        [ btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [ btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
//        [btn setTitle:@"返回" forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(backToView) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
     [super pushViewController:viewController animated:animated];

}

-(void)backToView{
    
    [self popViewControllerAnimated:YES];
}

/**
 *  修改主题
 */
-(void)navigationBarThemeInit
{
    /** **/
    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
//    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:2 forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:-1 forBarMetrics:UIBarMetricsDefaultPrompt];

//    //隐藏back标题
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
//    
//
//        //  设置背景图片
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navImage_Plus"] forBarMetrics:UIBarMetricsDefault];
    
   
}


@end
