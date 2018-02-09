//
//  EdgeHomeTopView.m
//  BJShipping
//
//  Created by UEdge on 2017/10/18.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "EdgeHomeTopView.h"

@implementation EdgeHomeTopView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    
    if (self) {
        // homeView上半部分标题栏
        [self loadTopView];
    }
    return self;
}


/**
  homeView上半部分标题栏
 */
-(void)loadTopView{
//    UIView *topView = [[UIView alloc]init];
//    topView.backgroundColor = [UIColor clearColor];
//    [self addSubview:topView];
//    
//    [topView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self);
//        make.right.equalTo(self);
//        make.top.equalTo(self);
//        make.height.equalTo(64);
//    }];
    
    UIButton *leftBtn = [[UIButton alloc]init];
    [leftBtn setImage:[UIImage imageNamed:@"user"] forState:UIControlStateNormal];
    self.leftBtn = leftBtn;
    [self addSubview:leftBtn];
    [leftBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.width.equalTo(40);
        make.top.equalTo(self);
        make.height.equalTo(40);
    }];
    
    
    UIButton *rightBtn = [[UIButton alloc]init];
    self.rightBtn = rightBtn;
    [rightBtn setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
    [self addSubview:rightBtn];
    [rightBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.width.equalTo(leftBtn);
        make.top.equalTo(leftBtn);
        make.height.equalTo(leftBtn);
    }];
    
    self.rightBtn.hidden = YES;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text  =@"北江航运服务";
    titleLabel.font = [UIFont boldSystemFontOfSize:21.0];
//    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftBtn.right).offset(10);
        make.right.equalTo(rightBtn.left).offset(-10);
        make.top.equalTo(leftBtn);
        make.bottom.equalTo(leftBtn);
    }];
    
}
@end
