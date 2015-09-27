//
//  DriverListViewController.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "DriverListViewController.h"
#import "DriverTableViewCell.h"
#import "Service.h"

@interface DriverListViewController ()

@property (nonatomic, strong) NSArray *driverList;

@end

@implementation DriverListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.title = @"司机信息";
    
    Service *service = [[Service alloc] init];
    YLYUser *user = [NSUserDefaults user];
    [service loadDriverWithCarID:@"" completion:^(BOOL success, YLYUser *user, NSString *msg) {
        
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
    return 10;//[self.driverList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kDriverTableViewCell = @"kDriverTableViewCell";
    DriverTableViewCell *driverTableViewCell = [tableView dequeueReusableCellWithIdentifier:kDriverTableViewCell];
    if (driverTableViewCell == nil) {
        driverTableViewCell = [[DriverTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDriverTableViewCell];
        driverTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    driverTableViewCell.driver = self.driverList[indexPath.row];
    return driverTableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectBlock) {
        _selectBlock(self.driverList[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
