//
//  EdgeHomeViewController.m
//  BJShipping
//
//  Created by UEdge on 2017/10/17.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "EdgeHomeViewController.h"
#import "AppDelegate.h"

#import "EdgeOpenWebViewController.h"

#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "EdgeCollectionView.h"

#import "SDCycleScrollView.h"
#import "EdgeHomeTopView.h"

#import "EdgeNavigationController.h"
#import "EdgeLoginViewController.h"

#import "imageScrollServices.h"
#import "imageScrollModel.h"

#import "NewScrollModel.h"
#import "NewsScrollServices.h"
#import "ChatDemoHelper.h"
#import "SettingTableViewController.h"

#import "EdgeGTWebViewController.h"
static EdgeHomeViewController *instance = nil;

@interface EdgeHomeViewController ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource,SDCycleScrollViewDelegate,UIScrollViewDelegate>
/**scrollView滚动视图*/
@property(nonatomic,weak)UIScrollView *scrollView;

/*scroll上面的背景图*/
@property (weak, nonatomic) UIView *BGView;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;

/**轮播图*/
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;
/**滚动图片数据*/
@property(nonatomic,strong)NSMutableArray *flowImageMUArr;

/**新闻视图*/
@property(nonatomic,weak)SDCycleScrollView *titleCycleScrollView;
/**滚动新闻内容*/
@property(nonatomic,strong)NSMutableArray *newsTitleArrID;

/*顶部导航栏view*/
@property(nonatomic,strong)EdgeHomeTopView *topNavigateView;

/**下面12个按钮*/
@property(nonatomic,weak) EdgeCollectionView *funcView;

/**滚动图片模型*/
@property(nonatomic,strong)EdgeFlowViewModel *flowViewModel;

/**滚动新闻模型*/
@property(nonatomic,strong)EdgeScycleNewsModel *ScycleNewsModel;

/** 北江快报 */
@property (strong, nonatomic) IBOutlet UIView *NewstitleView;

/*下半部分的View*/
@property (weak, nonatomic) UIView *underFouncView;

@end

@implementation EdgeHomeViewController

+ (EdgeHomeViewController *)getInstance
{
    //        static dispatch_once_t onceToken;
    //        dispatch_once(&onceToken, ^{
    //
    //            instance = [[EdgeHomeViewController alloc] init];
    //        });
    //
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    instance = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.hidden = YES;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;//即scrollView原点从导航栏的（0，64）处开始
    }
    
    //  数据初始化
    [self dataInit];
    
    // 一些View的设置
    [self viewInit];
    
    //  监听消息状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasNewMessage) name:kHaveUnreadAtMessage object:nil];
    
    //发送有信消息广播[监听mainView是否关闭]
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentAction:) name:@"isOpenChatView" object:nil];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    EdgeLog(@"docDir = %@",docDir);
    
    
}
/**
 一些View的设置
 */
-(void)viewInit{
    
    //  添加背景View
    [self addScrollView];
    
    self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [_scrollView.mj_header beginRefreshing];
        //下拉刷新数据
        [self reloadHomeViewData];
        
    }];
}

/**
 数据初始化
 */
-(void)dataInit{
    
    //  请求滚动图片数据
    [self requestScrollImage];
    
    //  请求滚动x新闻数据
    [self requestScrollNews];
    
}


#pragma mark -----------------   自定义按钮方法  ----------------------

/**
 请求滚动新闻数据
 */
-(void)requestScrollNews{
    
    NewsScrollServices *Services = [[NewsScrollServices alloc]initWithNewsScrollServices];
    [Services startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if (request.responseString) {
            
            NewScrollModel *imageModel = [NewScrollModel mj_objectWithKeyValues:request.responseString];
            
            NSMutableArray *NewsMUArr = [NSMutableArray array];
            NSMutableArray *newsIDMuArr = [NSMutableArray array];
            
            for (EdgeScycleNewsModel *rowsModel in imageModel.rows) {
                
                self.ScycleNewsModel = rowsModel;
                
                [NewsMUArr addObject:rowsModel.nn_news_title];
                
                [newsIDMuArr addObject:[NSString stringWithFormat:@"%ld",(long)rowsModel.ID]];
                
            }
            self.newsTitleArrID = newsIDMuArr;
            
            self.titleCycleScrollView.titlesGroup = NewsMUArr;
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        EdgeLog(@"图片数据请求失败");
    }];
}

