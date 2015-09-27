//
//  MilViewController.m
//  orderTest
//
//  Created by wangxu on 15/9/12.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "MilViewController.h"
#import "RecordTableViewCell.h"
#import "MilTableViewCell.h"
#import "Service.h"

@interface MilViewController ()

@property (nonatomic, strong) NSArray *orderList;

@end

@implementation MilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的订车里程";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    Service *service = [[Service alloc] init];
    YLYUser *user = [NSUserDefaults user];
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
    [service loadMolleageWithUserID:user.userID completion:^(BOOL success, NSArray *ordersArray, NSString *msg) {
        [DejalActivityView removeView];
        if (success) {
            self.orderList = ordersArray;
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.orderList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kMilTableViewCell = @"kMilTableViewCell";
    MilTableViewCell *milTableViewCell = [tableView dequeueReusableCellWithIdentifier:kMilTableViewCell];
    if (milTableViewCell == nil) {
        milTableViewCell = [[MilTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMilTableViewCell];
        milTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    milTableViewCell.order = self.orderList[indexPath.row];
    return milTableViewCell;
}

@end
