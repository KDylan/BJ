//
//  EdgeOpenWebViewController.m
//  gd_port
//
//  Created by UEdge on 2017/11/21.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "EdgeOpenWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import <WebViewJavascriptBridge.h>
#import "AppDelegate.h"
@interface EdgeOpenWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@property (nonatomic) WebViewJavascriptBridge* bridge;

@property(nonatomic,weak)UIWebView *webView;

@property (nonatomic,strong) JSContext *jsContext;
@end

@implementation EdgeOpenWebViewController

-(WebViewJavascriptBridge *)bridge{
    if (!_bridge) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
        [_bridge setWebViewDelegate:self];
    }
    return _bridge;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//     self.webUrl = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
//     NSURL *urlTemp = [NSURL fileURLWithPath:htmlPath];
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;//即从导航栏的（0，64）处开始
    }
    
     EdgeLog(@"webView = %@",_webUrl);
    
    self.view.backgroundColor = EdgeStateBarColor;
    //  添加webView
    [self addWebVIew];
  
    //  添加进度条
    [self initProgressLine];
    //  传递数据
    [self htmiL_Bridge_Object];

}


/**
 初始化进度条
 */
-(void)initProgressLine{
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    
     _progressProxy.webViewProxyDelegate = self.bridge;//  将代理交给桥接，然后进度条遵循桥接代理；这样代理就不冲突了
    
    _webView.delegate = _progressProxy;
//    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 3.0f;
    CGRect barFrame = CGRectMake(0, 20, Screen_W, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

/**
 添加webView
 */
-(void)addWebVIew{
    //  添加webView
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 23.0, Screen_W, Screen_H-23.0)];

    self.webView = webView;
    
    webView.delegate = self;
    // 去除底部黑条
    webView.opaque = NO;
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.bounces = NO;//  禁止下拉拖动
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    //  隐藏垂直指示条
    webView.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:webView];
    
    // 请求网络数据
    [self loadRequest];
}


/**
 加载网络请求
 */
-(void)loadRequest{
    
    NSURL *url = [NSURL URLWithString:self.webUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 请求网络
    [self.webView loadRequest:request];
    
    
}
#pragma mark --------------------wenviewDelagate---------------------

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    // 获取javascript上下文
    self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    EdgeLog(@"加载完成");
    [self changeJavascriptBackMethod: self.jsContext];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [[AlertViewHelper getInstance] show:@"加载失败" msg:nil leftTitle:@"取消" leftBlock:^{
        EdgeLog(@"取消");
        //  返回上一层
        [self popLastController];
        
        } rigthTitle:@"重新加载" rightBlock:^{
        
        EdgeLog(@"重新加载");
        
        // 重新请求
        [self loadRequest];
    }];
    
}


#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}


#pragma mark --------------------js交互---------------------
/**
 将登录信息给web页面------OC传数据给js[js 调用OC]
 */
-(void)htmiL_Bridge_Object{
    
    [self.bridge registerHandler:@"mpTestObjcCallBack" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        EdgeLog(@"datda = %@",data);
        
        if (data) {
            //获取行为
            NSString *action = [data valueForKey:@"action"];
          
            if([action isEqualToString:@"getLocalUserJson"]){//  将OC数据传给js方法
                
                NSString *json = BBUserDefault.userModelJSON;
                
                //获取用户信息
                responseCallback(json);
           
            }else if([action isEqualToString:@"closeActivity"]){//  返回上一个页面[返回主页面方法]
            
              [self dismissViewControllerAnimated:YES completion:nil];
            
            }else if([action isEqualToString:@"closeAndQuitHX"]){

                                   [AsyncHelper after:2.0 onMainUI:^(id obj) {// 2.0后返回
                       
                         [self dismissViewControllerAnimated:YES completion:nil];
                    }];


            }
        }
    }];
    
}



-(void)popLastController{
    
    
    if (self.webView.canGoBack) {
        
        [self.webView goBack];
        
    }else{
        EdgeLog(@"退出webView");
        
       [self dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark - 返回按钮
-(void)changeJavascriptBackMethod:(JSContext *)context{
    NSString *jsString1 = @"function historyBack(){}";
    NSString *jsString2 = @"window.history.back=function(){historyBack();}";
     NSString *jsString3 = @"javascript:history.back()}";
  
    [context evaluateScript:jsString1];
    [context evaluateScript:jsString2];
    [context evaluateScript:jsString3];
    
    __weak __block typeof(self) weakSelf = self;
    context[@"historyBack"] = ^{
        
        [weakSelf performSelectorOnMainThread:@selector(popLastController) withObject:nil waitUntilDone:NO];
        
    };
}


#pragma mark --------------------生命周期---------------------

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view addSubview:_progressView];

    //umeng跟踪page 以本项目的VC页面才进入友盟统计
    [MPUmengHelper beginLogPageView:[self class]];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_progressView removeFromSuperview];
    
    //umeng跟踪page 以开头本项目的VC页面才进入友盟统计
    [MPUmengHelper endLogPageView:[self class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
