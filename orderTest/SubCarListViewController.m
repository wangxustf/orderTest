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
    
    Service *service = [[Service alloc] init];
    YLYUser *user = [NSUserDefaults user];
    [service loadCarInfoWithDriverID:user.userID carType:[@(_carType) stringValue] completion:^(BOOL success, YLYUser *user, NSString *msg) {
        
    }];
}

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
    return 10;//[self.carList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCarTableViewCell = @"kCarTableViewCell";
    CarTableViewCell *carTableViewCell = [tableView dequeueReusableCellWithIdentifier:kCarTableViewCell];
    if (carTableViewCell == nil) {
        carTableViewCell = [[CarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCarTableViewCell];
        carTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    carTableViewCell.car = self.carList[indexPath.row];
    return carTableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
