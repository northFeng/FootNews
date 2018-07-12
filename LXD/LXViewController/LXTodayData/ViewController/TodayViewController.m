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
    _cycleScrollView.clickItemOperationBlock = ^(NSInteger index) {
        NSLog(@">>>>>  %ld", (long)index);
    };
}

- (void)setArrayBanners:(NSArray *)arrayBanners{
    _arrayBanners = arrayBanners;
    
    NSMutableArray *imgArray = [NSMutableArray array];
    for (BannerModel *model in arrayBanners) {
        [imgArray addObject:model.info_pic];
    }
    _cycleScrollView.imageURLStringsGroup = imgArray;
}



#pragma mark - 重写下面三个方法即可
///请求数据(对该方法进行重写便可请求字典的请求)
- (void)requestNetData{
    NSLog(@"请求数据");
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@"0" forKey:@"info_type"];
    [params setValue:@"1.2.7" forKey:@"app_version"];
    [params setValue:@"360" forKey:@"channel_no"];
    
    [params setValue:@"10" forKey:@"page_size"];
    [params setValue:[NSNumber numberWithInteger:self.page] forKey:@"page_index"];
    
    //?page_size=10&info_type=0&app_version=1.2.7&channel_no=360&page_index=1
    //?page_size=10&info_type=0&app_version=1.2.7&channel_no=360&page_index=2
    [self requestNetDataUrl:@"info/qry_infos" params:params];
    
}

///请求成功数据处理
- (void)requestNetDataSuccess:(NSDictionary *)dicData{
    
    if (dicData) {
        
        _modelData = [[TodayModel alloc] init];
        [_modelData yy_modelSetWithDictionary:dicData];
        
        if (self.page == 1) {
            self.arrayBanners = _modelData.banners;
            [self.arrayDataList removeAllObjects];
            for (ListModel *model in _modelData.data) {
                [self.arrayDataList addObject:model];
            }
        }else{
            for (ListModel *model in _modelData.data) {
                [self.arrayDataList addObject:model];
            }
        }
        
        if (_modelData.data.count < 10) {
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
    
    TodayHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodayHomeCell" forIndexPath:indexPath];
    
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
    ListModel *model = self.arrayDataList[indexPath.row];
    webVC.htmlUrl = model.info_url;
    webVC.naviBarTitle = model.info_type_name;
    [self.navigationController pushViewController:webVC animated:YES];
}


@end
