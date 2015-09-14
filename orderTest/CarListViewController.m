//
//  DriverListViewController.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "CarListViewController.h"
#import "CarTableViewCell.h"

@interface CarListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation CarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.title = @"车辆信息";
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    _scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_scrollView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _scrollView.bottom, self.view.width, self.view.height - 64 - _scrollView.bottom)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView reloadData];
    CGFloat gap = 10;
    CGFloat left = 10;
    for(int i = 0; i < 10; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(left, 0, 44, 44)];
        imageView.image = [UIImage imageNamed:@"phone.png"];
        [_scrollView addSubview:imageView];
        left = left + 44 + gap;
    }
    _scrollView.contentSize = CGSizeMake(MAX(_scrollView.width, left), 44);
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
    return 66;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCarTableViewCell = @"kCarTableViewCell";
    CarTableViewCell *carTableViewCell = [tableView dequeueReusableCellWithIdentifier:kCarTableViewCell];
    if (carTableViewCell == nil) {
        carTableViewCell = [[CarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCarTableViewCell];
        carTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [carTableViewCell setCar];
    return carTableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
