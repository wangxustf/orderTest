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
#import "PullTableView.h"

@interface MilViewController () <UITableViewDataSource, UITableViewDelegate, PullTableViewDelegate>

@property (nonatomic, strong) PullTableView *tableView;
@property (nonatomic, strong) NSMutableArray *orderList;
@property (nonatomic, strong) Service *service;
@property (nonatomic, strong) YLYUser *user;

@end

@implementation MilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的订车里程";
    
    _service = [[Service alloc] init];
    self.user = [NSUserDefaults user];
    [self refreshTableView];
}

- (void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    _tableView.pullDelegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTableView
{
    [self.service resetPage];
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
    [self.service loadMolleageListWithUserID:self.user.userID completion:^(BOOL success, NSArray *ordersArray, NSString *msg) {
        [DejalActivityView removeView];
        self.tableView.pullTableIsRefreshing = NO;
        if (success) {
            self.orderList = [NSMutableArray arrayWithArray:ordersArray];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self refreshTableView];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self.service loadMolleageListWithUserID:self.user.userID completion:^(BOOL success, NSArray *ordersArray, NSString *msg) {
        [DejalActivityView removeView];
        self.tableView.pullTableIsLoadingMore = NO;
        if (success) {
            [self.orderList addObjectsFromArray:ordersArray];
            [self.tableView reloadData];
        }
    }];
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
        milTableViewCell.width = tableView.width;
    }
    milTableViewCell.order = self.orderList[indexPath.row];
    return milTableViewCell;
}

#pragma mark -- getter

- (PullTableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _tableView.backgroundColor = RGB(0xf0f0f0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.pullDelegate = self;
        _tableView.pullTableViewEnable = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