/**
 请求滚动图片数据
 */
-(void)requestScrollImage{
    
    imageScrollServices *Services = [[imageScrollServices alloc]initWithImageScrollServices];
    [Services startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if (request.responseString) {
            
            imageScrollModel *imageModel = [imageScrollModel mj_objectWithKeyValues:request.responseString];
            
            NSMutableArray *flowMUArr = [NSMutableArray array];
            
            for (EdgeFlowViewModel *rowsModel in imageModel.rows) {
                
                [flowMUArr addObject:rowsModel];
            }
            self.flowImageMUArr = flowMUArr;
            
            //  刷新滚动视图显示数据
            [self.pageFlowView reloadData];
            
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        EdgeLog(@"图片数据请求失败");
    }];
}


/**
 下拉加载更多
 */
-(void)reloadHomeViewData{
    
    //  数据初始化
    [self dataInit];
    
    [self.scrollView.mj_header endRefreshing];
    
}

#pragma mark--------------------  点击方法函数  ----------------------

/**
 点击leftBarButtonItem
 */
-(void)clickLeftAction{
    
    if (BBUserDefault.isLogin) {//  已经登录
        
        SettingTableViewController *SettingVC = [[SettingTableViewController alloc]init];
        
        EdgeNavigationController *nav = [[EdgeNavigationController alloc]initWithRootViewController:SettingVC];
        
        [self.navigationController presentViewController:nav animated:YES completion:nil];
        
    }else{//  没有登录
        EdgeLoginViewController *loginVC = [[EdgeLoginViewController alloc]init];
        
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}

/**
 点击小按钮item按钮事件
 
 */
-(void)clickUnderfuncView{
    
    __weak typeof(self) weakSelf = self;
    //item点击回调
    self.funcView.clickCellCb = ^(int index, EdgeCollectionModel *functionMenu) {
        
        EdgeLog(@"click indec = %d-%@-%@-%@-%d",index,functionMenu.buttonImageName,functionMenu.buttonLabel,functionMenu.url,functionMenu.isLogin);
        
        if (index==2) {//  调度信息
            //  打开环形聊天界面
            [self clickLogin_HX];
            
        }else{
            
            if (functionMenu.url) {
                
                [weakSelf openWebViewVCWithUrl:functionMenu.url];
                
            }else{
                
                [self showHint:@"正在建设中"];
                
            }
            
        }
    };
}

/**
 点击新闻标题滚动视图
 
 */
-(void)clickNewsTitleView{
    
    __weak typeof(self) weakSelf = self;
    
    //新闻滚动监听
    self.titleCycleScrollView.clickItemOperationBlock = ^(NSInteger index) {
        
        NSLog(@"ID = %@ index = %ld",self.newsTitleArrID[index],(long)index);
        
        NSString *url = [NSString stringWithFormat:@"%@/BjAppWeb/DemoPage/NewsDetails.html?newsId=%@",IPHelper.getDataURL,self.newsTitleArrID[index]];
        
        [weakSelf openWebViewVCWithUrl:url];
        
    };
}

/**
 通用访问webView方法
 
 @param url URL
 */
-(void)openWebViewVCWithUrl:(NSString *)url{
    EdgeLog(@"准备打开页面");
    EdgeOpenWebViewController *webVC = [[EdgeOpenWebViewController alloc]init];
    
    webVC.webUrl = url;
    
    //    [self.navigationController pushViewController:webVC animated:YES];
    [self presentViewController:webVC animated:YES completion:nil];
}

/**
 加载个推的webView
 
 @param webURL url
 */
-(void)showGTWebViewController:(NSString *)webURL{
    
    EdgeLog(@"根据消息显示要的页面");
    
    EdgeGTWebViewController *GTWebView = [[EdgeGTWebViewController alloc]init];
    
    GTWebView.GT_Url = webURL;
    
    [self presentViewController:GTWebView animated:YES completion:nil];
}

#pragma mark ---------------------  环信消息处理  ------------------

/**
 登录环信
 */
-(void)clickLogin_HX{
    
    
    if ( BBUserDefault.isLogin) {
        if (BBUserDefault.hxUserName.length>0&&BBUserDefault.hxPassword.length>0) {//  假如登录
            //  显示环信
            [self showCharView];
            
        }else{
            
            [self showHint:@"请先绑定船舶信息"];
            
        }
    }else{//未登录
        
        [self showHint:@"请先进行登录"];
    }
    
    
}

/**
 获取未读消息数量
 */
-(void)hasNewMessage{
    //    EdgeLog(@"====message新消息");
    //信消息数量
    NSInteger newMessageCount = [[ChatDemoHelper shareHelper].mainVC setupUnreadMessageCount];
    NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
    
    if ( [user objectForKey:@"isLogin"]) {
        
        NSLog(@"newMessageCount = %ld",(long)newMessageCount);
        
        // 消息数量设置角标
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:newMessageCount];
        
        //  设置消息数量显示
        self.funcView.messageCount = [NSString stringWithFormat:@"%ld",(long)newMessageCount];
        
    }else{
        
        //重置角标计数
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0]; // APP 清空角标
        //  设置消息数量显示
        self.funcView.messageCount = @"0";
    }
    
    [self.funcView reloadData];
}

