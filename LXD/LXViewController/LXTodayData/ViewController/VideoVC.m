//
//  VideoVC.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/18.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "VideoVC.h"

#import "VideoCell.h"

#import "GFAVPlayerViewController.h"

@interface VideoVC ()

@end

@implementation VideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createView];
    
    [self.tableView.mj_header beginRefreshing];
    
}


#pragma mark - 设置导航条样式
///设置导航栏样式
- (void)setNaviBarState{
    
    self.naviBarTitle = @"环球头条";
}

#pragma mark - 初始化界面基础数据
- (void)initData {
    
    
}


///创建视图
- (void)createView{
    
    //创建tableView
    [self createTableView];
    //添加上拉下拉
    [self addTableViewRefreshView];
    
    //改变tableview的frame
    self.tableView.frame = CGRectMake(0, kTopNaviBarHeight, kScreenWidth, kScreenHeight - (kTopNaviBarHeight + kTabBarHeight));
    self.tableView.backgroundColor = [UIColor whiteColor];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoCell" bundle:nil] forCellReuseIdentifier:@"VideoCell"];
    
}

///添加上拉刷新，下拉加载功能
- (void)addTableViewRefreshView{
    __weak typeof(self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 0;
        [weakSelf requestNetData];
    }];
    
    //MJRefreshAutoNormalFooter  MJRefreshAutoFooter
    self.tableView.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf requestNetData];
    }];
    
    self.tableView.mj_footer.hidden = YES;
    
}



#pragma mark - 重写下面三个方法即可
///请求数据(对该方法进行重写便可请求字典的请求)
- (void)requestNetData{
    NSLog(@"请求数据");
    NSString *string = @"2018%E4%B8%96%E7%95%8C%E6%9D%AF";
    string = [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:string forKey:@"keywords"];
    [params setObject:@"5" forKey:@"type"];
    
    if (self.page == 0) {
        [params setValue:@"" forKey:@"lastid"];
    }else{
        if (self.arrayDataList.count > 0) {
            VideoModel *model = [self.arrayDataList lastObject];
            [params setValue:model.pid forKey:@"lastid"];
        }
    }    

    //http://worldcup.ttplus.cn/ttapi/list/search?keywords=2018%E4%B8%96%E7%95%8C%E6%9D%AF&type=5&lastid=
    //http://worldcup.ttplus.cn/ttapi/list/search?keywords=2018%E4%B8%96%E7%95%8C%E6%9D%AF&type=5&lastid=143529
    [self requestNetDataUrl:@"http://worldcup.ttplus.cn/ttapi/list/search" params:params];
    
}

#pragma mark - 简版网络请求
//************************* 简版网络请求 *************************
///请求网络数据(分页请求)
- (void)requestNetDataUrl:(NSString *)url params:(NSDictionary *)params{
    
    __weak typeof(self) weakSelf = self;
    [self startWaitingAnimating];
    self.tableView.userInteractionEnabled = NO;
    
    [APPHttpTool getWithUrl:url params:params success:^(id response, NSInteger code) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        weakSelf.tableView.userInteractionEnabled = YES;
        ///隐藏加载动画
        [weakSelf stopWaitingAnimating];
        
        //NSString *message = [response objectForKey:@"result_msg"];
        
        if (code == 0) {
            //请求成功
            //隐藏无网占位图
            
            [weakSelf requestNetDataSuccess:response];
        }else{
            weakSelf.page --;
            // 错误处理
            [weakSelf showMessage:@"网络有问题..."];
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

///请求成功数据处理
- (void)requestNetDataSuccess:(NSDictionary *)dicData{
    
    if (dicData) {
        
        NSArray *listData = dicData[@"content"];
        
        if (self.page == 0) {
            
            [self.arrayDataList removeAllObjects];
            
        }
        
        for (NSDictionary *dic in listData) {
            
            VideoModel *model = [[VideoModel alloc] init];
            [model yy_modelSetWithDictionary:dic];
            
            [self.arrayDataList addObject:model];
        }
        
        if (listData.count < 10) {
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
    }
    
    //刷新数据&&处理页面
    [self.tableView reloadData];
    
}

///请求数据失败处理
- (void)requestNetDataFail{
    
    
    
}


#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];
    
    [cell setCellModel:self.arrayDataList[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 170 * KSCALE;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击Cell");
    
    VideoModel *model = self.arrayDataList[indexPath.row];
    GFAVPlayerViewController *videoVC = [[GFAVPlayerViewController alloc] init];
    videoVC.naviBarTitle = model.shorttitle;
    videoVC.model = model;
    [self.navigationController pushViewController:videoVC animated:YES];
}



@end
