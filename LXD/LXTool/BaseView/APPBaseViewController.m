//
//  APPBaseViewController.m
//  GFAPP
//
//  Created by XinKun on 2017/11/16.
//  Copyright © 2017年 North_feng. All rights reserved.
//

#import "APPBaseViewController.h"
#import "AppDelegate.h"//代理

//振动模式
//#import <AudioToolbox/AudioToolbox.h>
//AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

@interface APPBaseViewController ()

@end

@implementation APPBaseViewController
{
    UIStatusBarStyle _statusStyle;
    BOOL _statusIsHide;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //...配置
    }
    return self;
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//tabBar的控制页面 在 点方法中设置标题
- (void)setNaviBarTitle:(NSString *)naviBarTitle{
    
    _naviBarTitle = naviBarTitle;
    self.naviBar.title = _naviBarTitle;
}

#pragma mark - 创建视图&&初始化数据
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /** 设置视图不自动压低tableview
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
     */
    
    //统一视图背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置状态栏状态数据初始状态(默认为黑色，不隐藏)
    _statusStyle = UIStatusBarStyleDefault;
    _statusIsHide = NO;
    
    //初始化一些数据
    self.page = 0;
    self.arrayDataList = [NSMutableArray array];//分页请求存储数据数组
    
    //创建导航条
    self.naviBar = [[GFNavigationBarView alloc] init];
    self.naviBar.title = self.naviBarTitle;
    self.naviBar.delegate = self;
    [self.view addSubview:self.naviBar];
    //导航条约束
    [self.naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.top.equalTo(self.view);
        make.height.mas_equalTo(APP_NaviBarHeight);
    }];
    
    //统一设置导航条样式
    if (self.navigationController.viewControllers.count > 1) {
        [self.naviBar setLeftBtnWhiteBtn];
    }
    //自定义导航条样式
    [self setNaviBarState];
    //统一设置状态栏为白色
    [self setStatusBarStyleLight];
    
    //请求数据
    [self initData];
    
    //创建界面  自己在子视图中自己定义加载位置
//    [self createTableView];
//    [self createView];
}

///设置导航栏样式
- (void)setNaviBarState{
    
    
}

#pragma mark - 初始化界面基础数据
- (void)initData {
    
    
}

///创建tableView
- (void)createTableView{
    
    //创建tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_NaviBarHeight, kScreenWidth, kScreenHeight-APP_NaviBarHeight) style:UITableViewStyleGrouped];
    //背景颜色
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
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

///添加上拉刷新，下拉加载功能
- (void)addTableViewRefreshView{
    __weak typeof(self) weakSelf = self;

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf requestNetData];
    }];

    //MJRefreshAutoNormalFooter  MJRefreshAutoFooter
    self.tableView.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf requestNetData];
    }];

    self.tableView.mj_footer.hidden = YES;
    
}


#pragma mark - Network Request  网络请求
- (void)requestNetData{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //可使用的
    [params setObject:[NSNumber numberWithInteger:self.page]  forKey:@"pageNo"];
    //一次拉取10条
    [params setObject:[NSNumber numberWithInt:10]  forKey:@"pageSize"];
    
    //[self requestDataWithUrl:@"url" params:params odelClass:[Class class]];
    
    //简版
    [self requestNetDataUrl:@"" params:params];
}


#pragma mark - 简版网络请求
//************************* 简版网络请求 *************************
///请求网络数据(分页请求)
- (void)requestNetDataUrl:(NSString *)url params:(NSDictionary *)params{

    __weak typeof(self) weakSelf = self;
    [self startWaitingAnimating];
    self.tableView.userInteractionEnabled = NO;
    
    [APPHttpTool getWithUrl:HTTPURL(url) params:params success:^(id response, NSInteger code) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        weakSelf.tableView.userInteractionEnabled = YES;
        ///隐藏加载动画
        [weakSelf stopWaitingAnimating];
        
        NSString *message = [response objectForKey:@"result_msg"];
        if (code == 0) {
            //请求成功
            //隐藏无网占位图
            
            [weakSelf requestNetDataSuccess:response[@"qry_infos"]];
        }else{
            weakSelf.page --;
            // 错误处理
            [weakSelf showMessage:message];
        }
        
    } fail:^(NSError *error) {
        
        weakSelf.page --;
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        weakSelf.tableView.userInteractionEnabled = YES;
        ///隐藏加载动画
        [weakSelf stopWaitingAnimating];
        
        if ([error.domain isEqualToString:@"NSURLErrorDomain"] && error.code == NSURLErrorNotConnectedToInternet) {
            [weakSelf showMessage:@"网络连接失败，请稍后再试"];
            
            //weakSelf.placeholderView.hidden = YES;
            if (weakSelf.arrayDataList.count > 0) {
                //隐藏无网占位图
                [weakSelf hidePromptView];
            }else{
                //显示无网占位图
                [weakSelf showPromptNonetView];
            }
        }else{
            [weakSelf showMessage:@"网络不给力... ..."];
        }
        
        [weakSelf requestNetDataFail];
        
    }];
    
}

