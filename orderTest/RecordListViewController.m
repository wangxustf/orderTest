//
//  DriverListViewController.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "RecordListViewController.h"
#import "RecordTableViewCell.h"
#import "OrderViewController.h"
#import "Service.h"

@interface RecordListViewController ()

@property (nonatomic, strong) NSArray *orderList;

@end

@implementation RecordListViewController

- (id)initWithFinishType:(FinishType)finishType
{
    if (self = [super init]) {
        _finishType = finishType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.title = @"订车纪录";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    Service *service = [[Service alloc] init];
    YLYUser *user = [NSUserDefaults user];
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
    if (_finishType) {
        [service loadDincheYiwanchengWithUserID:user.userID completion:^(BOOL success, NSArray *ordersArray, NSString *msg) {
            [DejalBezelActivityView removeView];
            if (success) {
                self.orderList = ordersArray;
                [self.tableView reloadData];
            }
        }];
    } else {
        [service loadDincheWeiwanchengWithUserID:user.userID completion:^(BOOL success, NSArray *ordersArray, NSString *msg) {
            [DejalBezelActivityView removeView];
            if (success) {
                self.orderList = ordersArray;
                [self.tableView reloadData];
            }
        }];
    }
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
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.orderList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kRecordTableViewCell = @"kRecordTableViewCell";
    RecordTableViewCell *recordTableViewCell = [tableView dequeueReusableCellWithIdentifier:kRecordTableViewCell];
    if (recordTableViewCell == nil) {
        recordTableViewCell = [[RecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kRecordTableViewCell];
        recordTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    recordTableViewCell.order = self.orderList[indexPath.row];
    return recordTableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderViewController *orderViewController = [[OrderViewController alloc] init];
    [self.navigationController pushViewController:orderViewController animated:YES];
}

@end
