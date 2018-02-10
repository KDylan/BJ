//
//  EdgeLoginViewController.m
//  gd_port
//
//  Created by UEdge on 2017/10/26.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "EdgeLoginViewController.h"
#import <IQKeyboardReturnKeyHandler.h>

#import "EdgeLoginServices.h"
#import "EdgeHomeViewController.h"

#import "ChatDemoHelper.h"
#import <GTSDK/GeTuiSdk.h>

@interface EdgeLoginViewController ()<UITextFieldDelegate>{
    
    IQKeyboardReturnKeyHandler *returnKeyHandler;
}
/**账号*/
@property (weak, nonatomic) IBOutlet UITextField *userName;
/*密码*/
@property (weak, nonatomic) IBOutlet UITextField *userPassward;

/**登录按钮*/
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

static EdgeLoginViewController *instance = nil;


@implementation EdgeLoginViewController

+ (EdgeLoginViewController *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[EdgeLoginViewController alloc] init];
    });
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  设置stateBar为白色的字体
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.title = @"用户中心";
    
    //  设置一些控件属性
    [self viewInit];
    
    
}

#pragma mark----------------  点击按钮方法  ----------------------
/**
 当文本内容改变时调用
 */
-(void)textChange
{
    //当账号与密码同时有值,登录按钮才能够点击
    self.loginBtn.enabled = self.userName.text.length && self.userPassward.text.length;
}

/**
 点击登录按钮
 
 @param sender action
 */
- (IBAction)loginAction:(id)sender {
    
    [self showHudInView:self.view hint:@"登录中，请稍后..."];
    
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    
    EdgeLoginServices *loginService = [[EdgeLoginServices alloc] initWithLoginCode:self.userName.text loginPwd:self.userPassward.text];
    
    [loginService startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self hideHud];
        
        if (request.responseString) {
            
            //  登录成功
            NSDictionary *dict = [EdgeJsonHelper dictionaryWithJsonString:request.responseString];
            
            UserModel *Model = [UserModel mj_objectWithKeyValues:dict[@"result"]];
            
            BOOL success = dict[@"success"];
            
            if (success) {
                
                //  储存用用户密码
                [self saveToSandBox];
                //保存用户信息
                [Model saveUserModel];
                
                EdgeLog(@"Login_sucess%@----chat id = %@-userid = %ld type = %@" , Model.vf_user_code,Model.vf_user_password,(long)Model.ID,Model.vf_user_type);
                
                [self showHint:@"账户登录成功"];
                
                //  刷新首页
                [[EdgeHomeViewController getInstance]reloadFuncView];
                
                [AsyncHelper after:1.0 onMainUI:^(id obj) {
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                }];
                
            }else{//  解析失败
                
                NSString *errorMessage = dict[@"errorMessage"];
                
                [self showHint:errorMessage];
            }
        }
    }failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self hideHud];
        
        //  登录成功
        NSDictionary *dict = [EdgeJsonHelper dictionaryWithJsonString:request.responseString];
        
        if (dict) {
            
            NSString *errorMessage = dict[@"errorMessage"];
            
            [self showHint:errorMessage];
            
        }else{
            [self showHint:@"网络错误，请检查网络设置"];
        }
        
        
    }];
}


/**
 忘记密码
 
 @param sender sender
 */
- (IBAction)forgetPassword:(id)sender {
    
    EdgeLog(@"点击忘记密码");
}

/**
 创建账户
 
 @param sender sender
 */
- (IBAction)creatAccount:(id)sender {
    EdgeLog(@"点击创建账户");
}


- (IBAction)closeAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark----------------  自定义函数  ----------------------



/**
 设置一些布局
 */
-(void)viewInit{
    //  添加监听
    [self.userName addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.userPassward addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    self.userName.delegate = self;
    self.userPassward.delegate = self;
}

/**
 数据储存到沙盒中
 */
-(void)saveToSandBox{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSDictionary * dic = @{@"UserCode":self.userName.text,@"Password":self.userPassward.text};
    
    [user setObject:dic forKey:@"loginDict"];
    
    BBUserDefault.isLogin = YES;
    
    [user synchronize];
}


#pragma mark---------------  生命周期  ----------------------

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //  设置键盘点击下一项可用
    returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //  获取本地之前登录数据
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dic = [user objectForKey:@"loginDict"];
    
    self.userName.text = dic[@"UserCode"];
    self.userPassward.text = dic[@"Password"];
    
    if (self.userName.text.length>0 && self.userPassward.text.length>0) {
        self.loginBtn.enabled = YES;
        
    }else{
        
        EdgeLog(@"第一次登录");
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self hideHud];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self hideHud];
}


@end
