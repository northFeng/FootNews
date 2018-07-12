//
//  CSDViewController.m
//  LXD
//
//  Created by gaoyafeng on 2018/6/7.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "CSDViewController.h"

#import "GFPersonCell.h"

@interface CSDViewController ()



@end

@implementation CSDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createView];
    
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark - 设置导航条样式
///设置导航栏样式
- (void)setNaviBarState{
    
    self.naviBarTitle = @"最爱球星";
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
    [self.tableView registerNib:[UINib nibWithNibName:@"GFPersonCell" bundle:nil] forCellReuseIdentifier:@"GFPersonCell"];
    
}



#pragma mark - 重写下面三个方法即可
///请求数据(对该方法进行重写便可请求字典的请求)
- (void)requestNetData{
    
    [self requestNetDataUrl:@"http://sportsnba.qq.com/player/statsRank?statType=point&num=20&tabType=1&seasonId=2015&appver=1.0.2.2&appvid=1.0.2.2&network=wifi" params:nil];
}

///请求网络数据(分页请求)
- (void)requestNetDataUrl:(NSString *)url params:(NSDictionary *)params{
    
    __weak typeof(self) weakSelf = self;
    [self startWaitingAnimating];
    self.tableView.userInteractionEnabled = NO;
    
    [APPHttpTool getWithUrlTwo:url params:params success:^(id response, NSInteger code) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        weakSelf.tableView.userInteractionEnabled = YES;
        ///隐藏加载动画
        [weakSelf stopWaitingAnimating];
        
        NSInteger codeStr = [[response objectForKey:@"code"] integerValue];
        if (codeStr == 0) {
            //请求成功
            //隐藏无网占位图
            
            [weakSelf requestNetDataSuccess:response[@"data"]];
        }else{
            weakSelf.page --;
            // 错误处理
            [weakSelf showMessage:@"网络错误...."];
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
    
    NSArray *dataArray = dicData[@"point"];
    if (dataArray.count) {
        
        for (NSDictionary *dic in dataArray) {
            
            GFPersonModel *model = [[GFPersonModel alloc] init];
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
    
    GFPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GFPersonCell" forIndexPath:indexPath];

    [cell setCellModel:self.arrayDataList[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击Cell");
    APPWebViewVC *webVC = [[APPWebViewVC alloc] init];
    GFPersonModel *model = self.arrayDataList[indexPath.row];
    webVC.htmlUrl = model.playerUrl;//model.teamUrl;
    webVC.naviBarTitle = model.playerName;
    [self.navigationController pushViewController:webVC animated:YES];
}



@end
