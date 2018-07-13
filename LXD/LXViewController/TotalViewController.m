//
//  TotalViewController.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/13.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "TotalViewController.h"

#import "CFFengTabBtnView.h"//顶部tab条

#import "TodayViewController.h"

@interface TotalViewController ()<UIScrollViewDelegate>

// 顶部tab条
@property (nonatomic,strong) CFFengTabBtnView *tabBtnView;

// 滑动视图
@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation TotalViewController
{
    NSArray *_arrayTitle;
}

//状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    [self createView];
    
    
}

///初始化数据
- (void)initData{
    
    if (_type == 0) {
        //国际
        _arrayTitle = @[@"最新",@"英超",@"西甲",@"德甲",@"意甲"];
    }else if (_type == 1){
        _arrayTitle = @[@"最新",@"中超",@"国足",@"女足",@"中甲"];
    }
    
}

///创建视图
- (void)createView{
    
    //状态栏白条
    UIView *stateView = [[UIView alloc] init];
    stateView.backgroundColor = [UIColor whiteColor];
    stateView.frame = CGRectMake(0, 0, kScreenWidth, kStatusBarHeight);
    [self.view addSubview:stateView];
    
    _tabBtnView = [[CFFengTabBtnView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, 44)];
    [_tabBtnView createViewBtnCount:_arrayTitle defaultSelectIndex:0];
    __weak typeof(self) weakSelf = self;
    _tabBtnView.blockIndex = ^(NSInteger index) {
        [weakSelf scrollViewSwitchView:index];
    };
    [self.view addSubview:_tabBtnView];
    
    //创建scrollerView
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.frame = CGRectMake(0, kTopNaviBarHeight, kScreenWidth, kScreenHeight - kTopNaviBarHeight - kTabBarHeight);
    [self.view addSubview:_scrollView];
    
    for (int i=0; i<_arrayTitle.count; i++) {
        
        TodayViewController *tradeVC = [[TodayViewController alloc] init];
        if (_type == 0) {
            tradeVC.type = @"国际足球";
        }else{
            tradeVC.type = @"中国足球";
        }
        tradeVC.name = _arrayTitle[i];
        tradeVC.view.frame = CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight - kTopNaviBarHeight - kTabBarHeight);
        [self addChildViewController:tradeVC];
        [_scrollView addSubview:tradeVC.view];
    }
    
    _scrollView.contentSize = CGSizeMake( kScreenWidth* _arrayTitle.count, kScreenHeight - kTopNaviBarHeight - kTabBarHeight);
    
}

#pragma mark - tab切换条按钮  与  scrollerView 的联动处理

//// <UIScrollViewDelegate> scrollView滑动结束监听
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    //调用切换按钮
    [_tabBtnView switchButtonWithIndex:index];
    
}

///切换按钮控制scrollView切换
- (void)scrollViewSwitchView:(NSInteger)index{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake(kScreenWidth * index, 0);
    }];
}




@end
