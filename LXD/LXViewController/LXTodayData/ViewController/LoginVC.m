//
//  LoginVC.m
//  LXD
//
//  Created by gaoyafeng on 2018/7/18.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet UITextField *password;


@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *resigerBtn;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _loginBtn.layer.cornerRadius = 4;
    _loginBtn.layer.masksToBounds = YES;
    
    _resigerBtn.layer.cornerRadius = 4;
    _resigerBtn.layer.masksToBounds = YES;
    
    [self createTableView];
    
    [self.tableView removeFromSuperview];
    
}

///设置导航栏样式
- (void)setNaviBarState{
    
    //self.naviBarTitle = @"环球头条";
    
    self.naviBar.hidden = YES;
}



#pragma mark - 登录
- (IBAction)onClickLoginAction:(id)sender {
    
    [_userName resignFirstResponder];
    [_password resignFirstResponder];
    
    [self startWaitingAnimating];
    
    [[NSUserDefaults standardUserDefaults] setObject:_userName.text forKey:@"user"];
    
    [[NSUserDefaults standardUserDefaults] setObject:_password.text forKey:@"password"];
    
    [self performSelector:@selector(exitVC) withObject:nil afterDelay:2];
}


#pragma mark - 注册
- (IBAction)onClickResgerAction:(id)sender {
    
    [_userName resignFirstResponder];
    [_password resignFirstResponder];
    
    [self startWaitingAnimating];
    
    [[NSUserDefaults standardUserDefaults] setObject:_userName.text forKey:@"user"];
    
    [[NSUserDefaults standardUserDefaults] setObject:_password.text forKey:@"password"];
    
    [self performSelector:@selector(exitVC) withObject:nil afterDelay:2];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_userName resignFirstResponder];
    [_password resignFirstResponder];
}

- (void)exitVC{
    
    [self stopWaitingAnimating];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
