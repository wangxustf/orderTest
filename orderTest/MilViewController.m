//
//  MilViewController.m
//  orderTest
//
//  Created by wangxu on 15/9/12.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "MilViewController.h"
#import "Service.h"

@interface MilViewController ()

@property (nonatomic, strong) NSArray *orderList;

@end

@implementation MilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的订车里程";
    
    Service *service = [[Service alloc] init];
    YLYUser *user = [NSUserDefaults user];
    [service loadMolleageWithUserID:user.userID completion:^(BOOL success, YLYUser *user, NSString *msg) {
        
    }];
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
