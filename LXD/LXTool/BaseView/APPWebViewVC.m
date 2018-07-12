//
//  APPWebViewVC.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/7.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "APPWebViewVC.h"

@interface APPWebViewVC ()<UIWebViewDelegate>

/** webView */
@property (nonatomic,strong) UIWebView *webView;

@end

@implementation APPWebViewVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createView];
    
    //[self.tableView.mj_header beginRefreshing];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:kURLString(_htmlUrl)];
    
    [_webView loadRequest:request];
    
}


#pragma mark - 设置导航条样式
///设置导航栏样式
- (void)setNaviBarState{
    
    
}

#pragma mark - 初始化界面基础数据
- (void)initData {
    
    
}


///创建视图
- (void)createView{
    
    //创建webView
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kTopNaviBarHeight, kScreenWidth, kScreenHeight - kTopNaviBarHeight)];
    [self.view addSubview:_webView];
    _webView.backgroundColor = [UIColor lightGrayColor];
    _webView.delegate = self;
    
    //创建基本视图
    [self createTableView];
    [self.tableView removeFromSuperview];

}



#pragma mark - 重写下面三个方法即可
///请求数据(对该方法进行重写便可请求字典的请求)
- (void)requestNetData{
    
}


///请求数据失败处理
- (void)requestNetDataFail{
    
    
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self startWaitingAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self stopWaitingAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self showMessage:@"网络不给力"];
}




@end
