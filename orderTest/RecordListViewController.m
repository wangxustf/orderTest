//
//  DriverListViewController.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "RecordListViewController.h"
#import "RecordTableViewCell.h"
#import "Service.h"

@interface RecordListViewController ()

@end

@implementation RecordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.title = @"订车纪录";
    
    
    Service *service = [[Service alloc] init];
    YLYUser *user = [NSUserDefaults user];
    [service loadDincheWeiwanchengWithUserID:user.userID completion:^(BOOL success, YLYUser *user, NSString *msg) {
    
    }];
//    [service loadDincheYiwanchengWithUserID:@"" completion:^(BOOL success, YLYUser *user, NSString *msg) {
//        
//    }];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kRecordTableViewCell = @"kRecordTableViewCell";
    RecordTableViewCell *recordTableViewCell = [tableView dequeueReusableCellWithIdentifier:kRecordTableViewCell];
    if (recordTableViewCell == nil) {
        recordTableViewCell = [[RecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kRecordTableViewCell];
        recordTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return recordTableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