///请求成功数据处理  (这个方法要重写！！！)
- (void)requestNetDataSuccess:(NSDictionary *)dicData{
    
    NSArray *arrayList = [dicData objectForKey:@"list"];
    
    
    if(dicData.count>0){
        
        if (self.page == 0) {
            //上拉刷新
            [self.arrayDataList removeAllObjects];
        }
        
        for (NSDictionary *itemModel in arrayList) {
            
            if (itemModel == nil || [itemModel isKindOfClass:[NSNull class]]) {
                
                continue;
            }
            //            CFDiscoverHomeModel *model = [[CFDiscoverHomeModel alloc] init];
            //            [model yy_modelSetWithDictionary:itemModel];
            
            //[self.arrayDataList addObject:model];
        }
        
        if (arrayList.count >= 10) {
            self.tableView.mj_footer.hidden = NO;
        }else{
            self.tableView.mj_footer.hidden = YES;
        }
        
    }else{
        self.tableView.mj_footer.hidden = YES;
    }
    
    ///数据为空展示无数据占位图
    if (self.arrayDataList.count == 0) {
        //数据为空展示占位图
        [self showPromptEmptyView];
    }else{
        [self hidePromptView];
    }
    //刷新数据&&处理页面
    [self.tableView reloadData];
}

///请求数据失败处理
- (void)requestNetDataFail{
    
    
}


///tableView请求一个字典
- (void)requestNetTableViewDicDataUrl:(NSString *)url params:(NSDictionary *)params{
    
    __weak typeof(self) weakSelf = self;
    [self startWaitingAnimating];
    self.tableView.userInteractionEnabled = NO;
    [APPHttpTool postWithUrl:HTTPURL(url) params:params success:^(id response, NSInteger code) {
        [weakSelf.tableView.mj_header endRefreshing];
        weakSelf.tableView.userInteractionEnabled = YES;
        ///隐藏加载动画
        [weakSelf stopWaitingAnimating];
        NSString *message = [response objectForKey:@"result_msg"];
        if (code == 0) {
            //请求成功
            //隐藏无网占位图
            
            [weakSelf requestNetDataSuccess:response[@"qry_infos"]];
        }else{
            // 错误处理
            [weakSelf showMessage:message];
        }
        
    } fail:^(NSError *error) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        weakSelf.tableView.userInteractionEnabled = YES;
        ///隐藏加载动画
        [weakSelf stopWaitingAnimating];
        
        if ([error.domain isEqualToString:@"NSURLErrorDomain"] && error.code == NSURLErrorNotConnectedToInternet) {
            [weakSelf showMessage:@"网络连接失败，请稍后再试"];
            //weakSelf.placeholderView.hidden = YES;
            //显示无网占位图
            [weakSelf showPromptNonetView];
        }else{
            [weakSelf showMessage:@"网络不给力... ..."];
        }
        
        [weakSelf requestNetDataFail];
        
    }];
}

///请求一个字典
- (void)requestNetDicDataUrl:(NSString *)url params:(NSDictionary *)params{
    
    __weak typeof(self) weakSelf = self;
    [self startWaitingAnimating];
    [APPHttpTool postWithUrl:HTTPURL(url) params:params success:^(id response, NSInteger code) {
        
        ///隐藏加载动画
        [weakSelf stopWaitingAnimating];
        
        NSString *message = [response objectForKey:@"message"];
        
        if ([message isEqualToString:@"操作成功"]) {
            //请求成功
            [weakSelf requestNetDataSuccess:response[@"data"]];
            
        }else{
            // 错误处理
            [weakSelf showMessage:message];
        }
        
    } fail:^(NSError *error) {
        ///隐藏加载动画
        [weakSelf stopWaitingAnimating];
        if ([error.domain isEqualToString:@"NSURLErrorDomain"] && error.code == NSURLErrorNotConnectedToInternet) {
            [weakSelf showMessage:@"网络连接失败，请稍后再试"];
        }else{
            [weakSelf showMessage:@"网络不给力... ..."];
        }
        [weakSelf requestNetDataFail];
        
    }];
}

