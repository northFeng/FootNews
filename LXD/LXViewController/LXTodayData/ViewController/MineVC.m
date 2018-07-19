//
//  MineVC.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/19.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "MineVC.h"

#import "MyCell.h"

#import "GFSelectPhoto.h"

#import "GFTabBarController.h"

@interface MineVC ()

/** 头像 */
@property (nonatomic,strong) UIButton *iconBtn;

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //刷新数据
    
    //判断是否注册过
    NSString *loginKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginKey"];
    //登录过
    NSArray *arrayInfo = [[NSUserDefaults standardUserDefaults] objectForKey:loginKey];
    
    NSString *one = [NSString stringWithFormat:@"账号：%@",arrayInfo[0]];
    
    NSString *two = [NSString stringWithFormat:@"版本：%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    //缓存
    SDImageCache *saImage = [SDImageCache sharedImageCache];
    NSString *cacheSize = [NSString stringWithFormat:@"%.2fM",saImage.getSize/1024./1024.];
    
    NSString *thr = [NSString stringWithFormat:@"缓存：%@",cacheSize];
    
    NSArray *array = @[one,two,thr];
    
    self.arrayDataList = [NSMutableArray arrayWithArray:array];
    
    if ([arrayInfo[3] isKindOfClass:[NSData class]]) {
        NSData *phontoData = arrayInfo[3];
        UIImage *image = [UIImage imageWithData:phontoData];
        [_iconBtn setImage:image forState:UIControlStateNormal];
    }else{
        [_iconBtn setImage:[UIImage imageNamed:@"icon_wo"] forState:UIControlStateNormal];
    }
    
    [self.tableView reloadData];
    
}

#pragma mark - 设置导航条样式
///设置导航栏样式
- (void)setNaviBarState{
    
    self.naviBarTitle = @"个人球门";
}


#pragma mark - 初始化界面基础数据
- (void)initData {
    
}

///创建视图
- (void)createView{
    
    //创建tableView
    [self createTableView];
    
    //改变tableview的frame
    self.tableView.frame = CGRectMake(0, kTopNaviBarHeight, kScreenWidth, kScreenHeight - (kTopNaviBarHeight + kTabBarHeight));
    self.tableView.backgroundColor = [UIColor whiteColor];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellReuseIdentifier:@"MyCell"];
    
    UIImageView *imgBack = [[UIImageView alloc] init];
    imgBack.frame = CGRectMake(0, 0, kScreenWidth, 150);
    imgBack.image = [UIImage imageNamed:@"footImg"];
    imgBack.userInteractionEnabled = YES;
    
    //添加头像
    _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconBtn.layer.cornerRadius = 30;
    _iconBtn.layer.masksToBounds = YES;
    [_iconBtn setImage:[UIImage imageNamed:@"icon_wo"] forState:UIControlStateNormal];
    _iconBtn.backgroundColor = [UIColor whiteColor];
    [imgBack addSubview:_iconBtn];
    _iconBtn.sd_layout.centerXEqualToView(imgBack).centerYEqualToView(imgBack).widthIs(60).heightIs(60);
    [_iconBtn addTarget:self action:@selector(selectIconPhoto) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableHeaderView = imgBack;
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    
    [cell setCellString:self.arrayDataList[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(exitAccount) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
    btn.sd_layout.centerXEqualToView(backView).centerYEqualToView(backView).widthIs(kScreenWidth - 30).heightIs(30);
    
    return backView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击Cell");
    
    if (indexPath.row == 2) {
        //清理缓存
        //清除缓存
        UIAlertController *clearCacheAlert = [UIAlertController alertControllerWithTitle:@"您确定要清除应用缓存吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [clearCacheAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击取消");
            
        }]];
        
        APPWeakSelf
        [clearCacheAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击确定");
            
            [weakSelf startWaitingAnimating];
            
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
            [[SDImageCache sharedImageCache] clearMemory];//可有可无
            
            [weakSelf performSelector:@selector(cacheDataClearDone) withObject:nil afterDelay:3];
        }]];
        
        [self presentViewController:clearCacheAlert animated:YES completion:nil];
    }
}

/**
 *   成功清除缓存提示
 */
-(void)cacheDataClearDone {
    
    //缓存
    SDImageCache *saImage = [SDImageCache sharedImageCache];
    NSString *cacheSize = [NSString stringWithFormat:@"%.2fM",saImage.getSize/1024./1024.];
    
    NSString *thr = [NSString stringWithFormat:@"缓存：%@",cacheSize];
    
    //更新数据
    [self.arrayDataList replaceObjectAtIndex:2 withObject:thr];
    
    [self stopWaitingAnimating];
    
    [self.tableView reloadData];

    [self showMessage:@"缓存已清理完毕"];
}



#pragma mark - 选择头像
- (void)selectIconPhoto{
    
    APPWeakSelf
    [GFSelectPhoto shareInstance].isEditing = YES;
    [[GFSelectPhoto shareInstance] alertSelectTypeWithVC:self authorBlock:^(NSInteger type) {
        //type:0:取消 1:相机权限未打开  2:相册权限未打开
        switch (type) {
            case 0:
                NSLog(@"取消");
                break;
            case 1:
                NSLog(@"相机权限未授权");
                [weakSelf showMessage:@"请到设置中打开相机授权权限"];
                break;
            case 2:
                NSLog(@"相册权限未授权");
                [weakSelf showMessage:@"请到设置中打开相册授权权限"];
                break;
                
            default:
                break;
        }
        
    } photoBlock:^(UIImage *photo) {
        
        [weakSelf.iconBtn setImage:photo forState:UIControlStateNormal];
        
        //存储对象
        NSData *data = UIImagePNGRepresentation(photo);
        
        //判断是否注册过
        NSString *loginKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginKey"];
        //登录过
        NSArray *arrayInfo = [[NSUserDefaults standardUserDefaults] objectForKey:loginKey];
        NSMutableArray *arrayNew = [NSMutableArray arrayWithArray:arrayInfo];
        
        //替换头像数据
        [arrayNew replaceObjectAtIndex:3 withObject:data];
        
        arrayInfo = [NSArray arrayWithArray:arrayNew];
        [[NSUserDefaults standardUserDefaults] setObject:arrayInfo forKey:loginKey];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }];
}


#pragma mark - 退出登录
- (void)exitAccount{
    
    [self startWaitingAnimating];
    
    //判断是否注册过
    NSString *loginKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginKey"];
    //登录过
    NSArray *arrayInfo = [[NSUserDefaults standardUserDefaults] objectForKey:loginKey];
    
    NSArray *array = @[arrayInfo[0],arrayInfo[1],arrayInfo[2],arrayInfo[3],@"1"];
    
    //保存信息
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:loginKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self performSelector:@selector(exitVC) withObject:nil afterDelay:2];
}

- (void)exitVC{
    
    [self stopWaitingAnimating];
    
    //去掉头像
    [_iconBtn setImage:[UIImage imageNamed:@"icon_wo"] forState:UIControlStateNormal];
    
    //弹出登录视图
    [[GFTabBarController sharedInstance] popLoginVC];
}




@end
