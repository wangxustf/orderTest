//
//  HomeViewController.m
//  orderTest
//
//  Created by wangxu on 15/9/12.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "HomeViewController.h"
#import "DriverListViewController.h"
#import "CarListViewController.h"
#import "RecordListViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
{
    CGFloat _width;
    CGFloat _height;
    CGFloat _subHeight;
    CGFloat _gap;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    
    _gap = 10;
    _height = (self.view.height - 64 - 49 - _gap * 8) / 5.0;
    _width = (self.view.width - _gap * 3) / 3.0;
    _subHeight = (_height - _gap / 2.0) / 2.0;
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didClickCarList
{
    CarListViewController *carListViewController = [[CarListViewController alloc] init];
    carListViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:carListViewController animated:YES];
}

- (void)didClickDriverList
{
    DriverListViewController *driverListViewController = [[DriverListViewController alloc] init];
    driverListViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:driverListViewController animated:YES];
}

- (void)didClickRecordList
{
    RecordListViewController *recordListViewController = [[RecordListViewController alloc] init];
    recordListViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:recordListViewController animated:YES];
}

- (void)didClickOrderCar
{
    self.tabBarController.selectedIndex = 1;
}

- (void)didClickServerCenter
{
    self.tabBarController.selectedIndex = 2;
}

- (void)didClickEmpty
{
    
}

- (void)setupUI
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_gap, _gap, self.view.width - _gap * 2, _height)];
    imageView.image = [UIImage imageNamed:@"homebg.png"];
    [self.view addSubview:imageView];
    
    NSArray *titles = @[@[@"基础\n信息", @"车辆信息", @"司机信息", @"我的收藏", @"订车记录"], @[@"订车", @"订车", @"我的订车", @"历史记录", @"客服中心"], @[@"维修•保养", @"车辆保养", @"维修预约", @"车辆保养", @"保养常识"], @[@"年检•违章", @"违章查询", @"代办违章", @"代办年检", @"会员服务"]];
    NSArray *colors = @[[UIColor blueColor], [UIColor orangeColor], [UIColor greenColor], [UIColor redColor]];
    NSArray *selectorString = @[@[@"didClickEmpty", @"didClickCarList", @"didClickDriverList", @"didClickEmpty", @"didClickRecordList"], @[@"didClickEmpty", @"didClickOrderCar", @"didClickRecordList", @"didClickRecordList", @"didClickServerCenter"], @[@"didClickEmpty", @"didClickEmpty", @"didClickEmpty", @"didClickEmpty", @"didClickEmpty"], @[@"didClickEmpty", @"didClickEmpty", @"didClickEmpty", @"didClickEmpty", @"didClickEmpty"]];
    CGFloat top = imageView.bottom + 2 * _gap;
    for (int i = 0; i < 4; i++) {
        UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
        button0.frame = CGRectMake(_gap, top, _width, _height);
        [button0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button0.backgroundColor = colors[i];
        [button0 setTitle:titles[i][0] forState:UIControlStateNormal];
        button0.titleLabel.numberOfLines = 2;
        [button0 addTarget:self action:NSSelectorFromString(selectorString[i][0]) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button0];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(button0.right + _gap / 2.0, button0.top, _width, _subHeight);
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button1.backgroundColor = button0.backgroundColor;
        [button1 setTitle:titles[i][1] forState:UIControlStateNormal];
        [button1 addTarget:self action:NSSelectorFromString(selectorString[i][1]) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button1];
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(button1.left, button1.top + _subHeight + _gap / 2.0, _width, _subHeight);
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button2.backgroundColor = button0.backgroundColor;
        [button2 setTitle:titles[i][2] forState:UIControlStateNormal];
        [button2 addTarget:self action:NSSelectorFromString(selectorString[i][2]) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button2];
        
        UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        button3.frame = CGRectMake(button1.right + _gap / 2.0, button1.top, _width, _subHeight);
        [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button3.backgroundColor = button0.backgroundColor;
        [button3 setTitle:titles[i][3] forState:UIControlStateNormal];
        [button3 addTarget:self action:NSSelectorFromString(selectorString[i][3]) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button3];
        
        UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        button4.frame = CGRectMake(button3.left, button2.top, _width, _subHeight);
        [button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button4.backgroundColor = button0.backgroundColor;
        [button4 setTitle:titles[i][4] forState:UIControlStateNormal];
        [button4 addTarget:self action:NSSelectorFromString(selectorString[i][4]) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button4];
        
        button0.titleLabel.font = button1.titleLabel.font = button2.titleLabel.font = button3.titleLabel.font = button4.titleLabel.font = BoldFont(20.0);
        
        top = top + _height + _gap;
    }
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
