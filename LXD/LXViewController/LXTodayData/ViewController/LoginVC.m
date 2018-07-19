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

@property (weak, nonatomic) IBOutlet UITextField *email;

@property (weak, nonatomic) IBOutlet UITextField *password;


@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation LoginVC
{
    NSMutableArray *_arrayTemp;
}

//状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _loginBtn.layer.cornerRadius = 4;
    _loginBtn.layer.masksToBounds = YES;
    
    
    [self createTableView];
    
    [self.tableView removeFromSuperview];
    
    _password.secureTextEntry = YES;
    
    //判断是否注册过
    NSString *loginKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginKey"];
    if (loginKey.length) {
        //登录过
        NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:loginKey];
        if (array) {
            
            _arrayTemp = [NSMutableArray arrayWithArray:array];
            
            _userName.text = _arrayTemp[0];
            
            _email.text = _arrayTemp[1];
        }
    }
    
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
    
    if ([self validateInfo]) {
        
        if (_arrayTemp.count) {
            
            //登录过
            if ([_email.text isEqualToString:_arrayTemp[1]]) {
                
                //同一个账号
                if ([_password.text isEqualToString:_arrayTemp[2]]) {
                    
                    //登录成功
                    [self sucessLogin];
                    
                }else{
                    //密码错误
                    [self showMessage:@"密码输入错误"];
                    return ;
                }
            }else{
                
                //不同账号
                
                //判断是否注册过
                NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:_email.text];
                if (array.count) {
                    //判断信息
                    if ([_email.text isEqualToString:array[1]] && [_password.text isEqualToString:array[2]]) {
                        
                        //登录成功
                        _arrayTemp = [array copy];
                        [self sucessLogin];
                        
                    }else{
                        //信息错误
                        [self showMessage:@"账号或密码输入错误"];
                        return ;
                    }
                    
                }else{
                    //未注册过  --> 直接存储信息
                    [self onClickResgerAction:nil];
                }
            }
        }else{
            
            //未注册过 --> 直接存储信息
            [self onClickResgerAction:nil];
        }
    }
}


///登录成功
- (void)sucessLogin{
    
    [self startWaitingAnimating];
    
    //0 登录 1退出
    NSArray *array = @[_userName.text,_arrayTemp[1],_arrayTemp[2],_arrayTemp[3],@"0"];
    
    //保存信息
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:_email.text];
    //保存key
    [[NSUserDefaults standardUserDefaults] setObject:_email.text forKey:@"loginKey"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self performSelector:@selector(exitVC) withObject:nil afterDelay:2];
    
}


#pragma mark - 注册
- (IBAction)onClickResgerAction:(id)sender {
    
    [self startWaitingAnimating];
    
    //0 登录 1退出
    NSArray *array = @[_userName.text,_email.text,_password.text,@"",@"0"];
    
    //保存信息
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:_email.text];
    //保存key
    [[NSUserDefaults standardUserDefaults] setObject:_email.text forKey:@"loginKey"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self performSelector:@selector(exitVC) withObject:nil afterDelay:2];
}

#pragma mark - 验证
- (BOOL)validateInfo{
    
    if (_userName.text.length == 0) {
        [self showMessage:@"名称不能为空"];
        return NO;
    }else if (_email.text.length == 0){
        [self showMessage:@"邮箱地址不能为空"];
        return NO;
    }else if (_password.text.length == 0){
        [self showMessage:@"密码不能为空"];
        return NO;
    }
    
    if (![self validateEmail:_email.text]) {
        [self showMessage:@"邮箱格式不正确"];
        return NO;
    }
    
    return YES;
}


/** wanbin 2015-01-21 02:44 编辑
 *  邮箱验证
 *
 *  @param candidate 需要验证的邮箱内容
 *
 *  @return 验证结果
 */
-(BOOL)validateEmail: (NSString *) candidate{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_userName resignFirstResponder];
    [_email resignFirstResponder];
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