/**
 打开环形聊天界面
 */
-(void)showCharView{
    
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
        EMError *error = [[EMClient sharedClient] loginWithUsername:BBUserDefault.hxUserName password:BBUserDefault.hxPassword];
        if (error) {
            // 重新登录环信
            [[AppDelegate shareInstance]reloginIn];
        }
    }
    
    if (!self.isPresnted) {//  假如没有弹出
        
        MainViewController *chatMainVC = [MainViewController shareInstance];
        
        EdgeNavigationController *nav = [[EdgeNavigationController alloc]initWithRootViewController:chatMainVC];
        
        [self.navigationController presentViewController: nav animated:YES completion:nil];
        
    }else{
        EdgeLog(@"mainvc为打开状态-----不弹出mainvc了");
    }
}

/**
 监听mainVC监听状态
 
 @param notification bool
 */
-(void)presentAction:(NSNotification *)notification{
    
    //    EdgeLog(@"开始监听页面");
    
    BOOL mainvcOpenSuccess = [notification.object boolValue];
    
    //  记录弹出状态
    self.isPresnted = mainvcOpenSuccess;
    
    //    EdgeLog(@"isPresnted = %d",self.isPresnted);
    if (self.isPresnted) {//  如果mainvc关闭状态
        
        EdgeLog(@"mainvc为关闭状态----打开mainVC");
        
    }else{
        EdgeLog(@"mainvc为打开状态-----关闭mainVC");
    }
    
    
}


#pragma mark --------------------  视图处理  ---------------------

/**
 添加滚动条
 */
-(void)addScrollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    
    self.scrollView = scrollView;
    
    scrollView.canCancelContentTouches = YES;
    scrollView.delaysContentTouches = NO;
    
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).mas_offset(UIEdgeInsetsMake(20, 0, 0, 0));
        make.width.equalTo(self.view.width);
    }];
    
    UIView *container = [[UIView alloc]init];
    
    self.BGView = container;
    
    container.backgroundColor = [UIColor clearColor];
    
    [scrollView addSubview:container];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
        
    }];
    
    //  添加背景图片
    [self addBackGroundImage];
    
    //  添加头部的view
    [self addNavigateTopView];
    
    //  添加下半部分view
    [self addFunctionCollectionView];
    
    
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.funcView.mas_bottom);
    }];
}
/**
 添加顶部导航栏
 */
