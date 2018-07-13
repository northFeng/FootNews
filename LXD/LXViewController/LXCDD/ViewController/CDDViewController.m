//
//  CDDViewController.m
//  LXD
//
//  Created by gaoyafeng on 2018/6/7.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "CDDViewController.h"

#import "GFScoreCell.h"

@interface CDDViewController ()




@end

@implementation CDDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createView];
    
    [self.tableView.mj_header beginRefreshing];
    
}


#pragma mark - 设置导航条样式
///设置导航栏样式
- (void)setNaviBarState{
    
    self.naviBarTitle = @"及时比分";
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
    [self.tableView registerNib:[UINib nibWithNibName:@"GFScoreCell" bundle:nil] forCellReuseIdentifier:@"GFScoreCell"];
    
}



#pragma mark - 重写下面三个方法即可
///请求数据(对该方法进行重写便可请求字典的请求)
- (void)requestNetData{
    NSLog(@"请求数据");
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //?league_id=&status=1&match_diff_day=0
    
    [params setObject:@"" forKey:@"league_id"];
    [params setObject:@"1" forKey:@"status"];
    [params setObject:@"0" forKey:@"match_diff_day"];
    
    //http://www.buyinball.com/app-web/api/match/qry_matchs?league_id=&status=1&match_diff_day=0
    //http://www.buyinball.com/app-web/api/match/qry_matchs?league_id=&status=1&match_diff_day=0
    [self requestNetDataUrl:@"match/qry_matchs" params:params];
}

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
            
            [weakSelf requestNetDataSuccess:response[@"qry_matchs"]];
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

///请求成功数据处理
- (void)requestNetDataSuccess:(NSDictionary *)dicData{
    
    self.tableView.mj_footer.hidden = YES;
    
    NSArray *dataArray = dicData[@"data"];
    if (dataArray.count) {
        
        for (NSDictionary *dic in dataArray) {
            
            ScoreModel *model = [[ScoreModel alloc] init];
            [model yy_modelSetWithDictionary:dic];
            
            [self.arrayDataList addObject:model];
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
    
    GFScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GFScoreCell" forIndexPath:indexPath];
    
    [cell setCellModel:self.arrayDataList[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] init];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"所有数据半个小时更新一次...";
    label.font = [UIFont systemFontOfSize:15];
    label.backgroundColor = [UIColor lightGrayColor];
    label.textColor = [UIColor redColor];
    [backView addSubview:label];
    label.sd_layout.leftSpaceToView(backView, 0).topEqualToView(backView).bottomEqualToView(backView).rightSpaceToView(backView, 0);
    return backView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.arrayDataList.count) {
        return 30;
    }else{
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击Cell");
    
}

#pragma mark - cell点击事件进入统计详情
- (void)gotoDetailVC:(NSInteger)type formType:(NSInteger)typeTwo{
    
}


@end
