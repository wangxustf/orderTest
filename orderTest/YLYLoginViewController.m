//
//  YLYLoginViewController.m
//  orderTest
//
//  Created by wangxu on 15/9/12.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "YLYLoginViewController.h"
#import "YLYTipsTextField.h"
#import "Service.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@interface YLYLoginViewController ()

@property (nonatomic, strong) YLYTipsTextField *accountTextField;
@property (nonatomic, strong) YLYTipsTextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) YLYTipsTextField *IPTextField;
@property (nonatomic, strong) Service *service;

@end

@implementation YLYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"登录";
    
    _service = [[Service alloc] init];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didClickLoginButton:(id)sender
{
    if (self.accountTextField.text.length <= 0) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"账号不能为空"];
        return;
    }
    if (self.passwordTextField.text.length <= 0) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"密码不能为空"];
        return;
    }
    YLYBaseURL = self.IPTextField.text.length > 0 ? [NSString stringWithFormat:@"http://%@:8080/sys", self.IPTextField.text] : YLYBaseURL;
//    [self.service loginWithLoginName:@"18966834015" password:@"111111" completion:^(BOOL success, YLYUser *user, NSString *msg) {//司机
//    [self.service loginWithLoginName:@"13991355119" password:@"123456" completion:^(BOOL success, YLYUser *user, NSString *msg) {//审核人
//  [self.service loginWithLoginName:@"15029060400" password:@"123456" completion:^(BOOL success, YLYUser *user, NSString *msg) {//订车人
//    [self.service loginWithLoginName:@"18710889507" password:@"111111" completion:^(BOOL success, YLYUser *user, NSString *msg) {//派车人
    [self.service loginWithLoginName:self.accountTextField.text password:self.passwordTextField.text completion:^(BOOL success, YLYUser *user, NSString *msg) {
        if (success) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"用户名或密码错误"];
        }
    }];
}

- (void)setupUI
{
    CGFloat gap = 10;
    CGFloat buttonWidth = 150;
    
    _accountTextField = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(0, 100, self.view.width, 44)];
    [_accountTextField tipsTextFieldWithTips:@"用户名" placeholder:@"请输入用户名" isPassword:NO];
    [self.view addSubview:_accountTextField];
    
    _passwordTextField = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(0, _accountTextField.bottom + gap, self.view.width, 44)];
    [_passwordTextField tipsTextFieldWithTips:@"密 码" placeholder:@"请输入密码" isPassword:YES];
    [self.view addSubview:_passwordTextField];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame = CGRectMake((self.view.width - buttonWidth)/2.0, _passwordTextField.bottom + gap, buttonWidth, 44);
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    _loginButton.backgroundColor = RGB(kMainColor);
    _loginButton.layer.cornerRadius = 2.5;
    [_loginButton addTarget:self action:@selector(didClickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    self.IPTextField = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(0, _loginButton.bottom + gap, self.view.width, 44)];
    [self.IPTextField tipsTextFieldWithTips:@"IP地址" placeholder:@"192.168.1.4" isPassword:NO];
//    [self.view addSubview:self.IPTextField];
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