-(void)addNavigateTopView{
    
    EdgeHomeTopView *topNavigateView = [[EdgeHomeTopView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, 44)];
    
    self.topNavigateView  = topNavigateView;
    
    [topNavigateView.leftBtn addTarget:self action:@selector(clickLeftAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.BGView addSubview:topNavigateView];
    
}

/**
 添加下面的功能CollectionView
 */
-(void)addFunctionCollectionView{
    
    __weak typeof (self) weakSelf = self;
    
    //  下半部分整体功能View
    UIView *underFouncView = [[UIView alloc]init];
    self.underFouncView = underFouncView;
    underFouncView.backgroundColor = [UIColor whiteColor];
    underFouncView.layer.masksToBounds = YES;
    underFouncView.layer.cornerRadius = 8.0;
    
    [self.BGView addSubview:underFouncView];
    
    [underFouncView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.pageFlowView.bottom).offset(15);
        make.left.equalTo(self.BGView);
        make.right.equalTo(self.BGView);
        make.height.equalTo(self.view).multipliedBy(0.60);
    }];
    
    //  文字轮播整个模块view[image+轮播]
    UIView *scrollTitleView = [[UIView alloc]init];
    
    scrollTitleView = self.NewstitleView;
    
    [underFouncView addSubview:scrollTitleView];
    
    [scrollTitleView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(underFouncView);
        make.right.equalTo(underFouncView);
        make.top.equalTo(underFouncView);
        make.height.equalTo(55);
    }];
    
    //      文字轮播图
    SDCycleScrollView *cycleScrollNews = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
    
    self.titleCycleScrollView = cycleScrollNews;
    cycleScrollNews.scrollDirection = UICollectionViewScrollDirectionVertical;
    cycleScrollNews.onlyDisplayText = YES;
    cycleScrollNews.autoScrollTimeInterval = 3.0;
    cycleScrollNews.titleLabelTextColor = [UIColor darkGrayColor];
    cycleScrollNews.titleLabelTextAlignment = NSTextAlignmentLeft;
    cycleScrollNews.titleLabelBackgroundColor = [UIColor whiteColor];
    cycleScrollNews.titleLabelTextFont = [UIFont systemFontOfSize:16.5];
    //  不支持手势滚动
    [cycleScrollNews disableScrollGesture];
    
    //  文字轮播view添加在北江动态view上面
    [scrollTitleView addSubview:cycleScrollNews];
    
    [cycleScrollNews makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BGView).offset(85);// 边距15+图片宽度
        make.right.equalTo(self.BGView).offset(-55);
        make.centerY.equalTo(scrollTitleView);
        make.height.equalTo(53);// 底部线条高度为1，居中所以减少2
    }];
    
    //  滚动监听
    cycleScrollNews.itemDidScrollOperationBlock= ^(NSInteger index) {
        
        //  设置滚动数量标题
        weakSelf.indexLabel.text = [NSString stringWithFormat:@"%ld/10",(long)index+1];
    };
    
    EdgeCollectionView *funcView = [[EdgeCollectionView alloc]init];
    self.funcView  =funcView;
    funcView.backgroundColor = [UIColor clearColor];
    [underFouncView addSubview:funcView];
    [funcView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollTitleView.bottom);
        make.left.equalTo(underFouncView);
        make.right.equalTo(underFouncView);
        make.bottom.equalTo(underFouncView);
    }];
    
    //  item点击回调
    [self clickUnderfuncView];
    
    //  点击新闻滚动回调
    [self clickNewsTitleView];
}

/**
 添加背景图片
 */
-(void)addBackGroundImage{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H*0.7)];
    
    imageView.image = [UIImage imageNamed:@"backImage"];
    
    [self.view insertSubview:imageView atIndex:0];
}

