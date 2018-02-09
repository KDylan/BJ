//
//  SettingTableViewController.m
//  GHBusinessSv
//  设置页面
//  Created by RockeyCai on 2016/11/10.
//  Copyright © 2016年 RockeyCai. All rights reserved.
//

#import "SettingTableViewController.h"
#import "SettingFooterView.h"
#import "SettingTableViewCell.h"
#import "AppDelegate.h"
#import "AlertViewHelper.h"
#import "FuzzyShip.h"
#import "FuzzyShipController.h"

#import <GTSDK/GeTuiSdk.h>
#import "EdgeHomeViewController.h"
#import "UserModel.h"
#import "UnBindFuzzyShipApi.h"

#import "OnlineServer.h"

static NSArray *tableViewGroupNames;
static NSArray *tableViewCellTitleInSection;

@interface SettingTableViewController ()

@property (retain , nonatomic) NSMutableArray *settingArry;

@property(nonatomic,strong) NSArray *tableViewDetailTitleInSection;
//  用户model
@property(nonatomic,strong) UserModel *userModel;

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    
    [self dataInit];
    
    [self viewInit];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem iteamWithImageNamed:@"back" hightLightImageName:@"back" target:self action:@selector(backMainVCAction)];
    
}


-(void)dataInit{
    
    tableViewGroupNames = @[
                            @"个人资料",
                            @"船舶数据",
                            @"版本信息"
                            ];
    
    tableViewCellTitleInSection = @[
                                    @[ @"账号", @"手机号", @"QQ", @"邮箱", @"角色类型" ],
                                    @[ @"船舶认证绑定", @"心跳数据", @"GPS辅助定位" ],
                                    @[ @"当前版本" ]
                                    ];
}

-(void)viewInit{
    //刷新数据监听 用于刷新在线数据，和gps数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlyReloadTable) name:@"onlyReloadTable4onlineOrGps" object:nil];
    //  退出登录操作
    [self login_outAction];
}

/**
 退出登录操作
 */
-(void)login_outAction{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, 80)];
   
    self.tableView.tableFooterView  = footView;
    
    SettingFooterView *LogOutView = [SettingFooterView instanceSettingFooterView:^(id logpoutAction) {
        [[AlertViewHelper getInstance] show:nil msg:@"您确定要退出登录吗？" rightBlock:^{
            
            [self clickLogoutActionBtn];
        }];
        
    }];
    
    [self.tableView.tableFooterView addSubview:LogOutView];
    
    LogOutView.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    
}

-(void)clickLogoutActionBtn{
    //清除用户数据
    [UserModel cleanUserModel];
   
    [self dismissViewControllerAnimated:YES completion:nil];
    //  清除消息数量
    [[EdgeHomeViewController getInstance] hasNewMessage];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0]; // APP 清空角标
    
    // 取消绑定别名
    [GeTuiSdk unbindAlias:self.userModel.vf_user_code andSequenceNum:[NSString stringWithFormat:@"%@",@""] andIsSelf:YES];
    
    [GeTuiSdk resetBadge]; //重置角标计数
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return tableViewGroupNames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return [[tableViewCellTitleInSection objectAtIndex:section] count];
}


