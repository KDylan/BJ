//
//  EdgeRootViewController.m
//  BJShipping
//
//  Created by UEdge on 2017/10/17.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "EdgeRootViewController.h"
#import "EdgeHomeViewController.h"
#import "EdgeNavigationController.h"
@interface EdgeRootViewController ()

@end

@implementation EdgeRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    EdgeHomeViewController *homePageVC = [[EdgeHomeViewController alloc]init];
   
//    EdgeNavigationController *nav = [[EdgeNavigationController alloc]initWithRootViewController:homePageVC];
    

    [self presentViewController:homePageVC animated:YES completion:nil];
}
@end
