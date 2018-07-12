//
//  ExampleViewController.m
//  LXD
//
//  Created by gaoyafeng on 2018/6/7.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "ExampleViewController.h"

@interface ExampleViewController ()

@end

@implementation ExampleViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createView];
    
    //[self.tableView.mj_header beginRefreshing];
    
}


#pragma mark - 设置导航条样式
///设置导航栏样式
- (void)setNaviBarState{
    
    
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
//    self.tableView.frame = CGRectMake(0, KTopHeight, KScreenWidth, KScreenHeight - KTopHeight);
//    self.tableView.backgroundColor = RGBCOLORX(248);
    //注册cell
    //[self.tableView registerNib:[UINib nibWithNibName:@"CFTradeCell" bundle:nil] forCellReuseIdentifier:@"tradeCell"];
    
    
}



#pragma mark - 重写下面三个方法即可
///请求数据(对该方法进行重写便可请求字典的请求)
- (void)requestNetData{
    NSLog(@"请求数据");
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //可使用的
    [params setObject:[NSNumber numberWithInteger:self.page]  forKey:@"pageNo"];
    //一次拉取10条
    [params setObject:[NSNumber numberWithInt:10]  forKey:@"pageSize"];
    
    [self requestNetDataUrl:nil params:params];
}

///请求成功数据处理
- (void)requestNetDataSuccess:(NSDictionary *)dicData{
    
    NSArray *arrayList = [dicData objectForKey:@"list"];
    
    if(arrayList.count>0){
        
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
        
    }else{
        //weakSelf.placeholderView.hidden = YES;
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
    return 10;//self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    CFTradeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tradeCell" forIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击Cell");
    
}


@end
