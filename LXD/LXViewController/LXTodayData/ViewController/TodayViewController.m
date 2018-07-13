//
//  TodayViewController.m
//  LXD
//
//  Created by gaoyafeng on 2018/6/7.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "TodayViewController.h"

//轮播图
#import "SDCycleScrollView.h"

#import "TodayHomeCell.h"//cell

@interface TodayViewController ()

/** 轮播图 */
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

/** model */
@property (nonatomic,strong) TodayModel *modelData;

/** banner数组 */
@property (nonatomic,copy) NSArray *arrayBanners;

/** 数量 */
@property (nonatomic,assign) NSInteger index;

@end

@implementation TodayViewController


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
    
    if ([_name isEqualToString:@"最新"]) {
        _index = 3;
    }else{
        _index = 0;
    }
    _arrayBanners = [NSArray array];
    
}


///创建视图
- (void)createView{
    
    //创建tableView
    [self createTableView];
    //添加上拉下拉
    [self addTableViewRefreshView];
    
    //改变tableview的frame
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - (kTopNaviBarHeight + kTabBarHeight));
    self.tableView.backgroundColor = [UIColor whiteColor];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TodayHomeCell" bundle:nil] forCellReuseIdentifier:@"TodayHomeCell"];
    
    if ([_name isEqualToString:@"最新"]) {
        
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
            webVC.htmlUrl = model.url;
            webVC.naviBarTitle = model.author;
            [weakSelf.navigationController pushViewController:webVC animated:YES];
        };
    }
    
}

- (void)setArrayBanners:(NSArray *)arrayBanners{
    _arrayBanners = arrayBanners;
    
    NSMutableArray *imgArray = [NSMutableArray array];
    for (TodayModel *model in arrayBanners) {
        [imgArray addObject:model.imglink];
    }
    _cycleScrollView.imageURLStringsGroup = imgArray;
}



#pragma mark - 重写下面三个方法即可
///请求数据(对该方法进行重写便可请求字典的请求)
- (void)requestNetData{
    NSLog(@"请求数据");
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@"" forKey:@"keyword"];
    [params setValue:@"0" forKey:@"uid"];
    
    //类别
    [params setValue:_type forKey:@"type"];
    
    if (![_name isEqualToString:@"最新"]) {
        [params setValue:_name forKey:@"sourceName"];
    }
    
    [params setValue:@"20" forKey:@"opc"];
    [params setValue:[NSNumber numberWithInteger:self.page] forKey:@"npc"];
    
    //http://api.football.app887.com/api/Articles.action?keyword=&npc=0&opc=20&type=%E4%B8%AD%E5%9B%BD%E8%B6%B3%E7%90%83&uid=0
    //http://api.football.app887.com/api/Articles.action?keyword=&npc=0&opc=20&sourceName=%E4%B8%AD%E8%B6%85&type=%E4%B8%AD%E5%9B%BD%E8%B6%B3%E7%90%83&uid=0
    //http://api.football.app887.com/api/Articles.action?keyword=&npc=0&opc=20&sourceName=%E5%9B%BD%E8%B6%B3&type=%E4%B8%AD%E5%9B%BD%E8%B6%B3%E7%90%83&uid=0
    
    //http://api.football.app887.com/api/Articles.action?keyword=&npc=0&opc=20&sourceName=%E8%A5%BF%E7%94%B2&type=%E5%9B%BD%E9%99%85%E8%B6%B3%E7%90%83&uid=0
    //http://api.football.app887.com/api/Articles.action?keyword=&npc=0&opc=20&type=%E5%9B%BD%E9%99%85%E8%B6%B3%E7%90%83&uid=0
    //http://api.football.app887.com/api/Articles.action?keyword=&npc=1&opc=20&type=%E5%9B%BD%E9%99%85%E8%B6%B3%E7%90%83&uid=0
    //http://api.football.app887.com/api/Articles.action?keyword=&npc=2&opc=20&type=%E5%9B%BD%E9%99%85%E8%B6%B3%E7%90%83&uid=0
    [self requestNetDataUrl:@"http://api.football.app887.com/api/Articles.action" params:params];
    
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
            
            [self.arrayDataList addObject:model];
        }
        
        if (listData.count < 20) {
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
    }
    
    if ([_name isEqualToString:@"最新"]) {
        if (self.page == 0) {
            if (self.arrayDataList.count > 5) {
                //取出前三个数据
                NSArray *array = @[self.arrayDataList[0],self.arrayDataList[1],self.arrayDataList[2]];
                self.arrayBanners = array;
            }
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
    
    return self.arrayDataList.count - _index;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TodayHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodayHomeCell" forIndexPath:indexPath];
    
    [cell setCellModel:self.arrayDataList[indexPath.row + _index]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
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
    TodayModel *model = self.arrayDataList[indexPath.row + _index];
    webVC.htmlUrl = model.url;
    webVC.naviBarTitle = model.author;
    [self.navigationController pushViewController:webVC animated:YES];
}


@end
