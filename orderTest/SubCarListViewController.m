//
//  SubCarListViewController.m
//  orderTest
//
//  Created by wangxu on 15/9/27.
//  Copyright © 2015年 wangxu. All rights reserved.
//

#import "SubCarListViewController.h"
#import "CarTableViewCell.h"
#import "Service.h"

@implementation SubCarListViewController

- (id)initWithCarType:(CarType)carType
{
    if (self = [super init]) {
        _carType = carType;
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
    [service loadCarListWithDriverID:user.userID carType:[@(_carType) stringValue] completion:^(BOOL success, NSArray *carsArray, NSString *msg) {
        [DejalBezelActivityView removeView];
        if (success) {
            self.carList = carsArray;
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.carList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCarTableViewCell = @"kCarTableViewCell";
    CarTableViewCell *carTableViewCell = [tableView dequeueReusableCellWithIdentifier:kCarTableViewCell];
    if (carTableViewCell == nil) {
        carTableViewCell = [[CarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCarTableViewCell];
        carTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        carTableViewCell.carType = self.carType;
    }
    carTableViewCell.car = self.carList[indexPath.row];
    return carTableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectBlock) {
        _selectBlock(self.carList[indexPath.row]);
    }
}

@end
