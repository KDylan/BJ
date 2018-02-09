//
//  EdgeGTWebViewController.m
//  gd_port
//
//  Created by UEdge on 2017/11/2.
//  Copyright © 2017年 UEdge. All rights reserved.
//

#import "EdgeGTWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "AppDelegate.h"

#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

@interface EdgeGTWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}


@property(nonatomic,weak)UIWebView *webView;
@property (nonatomic,strong) JSContext *jsContext;
@end

//static EdgeGTWebViewController *instance = nil;


@implementation EdgeGTWebViewController

//+ (EdgeGTWebViewController *)shareInstance
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [[EdgeGTWebViewController alloc] init];
//    });
//    return instance;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = EdgeStateBarColor;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;//即从导航栏的（0，64）处开始
    }
    
    //  添加webView
    [self addWebVIew];
   
    //  添加进度条
    [self initProgressLine];
    
    // 获取javascript上下文
    self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    [self changeJavascriptBackMethod: self.jsContext];

}

/**
 初始化进度条
 */
-(void)initProgressLine{
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
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
//    webView.backgroundColor = [UIColor orangeColor];
    self.webView = webView;
    
    webView.delegate = self;
    
    
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
    
    NSURL *url = [NSURL URLWithString:self.GT_Url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 请求网络
    [self.webView loadRequest:request];


}
#pragma mark --------------------wenviewDelagate---------------------

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
//    [self hideHud];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [[AlertViewHelper getInstance] show:@"加载失败" msg:nil leftTitle:@"取消" leftBlock:^{
        EdgeLog(@"取消");
        [self dismissViewControllerAnimated:YES completion:nil];
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

-(void)popSelf{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark - 返回按钮
-(void)changeJavascriptBackMethod:(JSContext *)context{
    NSString *jsString1 = @"function historyBack(){}";
    NSString *jsString2 = @"window.history.back=function(){historyBack();}";
    [context evaluateScript:jsString1];
    [context evaluateScript:jsString2];
    
    __weak __block typeof(self) weakSelf = self;
    context[@"historyBack"] = ^{
        [weakSelf performSelectorOnMainThread:@selector(popSelf) withObject:nil waitUntilDone:NO];
    };
}

#pragma mark --------------------生命周期---------------------

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view addSubview:_progressView];
 
}
//-(void)close{
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_progressView removeFromSuperview];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 delloc
 */
//-(void)dealloc{
//    NSLog(@"webView消除观察者");
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
