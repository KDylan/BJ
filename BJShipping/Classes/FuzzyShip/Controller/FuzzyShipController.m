//
//  FuzzyShipController.m
//
//  描述：船只模糊搜索类模型类的UIViewController。(自动生成，代码模块1.0v)
//  Created by RockeyCai on 2016-12-26 12:06:34.
//  Copyright (c) 2016年 RockeyCai. All rights reserved.
//

#import "FuzzyShipController.h"
#import "FuzzyShipDao.h"
#import "FuzzyShipApi.h"
#import "UIViewController+HUD.h"
#import "FuzzyShip.h"
#import "BindFuzzyShipApi.h"
#import "FuzzyShipTableViewCell.h"
#import "FuzzyShipModel.h"
#import "MainViewController.h"
//#import "YYModel.h"
#import "ChatDemoHelper.h"
#import "AppDelegate.h"
#import "UIView+EaseBlankPage.h"
#import <GTSDK/GeTuiSdk.h>

#import "OnlineServer.h"

@interface FuzzyShipController ()<UISearchBarDelegate>

@end

@implementation FuzzyShipController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"船舶认证绑定";
    //初始化页面元素
    [self viewInit];
    //初始化数据
    [self dataInit];
}

/**
 *  初始化页面元素
 */
- (void)viewInit {
    self.tableView.tableFooterView = [[UIView alloc]init];
    //调用初始化searchController
    [self setSearchView];
    
}
/**
 *  初始化数据
 */
-(void)dataInit{
    
    self.fuzzyShipArray = [NSMutableArray new];
}


//初始化SearchController初始化

- (void)setSearchView{
    
    UISearchBar * searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    searchBar.placeholder = @"请输入船只名称";
    searchBar.showsCancelButton = YES;
    searchBar.delegate = self;
    //搜索栏表头视图
    self.tableView.tableHeaderView = searchBar;
    
}


/**
 网络加载数据
 
 @param name <#name description#>
 */
-(void)loadWebData:(NSString *)name{
    
    [self.tableView.blankPageView removeFromSuperview];
    
    [self showHudInView:self.view hint:@"查询中,请稍候..."];
    
    [self.fuzzyShipArray removeAllObjects];
    
    FuzzyShipApi *api = [[FuzzyShipApi alloc] initWithFuzzyShip:name];
    
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSString *json = request.responseString;
        
        if (json != nil && ![json isEqualToString:@"[]"]) {// 请求成功
            
            FuzzyShipModel *shipModel = [FuzzyShipModel mj_objectWithKeyValues:json];
            
            NSMutableArray *shipMuArr = [NSMutableArray array];
            
            for (FuzzyShip *model in shipModel.result) {
                
                [shipMuArr addObject:model];
            }
            self.fuzzyShipArray  = shipMuArr;
            
            if (self.fuzzyShipArray.count ==0) {
                //无数据展现
                [self.tableView configBlankPage:EaseBlankPageTypeNoButton hasData:self.fuzzyShipArray.count hasError:(NO) reloadButtonBlock:^(id sender) {
                }];
            }
            
        }else{
            
            [self showHint:@"查询出现未知错误"];
            
        }
        
        [self.tableView reloadData];
        
        [self hideHud];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self hideHud];
        
        [self.tableView reloadData];
        
        //增加无数据展现
        [self.tableView configBlankPage:EaseBlankPageTypeNoButton hasData:NO hasError:(YES) reloadButtonBlock:^(id sender) {
            //重新加载
            [self loadWebData:name];
        }];
    }];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fuzzyShipArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FuzzyShipTableViewCell *cell =  nil;
    static NSString *cellIdentifier = @"FuzzyShipTableViewCell";
    //自定义布局
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil] lastObject];
    }
    
    FuzzyShip *item = [self.fuzzyShipArray objectAtIndex:indexPath.row];
    
    [cell setData:item];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//Cell样式
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //        MPWeakSelf(self);
    __weak typeof(self) weakself = self;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    __block FuzzyShip *item = [self.fuzzyShipArray objectAtIndex:indexPath.row];
    //        绑定船只
    [[AlertViewHelper getInstance] show:@"提示" msg:[NSString stringWithFormat:@"确定要绑定【%@】吗？" , item.name] rightBlock:^{
        
        [weakself bindShip:item];
    }];
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text = nil;
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    //搜索船只
    [self loadWebData:searchBar.text];
}

/**
 b绑定船舶
 
 @param item sender
 */
-(void)bindShip:(FuzzyShip *)item{
    
    [self showHudInView:self.view hint:@"绑定中,请稍候..."];
    
    BindFuzzyShipApi *api = [[BindFuzzyShipApi alloc] initWithFuzzyShip:item];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self hideHud];
        
        NSString *json = request.responseString;
        if (json) {
            
            NSDictionary *dict =  [EdgeJsonHelper dictionaryWithJsonString:json];
            
            BOOL success = [dict objectForKey:@"success"];
            
            if (success) {
                //设置是否自动登录
                [[EMClient sharedClient].options setIsAutoLogin:YES];
                //保存环信账号
                BBUserDefault.hxUserName = dict[@"result"][@"username"];
                //保存绑定的船只数据
                BBUserDefault.ship = [item mj_JSONString];
                //登录环信
                [self loginHX];
                
                //绑定个推别名
                [[AppDelegate shareInstance]bindAlias];
                
                //调用回调
                self.bindOkCb();
                
                [self showHint:@"船舶绑定成功"];
                
                //启动心跳数据服务
                [[OnlineServer getSingleton] startOnline];
                
                [AsyncHelper after:2.0 onMainUI:^(id obj) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }];
                
            }else{
                
                NSString *errorMessage = dict[@"errorMessage"];
                
                [self showHint:errorMessage];
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



/**
 登录环信
 
 */
-(void)loginHX{
    
    [[ChatDemoHelper shareHelper] loginWithUsername:BBUserDefault.hxUserName password:@"123456"];
    
    BBUserDefault.hxPassword = @"123456";
    
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



@end
