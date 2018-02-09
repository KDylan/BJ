//
//  EdgeSearchShipViewController.m
//  BJShipping
//
//  Created by UEdge on 2017/10/19.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#define EdgeSearchHistoryKey @"SearchHistoryKey"

#import "EdgeSearchShipViewController.h"
#import "EdgeSearchResultViewController.h"
#import "EdgeSearchTableViewCell.h"
@interface EdgeSearchShipViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,EdgeSearchHistoryCellDeleagte>
/**tableHeadView*/
@property (strong, nonatomic) IBOutlet UIView *tableHeadView;
/**搜索条*/
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
/**tableView*/
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**是否有历史搜索记录*/
//@property (assign, nonatomic) BOOL isHistory;
/**搜索记录*/
@property (strong, nonatomic) NSMutableArray *historyArray;
/**没数据提示label*/
@property(nonatomic,weak)UILabel *nodaLabel;


@end

@implementation EdgeSearchShipViewController
- (NSMutableArray *)historyArray {
    if (!_historyArray) {
        _historyArray = [NSMutableArray array];
        // 将数据从沙盒提取
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *historyList = [defaults valueForKey:EdgeSearchHistoryKey];
        if ((historyList.count != 0) && (![historyList isKindOfClass:[NSNull class]])) {
            self.historyArray = [historyList mutableCopy];
        }
    }
    return _historyArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
      self.view.backgroundColor = EdgeGloupColor;
    //  添加searchBar
    [self addSearchBar];
    //  添加设置uitableView
    [self addUITableView];
    //  添加没数据提示
    [self NodeSearchHistory];
    
    NSString *patn =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"%@",patn);
}

#pragma mark--------------------添加布局-----------------------
/**
 添加searchBar
 */
-(void)addSearchBar{
    
    UIView *searchView = [[UIView alloc]init];
    searchView.frame = CGRectMake(50, 0, Screen_W-100, 30);
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = 5.0;
    searchView.backgroundColor = [UIColor clearColor];
    _searchBar.clipsToBounds = YES;
    _searchBar.delegate = self;
    [searchView addSubview:_searchBar];
    
    [_searchBar makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchView);
        make.right.equalTo(searchView);
        make.top.equalTo(searchView);
        make.bottom.equalTo(searchView);
    }];
    self.navigationItem.titleView = searchView;
}

/**
 添加设置uiTableView
 */
-(void)addUITableView{
    //  设置HeadView
    _tableView.tableHeaderView = _tableHeadView;
    _tableView.backgroundColor = EdgeGloupColor;
    //  消除多余分割线
    _tableView.tableFooterView = [[UIView alloc]init];
//    _tableView.tableFooterView.backgroundColor = [UIColor redColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

/**
 没有搜索历史
 */
-(void)NodeSearchHistory{
    
    UILabel *nodaLabel = [[UILabel alloc]init];
    self.nodaLabel = nodaLabel;
    nodaLabel.text = @"没有搜索记录";
    nodaLabel.textColor = [UIColor grayColor];
//    nodaLabel.backgroundColor = [UIColor redColor];
    nodaLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nodaLabel];
    
    [nodaLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(200);
        make.height.equalTo(200);
        make.top.equalTo(self.view).offset(100);
    }];
    
    // tableHeadView 隐藏
    [_tableView.tableHeaderView setHidden:YES];
}
#pragma mark--------------------按钮点击事件-----------------------

/**
 删除搜索搜索历史
 */
-(void)clearAllSearchHistory{

    [self.historyArray removeAllObjects];
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.historyArray forKey:EdgeSearchHistoryKey];
    
    [defaults synchronize];
    
    [_tableView reloadData];
}


/**
 搜索结果
 
 @param text text
 */
- (void)serachResultWithKeyWord:(NSString *)text {
    if ([text isEqualToString:@""]) {
        return;
    }
    [self.historyArray insertObject:text atIndex:0];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.historyArray forKey:EdgeSearchHistoryKey];
    [defaults synchronize];
    [_tableView reloadData];
    
    //  搜索跳转搜搜结果页面
    EdgeSearchResultViewController *resultVC = [[EdgeSearchResultViewController alloc] init];
    resultVC.title = text;
    [self.navigationController pushViewController:resultVC animated:YES];
}


#pragma mark --------------- UITableViewdelegate--------------------


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return self.historyArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.historyArray.count == 0) {
      
        return [[UITableViewCell alloc] init];
        
    }else{
        
        EdgeSearchTableViewCell *cell = [EdgeSearchTableViewCell searchHistoryCellWithTableView:tableView indexPath:indexPath];
        cell.text = self.historyArray[indexPath.row];
        cell.delegate = self;
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
   
    if (self.historyArray.count>0) {
        
        [_tableView.tableHeaderView setHidden:NO];
        
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, 50)];
        
        // 添加清空搜索历史按钮
        UIButton *clearHisBtn = [[UIButton alloc]initWithFrame:CGRectMake(Screen_W/2-75, 50, 150, 50)];
        
        [clearHisBtn setTitle:@"清空历史搜索" forState:UIControlStateNormal];
        [clearHisBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        clearHisBtn.layer.borderWidth = 2.0;
        clearHisBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        clearHisBtn.layer.masksToBounds = YES;
        clearHisBtn.layer.cornerRadius = 6.0;
        clearHisBtn.backgroundColor = [UIColor whiteColor];
        [clearHisBtn addTarget:self action:@selector(clearAllSearchHistory) forControlEvents:UIControlEventTouchUpInside];
        
        [footView addSubview:clearHisBtn];
        
        return footView;
        
    }else{
        
        [_tableView.tableHeaderView setHidden:YES];
        
          return nil;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.historyArray.count>0) {
        // 隐藏没数数据提示
        [self.nodaLabel setHidden:YES];
        
        [_tableView.tableHeaderView setHidden:NO];
        
        return 100;
    }else{
        
        [self.nodaLabel setHidden:NO];
        
        [_tableView.tableHeaderView setHidden:YES];
        
        return 0;
    }
}

#pragma mark - UISerachBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
    [self serachResultWithKeyWord:searchBar.text];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"%@",searchText);
}

#pragma mark -  KFSearchHistoryCellDeleagte

/**
 点击删除按钮

 @param cell 删除历史
 */
- (void)onDelSearchHistoryRecord:(EdgeSearchTableViewCell *)cell {
    NSIndexPath *indexPath = cell.indexPath;
    [self.historyArray removeObjectAtIndex:indexPath.row];
    if (self.historyArray.count != 0) {
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.historyArray forKey:EdgeSearchHistoryKey];
    [defaults synchronize];
    [_tableView reloadData];
}


/**
 点击搜索历史跳转

 @param cell cell
 */
- (void)searchHistoryCellOnTap:(EdgeSearchTableViewCell *)cell {
    EdgeSearchResultViewController *vc = [[EdgeSearchResultViewController alloc] init];
    vc.title = self.historyArray[cell.indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ----------------------分割线顶格显示------------------------

//分割线顶格显示
-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
//分割线顶格显示
-(void)tableView:(UITableView* )tableView willDisplayCell:(UITableViewCell* )cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}


#pragma mark - view即将出现时  -----------------
-(void)viewWillAppear:(BOOL)animated {
  
    [super viewWillAppear:animated];
    //  清空搜索框
   _searchBar.text = @"";
  
}

@end
