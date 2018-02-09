//
//  SettingFooterView.m
//  GHBusinessSv
//
//  Created by RockeyCai on 2016/11/10.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "SettingFooterView.h"

@interface  SettingFooterView()

@property (weak, nonatomic) IBOutlet UIButton *logoutBut;


@end

@implementation SettingFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)instanceSettingFooterView:(LogoutActionBlock)logoutActionBlock
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SettingFooterView" owner:nil options:nil];
    SettingFooterView *footView = [nibView objectAtIndex:0];
    footView.logoutActionBlock = logoutActionBlock;
//    [footView viewInit];
    return footView;
}



-(void)viewInit{

    //设置按钮圆角样式
    self.logoutBut.layer.cornerRadius = 5;
    [self.logoutBut.layer setMasksToBounds:YES];
    
    [self setBackgroundColor:[UIColor clearColor]];
}


- (IBAction)logoutAction:(id)sender {
    if (self.logoutActionBlock) {
        self.logoutActionBlock(sender);
        //self.logoutActionBlock = nil;
    }
}



@end
