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
#import "PullTableView.h"

@interface RecordListViewController () <UITableViewDataSource, UITableViewDelegate, PullTableViewDelegate>

@property (nonatomic, strong) PullTableView *tableView;
@property (nonatomic, strong) NSMutableArray *orderList;
@property (nonatomic, strong) Service *service;
@property (nonatomic, strong) YLYUser *user;

@end

@implementation RecordListViewController

- (id)initWithFinishType:(FinishType)finishType
{
    if (self = [super init]) {
        _finishType = finishType;
        _orderList = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.title = @"订车纪录";
    
    _service = [[Service alloc] init];
    self.user = [NSUserDefaults user];
    self.view.height = self.view.height - 64 - 44 - (self.isTab ? 49 : 0);
    self.tableView.hidden = NO;
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

- (void)addOrder:(Order *)order
{
    [self.orderList addObject:order];
    [self.tableView reloadData];
}

- (void)refreshTableView
{
    [self.service resetPage];
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
    [self.service loadOrderListWithUserID:self.user.userID isFinish:(_finishType == FinishTypeFinished) isDriver:(self.user.userType == UserTypeDriver) completion:^(BOOL success, NSArray *ordersArray, NSString *msg) {
        [DejalBezelActivityView removeView];
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
    [self.service loadOrderListWithUserID:self.user.userID isFinish:(_finishType == FinishTypeFinished) isDriver:(self.user.userType == UserTypeDriver) completion:^(BOOL success, NSArray *ordersArray, NSString *msg) {
        [DejalBezelActivityView removeView];
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
    recordTableViewCell.finished = (_finishType == FinishTypeFinished);
    recordTableViewCell.order = self.orderList[indexPath.row];
    return recordTableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.user.userType == UserTypeDingche) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    OrderViewController *orderViewController = [[OrderViewController alloc] init];
    orderViewController.hidesBottomBarWhenPushed = YES;
    orderViewController.finished = (_finishType == FinishTypeFinished);
    Order *order = self.orderList[indexPath.row];
    orderViewController.order = order;
    orderViewController.tongguoBlock = ^ {
        [self.orderList removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        if (_tongguoBlock) {
            _tongguoBlock(order);
        }
    };
    [self.navigationController pushViewController:orderViewController animated:YES];
}

#pragma mark -- getter

- (PullTableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _tableView.backgroundColor = RGB(0xffffff);
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
