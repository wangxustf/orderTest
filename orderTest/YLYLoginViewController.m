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
    [self.service loginWithLoginName:@"A004" password:@"111111" completion:^(BOOL success, YLYUser *user, NSString *msg) {
        
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
    [_loginButton addTarget:self action:@selector(didClickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
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