//************************* 简版网络请求 *************************



#pragma mark - 特别设置tableView和提示图
- (void)setTableViewAndPromptView{
    //对tableView和提示图以及等待视图做一些特殊设置
    
}

#pragma mark - Init View  初始化一些视图之类的
- (void)createView{

    
}



#pragma mark - 消息提示弹框
///消息提示弹框
- (void)showMessage:(NSString *)message{
    
    [[MBProgressHUDTool sharedMBProgressHUDTool] showTextToastView:message view:self.view];
}


///消息确定框
- (void)showAlertMessage:(NSString *)message title:(NSString *)title{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancleAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

///提示无网
- (void)showPromptNonetView{
//    self.promptNonetView.hidden = NO;
//    self.promptEmptyView.hidden = YES;
}

///提示无内容
- (void)showPromptEmptyView{
//    self.promptNonetView.hidden = YES;
//    self.promptEmptyView.hidden = NO;
}

//隐藏无网&&无内容提示图
- (void)hidePromptView{
//    self.promptNonetView.hidden = YES;
//    self.promptEmptyView.hidden = YES;
}

///开启等待视图
- (void)startWaitingAnimating{
    
    [self.waitingView startAnimating];
}
///关闭等待视图
- (void)stopWaitingAnimating{
    
    [self.waitingView stopAnimating];
}


#pragma mark - UITableView&&代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return NULL;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark - 导航条&&协议方法
///左侧第一个按钮
- (void)leftFirstButtonClick:(UIButton *)button{
    
    //默认这个为返回按钮
    [self.navigationController popViewControllerAnimated:YES];
}

///右侧第一个按钮
- (void)rightFirstButtonClick:(UIButton *)button{
    
}

///右侧第二个按钮
- (void)rightSecondButtonClick:(UIButton *)button{
    
    
}

#pragma mark - 设置状态栏
///设置状态栏是否隐藏
- (void)setStatusBarIsHide:(BOOL)isHide{
    _statusIsHide = isHide;
    //更新状态栏
    [self setNeedsStatusBarAppearanceUpdate];
}
///设置状态栏样式为默认
- (void)setStatusBarStyleDefault{
    _statusStyle = UIStatusBarStyleDefault;
    //更新状态栏
    [self setNeedsStatusBarAppearanceUpdate];
}
///设置状态栏样式为白色
- (void)setStatusBarStyleLight{
    _statusStyle = UIStatusBarStyleLightContent;
    //更新状态栏
    [self setNeedsStatusBarAppearanceUpdate];
}

//是否隐藏
- (BOOL)prefersStatusBarHidden{
    return _statusIsHide;
}
//状态栏样式
/**
 typedef NS_ENUM(NSInteger, UIStatusBarStyle) {
 UIStatusBarStyleDefault                                     = 0, // Dark content, for use on light backgrounds
 UIStatusBarStyleLightContent     NS_ENUM_AVAILABLE_IOS(7_0) = 1, // Light content, for use on dark backgrounds
 
 UIStatusBarStyleBlackTranslucent NS_ENUM_DEPRECATED_IOS(2_0, 7_0, "Use UIStatusBarStyleLightContent") = 1,
 UIStatusBarStyleBlackOpaque      NS_ENUM_DEPRECATED_IOS(2_0, 7_0, "Use UIStatusBarStyleLightContent") = 2,
 } __TVOS_PROHIBITED;
 */
//状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle{
    return _statusStyle;
}
/**
 typedef NS_ENUM(NSInteger, UIStatusBarAnimation) {
 UIStatusBarAnimationNone,
 UIStatusBarAnimationFade NS_ENUM_AVAILABLE_IOS(3_2),
 UIStatusBarAnimationSlide NS_ENUM_AVAILABLE_IOS(3_2),
 }
 */
//状态栏隐藏动画
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return UIStatusBarAnimationSlide;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"*************内存警告*************");
}



#pragma mark - 右滑返回手势的 开启  && 禁止
///禁止返回手势
- (void)removeBackGesture{
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

/**
 * 恢复返回手势
 */
- (void)resumeBackGesture{
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}


@end