#pragma mark TableView 代理设置


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellId = [NSString stringWithFormat:@"cellId-%ld-%ld", (long)indexPath.section, (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = [self cellTitleForIndexPath:indexPath];
    cell.detailTextLabel.text =  [self cellDetailTitleForIndexPath:indexPath];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    if (indexPath.section==1) {
        
        switch (indexPath.row) {
            case 0: //  船舶绑定
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//Cell样式
                
                if (indexPath.section==1&&indexPath.row==0&&BBUserDefault.ship) {//  绑定后设置绑定船名
                    
                    cell.detailTextLabel.text = [FuzzyShip getShipInfo].name;
                    cell.detailTextLabel.textColor = [UIColor blueColor];
                }
            }
                break;
            case 1: //  心跳次数
            {
                cell.detailTextLabel.text =  [NSString stringWithFormat:@"%d次" , BBUserDefault.onlineNum];
                cell.detailTextLabel.textColor = [UIColor blueColor];
            }
                break;
            case 2://  GPS定位次数
            {
                cell.detailTextLabel.text =  [NSString stringWithFormat:@"%d次" , BBUserDefault.gpsNum];
                cell.detailTextLabel.textColor = [UIColor blueColor];
            }
                break;
                
            default:
                EdgeLog(@"cell不存在");
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakself = self;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellTitle = [self cellTitleForIndexPath:indexPath];
    
    if ([cellTitle isEqualToString:@"船舶认证绑定"]) {
        
        if (BBUserDefault.ship) {//  判断是否已经绑定船舶
            //退出登录 解绑船只
            __block FuzzyShip *ship = [FuzzyShip mj_objectWithKeyValues:BBUserDefault.ship];
            
            [[AlertViewHelper getInstance] show:@"提示" msg:[NSString stringWithFormat:@"确定要解绑【%@】吗？" , ship.name] rightBlock:^{
                
                [weakself unbindShip:ship];
            }];
            
        }else{
        
            FuzzyShipController *FuzzyShipVC = [[FuzzyShipController alloc]init];

            //绑定成功回调
            FuzzyShipVC.bindOkCb = ^{
                //刷新数据
                [weakself reloadTable];
            };

            [self.navigationController pushViewController:FuzzyShipVC animated:YES];
        }
        
    }
    
}


/* Section Header Title */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return tableViewGroupNames[section];
}
//  cell 的text
- (NSString *)cellTitleForIndexPath:(NSIndexPath *)indexPath {
    return [[tableViewCellTitleInSection objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}
//  cell的detailText
- (NSString *)cellDetailTitleForIndexPath:(NSIndexPath *)indexPath {
    return [[self.tableViewDetailTitleInSection objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 35.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 2) {
        
        return 80;
    }
    return 0.0;
}

/**
 解绑船只
 
 @param ship <#ship description#>
 */
-(void)unbindShip:(FuzzyShip *)ship{
    
    [self showHudInView:self.view hint:@"解绑中,请稍候..."];
    
    UnBindFuzzyShipApi *api = [[UnBindFuzzyShipApi alloc] initWithFuzzyShip:ship];
    
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self hideHud];
        
        NSString *json = request.responseString;
        if (json) {
            
            NSDictionary *dic = [EdgeJsonHelper dictionaryWithJsonString:json];
            
            BOOL success = [dic objectForKey:@"success"];
            
            if (success) {
                
                //设置是否自动登录
                [[EMClient sharedClient].options setIsAutoLogin:NO];
                
                EMError *error = [[EMClient sharedClient] logout:YES];
            
                if (!error) {
                    EdgeLog(@"环信退出成功");
                }
                //解绑个推别名
                [[AppDelegate shareInstance] unBindAlias];
                
                //清除环信账号
                BBUserDefault.hxUserName = nil;
                BBUserDefault.hxPassword = nil;
                //保存绑定的船只数据
                BBUserDefault.ship = nil;
                BBUserDefault.onlineNum = 0;
                BBUserDefault.gpsNum = 0;
                
                //停止心跳数据服务
                [[OnlineServer getSingleton] stopOnline];
                
                //刷新数据
                [self reloadTable];
                
                //发送广播，更新船名信息
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
                
            }else{
                
                NSString *message = [dic objectForKey:@"message"] ;
                [self showHint:message];

            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
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

-(void)reloadTable{
    
    [self.tableView reloadData];
    
}

-(void)onlyReloadTable{
   
    [self.tableView reloadData];
}


/**
 *  获取app app版本
 *
 *  @return sender
 */
-(NSString *)getAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    return appVersion ;
}


/**
 dismiss 方法
 */
-(void)backMainVCAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(NSArray *)tableViewDetailTitleInSection{
    if (!_tableViewDetailTitleInSection) {
        
        UserModel *userModel = [UserModel getUserModel];
        self.userModel = userModel;
        _tableViewDetailTitleInSection = @[
                                           @[userModel.vf_user_code,userModel.vf_phone,userModel.vf_qq, userModel.vf_mail,userModel.vf_user_type],
                                           @[ @"未绑定", @"0次", @"0次" ],
                                           @[ [self getAppVersion] ]
                                           ];
    }
    return _tableViewDetailTitleInSection;
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //umeng跟踪page 以本项目的VC页面才进入友盟统计
    //    [MPUmengHelper beginLogPageView:[self class]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //umeng跟踪page 以开头本项目的VC页面才进入友盟统计
    //    [MPUmengHelper endLogPageView:[self class]];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
