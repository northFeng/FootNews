//
//  WebUrlViewController.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/10.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "WebUrlViewController.h"

@interface WebUrlViewController ()<UIWebViewDelegate>

/** webView */
@property (nonatomic,strong) UIWebView *webView;

///系统等待视图
@property (nonatomic,strong) UIActivityIndicatorView *waitingView;

@end

@implementation WebUrlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建webView
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_webView];
    _webView.backgroundColor = [UIColor lightGrayColor];
    _webView.delegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:kURLString(_htmlUrl)];
    
    [_webView loadRequest:request];
    
    
    //创建等待视图
    //等待视图
    self.waitingView = [[UIActivityIndicatorView alloc] init];
    self.waitingView.hidesWhenStopped = YES;
    self.waitingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.waitingView.color = [UIColor blackColor];
    [self.view addSubview:self.waitingView];
    [self.view bringSubviewToFront:self.waitingView];
    [self.waitingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.and.height.mas_equalTo(50);
    }];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.waitingView startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.waitingView stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[MBProgressHUDTool sharedMBProgressHUDTool] showTextToastView:@"网络不给力" view:self.view];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
