//
//  APPBaseViewController.h
//  GFAPP
//  多功能基视图 (任何数据都要进行判断是否登录)
//  Created by XinKun on 2017/11/16.
//  Copyright © 2017年 North_feng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUDTool.h"

//导航条
#import "GFNavigationBarView.h"

//网络请求简版
#import "APPHttpTool.h"


@interface APPBaseViewController : UIViewController <GFNavigationBarViewDelegate,UITableViewDelegate,UITableViewDataSource>

///tableView
@property (nonatomic,strong) UITableView *tableView;

///数据列表数组
@property (nonatomic,strong) NSMutableArray *arrayDataList;

///加载更多——页数
@property (nonatomic,assign) NSInteger page;

///导航条
@property (nonatomic, strong) GFNavigationBarView *naviBar;

///页面标题
@property (nonatomic, copy) NSString *naviBarTitle;

///系统等待视图
@property (nonatomic,strong) UIActivityIndicatorView *waitingView;



#pragma mark - 创建tableView

/**
 *  @brief 创建tableView
 *
 *
 */
- (void)createTableView;

/**
 *  @brief 添加上拉刷新，下拉加载功能
 *
 *
 */
- (void)addTableViewRefreshView;

#pragma mark - 网络数据请求
///请求网络
- (void)requestNetData;
///发送网络请求
- (void)requestNetDataUrl:(NSString *)url params:(NSDictionary *)params;

///tableView请求一个字典
- (void)requestNetTableViewDicDataUrl:(NSString *)url params:(NSDictionary *)params;

///请求一个字典
- (void)requestNetDicDataUrl:(NSString *)url params:(NSDictionary *)params;

#pragma mark - 提示框&警告框
/**
 *  @brief 消息提示框
 *
 *  @param message 消息默认显示在Window视图上，全APP内显示位置一样（多个控制提示可能会重叠）
 *
 */
- (void)showMessage:(NSString *)message;

/**
 *  @brief 消息确认框
 *
 *  @param message 消息
 *  @param title 消息框标题
 *
 */
- (void)showAlertMessage:(NSString *)message title:(NSString *)title;

/**
 *  @brief 无网提示图
 *
 */
- (void)showPromptNonetView;

/**
 *  @brief 无内容提示图
 *
 */
- (void)showPromptEmptyView;

/**
 *  @brief 隐藏无网&&无内容提示图
 *
 */
- (void)hidePromptView;

/**
 *  @brief 开启等待视图
 *
 */
- (void)startWaitingAnimating;

/**
 *  @brief 关闭等待视图
 *
 */
- (void)stopWaitingAnimating;

#pragma mark - 状态栏设置
/**
 *  @brief 设置状态栏是否隐藏
 *
 */
- (void)setStatusBarIsHide:(BOOL)isHide;

/**
 *  @brief 设置状态栏样式为默认
 *
 */
- (void)setStatusBarStyleDefault;

/**
 *  @brief 设置状态栏样式为白色
 *
 */
- (void)setStatusBarStyleLight;



#pragma mark - 右滑返回手势的 开启  && 禁止
///禁止返回手势
- (void)removeBackGesture;

/**
 * 恢复返回手势
 */
- (void)resumeBackGesture;





@end
