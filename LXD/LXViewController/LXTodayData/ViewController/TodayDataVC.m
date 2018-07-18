//
//  TodayDataVC.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/17.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "TodayDataVC.h"

//轮播图
#import "SDCycleScrollView.h"

#import "TodayHomeCell.h"//cell

@interface TodayDataVC ()

/** 轮播图 */
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

/** model */
@property (nonatomic,strong) TodayModel *modelData;

/** banner数组 */
@property (nonatomic,copy) NSArray *arrayBanners;

/** 数量 */
@property (nonatomic,assign) NSInteger index;

@end

@implementation TodayDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createView];
    
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark - 设置导航条样式
///设置导航栏样式
- (void)setNaviBarState{
    
    self.naviBarTitle = @"足球头条";
}

#pragma mark - 初始化界面基础数据
- (void)initData {
    
    _arrayBanners = [NSArray array];
    
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
    [self.tableView registerNib:[UINib nibWithNibName:@"TodayHomeCell" bundle:nil] forCellReuseIdentifier:@"TodayHomeCell"];
    
    //创建轮播图
    // 网络加载 --- 创建带标题的图片轮播器
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 180) delegate:nil placeholderImage:[UIImage imageNamed:@"img_holder"]];
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    
    self.tableView.tableHeaderView = _cycleScrollView;
    
    //点击
    APPWeakSelf
    _cycleScrollView.clickItemOperationBlock = ^(NSInteger index) {
        NSLog(@">>>>>  %ld", (long)index);
        APPWebViewVC *webVC = [[APPWebViewVC alloc] init];
        TodayModel *model = weakSelf.arrayDataList[index];
        webVC.htmlUrl = model.shareurl;
        webVC.naviBarTitle = model.title;
        [weakSelf.navigationController pushViewController:webVC animated:YES];
    };
    
}

- (void)setArrayBanners:(NSArray *)arrayBanners{
    _arrayBanners = arrayBanners;
    
    NSMutableArray *imgArray = [NSMutableArray array];
    for (TodayModel *model in arrayBanners) {
        if (model.imgurl.length) {
            [imgArray addObject:model.imgurl];
        }else{
            [imgArray addObject:@""];
        }
    }
    _cycleScrollView.imageURLStringsGroup = imgArray;
}



#pragma mark - 重写下面三个方法即可
///请求数据(对该方法进行重写便可请求字典的请求)
- (void)requestNetData{
    NSLog(@"请求数据");
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@"1" forKey:@"extra"];
    
    if (self.page == 0) {
        [params setValue:@"header" forKey:@""];
    }else{
        if (self.arrayDataList.count > 0) {
            TodayModel *model = [self.arrayDataList lastObject];
            [params setObject:model.pid forKey:@"lastid"];
            [params setValue:@"footer" forKey:@""];
        }
    }
    
    //http://api.ttplus.cn/list/interfb?extra=1&=header
    //http://api.ttplus.cn/list/innerfb?lastid=143637&extra=1&=footer
    //http://api.ttplus.cn/list/interfb?extra=1&=header
    
    //http://api.ttplus.cn/list/interfb?extra=1&=header
    //http://api.ttplus.cn/list/interfb?lastid=143681&extra=1&=footer
    //http://api.ttplus.cn/list/interfb?lastid=143666&extra=1&=footer
    //http://api.ttplus.cn/list/interfb?lastid=143653&extra=1&=footer
    [self requestNetDataUrl:@"http://api.ttplus.cn/list/interfb" params:params];
    
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
            
            [weakSelf requestNetDataSuccess:response[@"content"]];
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
        
        NSArray *listData = dicData[@"list"];
        
        if (self.page == 0) {
            
            [self.arrayDataList removeAllObjects];
            
        }
        
        for (NSDictionary *dic in listData) {
            
            TodayModel *model = [[TodayModel alloc] init];
            [model yy_modelSetWithDictionary:dic];
            
            if (model.imgurl.length == 0) {
                if (model.imgList.count) {
                    NSDictionary *dic = model.imgList[0];
                    model.imgurl = dic[@"imgurl"];
                }
            }
            
            if (model.shareurl.length == 0) {
                continue ;
            }
            [self.arrayDataList addObject:model];
        }
        
        if (listData.count < 10) {
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
    }
    
    if (self.page == 0) {
        if (self.arrayDataList.count > 5) {
            //取出前三个数据
            NSArray *array = @[self.arrayDataList[0],self.arrayDataList[1],self.arrayDataList[2]];
            self.arrayBanners = array;
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
    
    return self.arrayDataList.count - 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TodayHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodayHomeCell" forIndexPath:indexPath];
    
    [cell setCellModel:self.arrayDataList[indexPath.row + 3]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
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
    TodayModel *model = self.arrayDataList[indexPath.row + 3];
    webVC.htmlUrl = model.shareurl;
    webVC.naviBarTitle = model.title;
    [self.navigationController pushViewController:webVC animated:YES];
}




@end