#pragma mark -----------------   NewPagedFlowView Delegate  -----------------

- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    
    return CGSizeMake(Screen_W - 60, Screen_H*0.25);
}

//  cell点击事件
- (void)didSelectCell:(PGIndexBannerSubiew *)subView withSubViewIndex:(NSInteger)subIndex {
    
    //    [self openWebViewVCWithUrl:subView.flowModel.Scroll_Url];
    
    EdgeLog(@"点击了%s第%ld张图",__func__,(long)subIndex + 1);
}

#pragma mark  -----------------  NewPagedFlowView Datasource   -----------------

- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
//    NSLog(@"self.flowImageMUArr.count; = %lu",(unsigned long)self.flowImageMUArr.count);
    return self.flowImageMUArr.count;
}

//  注册cell
- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 6.0;
        bannerView.layer.masksToBounds = YES;
    }
    
    bannerView.flowModel = self.flowImageMUArr[index];
    
    return bannerView;
}

#pragma mark --------------------   系统生命周期  ---------------------------

#pragma mark - view即将出现时
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //    [self.pageFlowView reloadData];
    
    [self.navigationController.navigationBar setHidden:YES];
    //  设置首页消息数据
    [self hasNewMessage];
}

#pragma mark - view即将消失时
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //    [self.pageFlowView stopTimer];
    
    //    [self.navigationController.navigationBar setHidden:NO];
    
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHaveUnreadAtMessage object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"isOpenChatView" object:nil];
}

#pragma mark --------------------懒加载-----------------------------

-(NewPagedFlowView *)pageFlowView{
    if (!_pageFlowView) {
        _pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 44, Screen_W, Screen_H*0.25)];
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        _pageFlowView.minimumPageAlpha = 0.1;
        _pageFlowView.isCarousel = YES;
        _pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
        _pageFlowView.isOpenAutoScroll = YES;
        //        [_pageFlowView reloadData];
        
        [self.BGView addSubview:_pageFlowView];
    }
    return _pageFlowView;
}

//-(NSMutableArray *)newsTitleArr{
//    if (!_newsTitleArr) {
//
//        _newsTitleArr = [[NSMutableArray alloc]init];
//
//        [_newsTitleArr addObject:@"从小到大最幸运的事就是遇见你了.茫茫人海中同年同月同日生的咱俩相遇在这所大学 这本身就是可遇不可求的缘分阿.纳米拉"];
//        [_newsTitleArr addObject:@"让我一直陪在你身边吧. 忐忑给你, 情书给你, 不眠的夜给你, 雪糕的第一口给你,"];
//        [_newsTitleArr addObject:@"一腔孤勇和余生60年全部都给你~"];
//
//    }
//    return _newsTitleArr;
//}
/*
 case 0:{
 //  查询船舶
 EdgeSearchShipViewController *vc = [[EdgeSearchShipViewController alloc]init];
 
 [self.navigationController pushViewController:vc animated:YES];
 }
 break;
 case 1:{
 //  我的船舶
 EdgeMyShipViewController *myShipVC = [EdgeMyShipViewController alloc];
 
 [self.navigationController pushViewController:myShipVC animated:YES];
 }
 break;
 case 2:{
 //  调度信息
 EdgeSchedInfoViewController *schedInfo = [EdgeSchedInfoViewController alloc];
 
 [self.navigationController pushViewController:schedInfo animated:YES];
 }
 break;
 case 3:{
 //            //  障碍信息
 //            EdgeWarnInfoViewController *warnInfo = [EdgeWarnInfoViewController alloc];
 //
 //            [self.navigationController pushViewController:warnInfo animated:YES];
 }
 break;
 default:
 break;
 
 
 */

///**
// 提供滚动视图数据
// */
//-(void)getSourceData{
//    
//    self.flowImageMUArr = [EdgeFlowViewModel getScrollImageMuArr];
//}

@end
