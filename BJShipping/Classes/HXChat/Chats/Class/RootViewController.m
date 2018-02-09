
//
//  RootViewController.m
//  ChatDemo-UI3.0
//
//  Created by UEdge on 2017/10/27.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "RootViewController.h"
#import "MainViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    MainViewController *vc = [[MainViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
