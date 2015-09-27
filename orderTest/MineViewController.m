//
//  MineViewController.m
//  orderTest
//
//  Created by wangxu on 15/9/12.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "MineViewController.h"
#import "CollectViewController.h"
#import "RecordViewController.h"
#import "MilViewController.h"
#import "ArrowButton.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的";
    
    ArrowButton *collectButton = [ArrowButton buttonWithType:UIButtonTypeCustom];
    collectButton.frame = CGRectMake(0, 0, self.view.width, 0);
    [collectButton addTarget:self action:@selector(didClickCollectButton:) forControlEvents:UIControlEventTouchUpInside];
    collectButton.text = @"收藏";
    collectButton.hidden = YES;
    [self.view addSubview:collectButton];
    
    ArrowButton *recordButton = [ArrowButton buttonWithType:UIButtonTypeCustom];
    recordButton.frame = CGRectMake(0, collectButton.bottom, self.view.width, 44);
    [recordButton addTarget:self action:@selector(didClickRecordButton:) forControlEvents:UIControlEventTouchUpInside];
    recordButton.text = @"我的订车记录";
    [self.view addSubview:recordButton];
    
    ArrowButton *milButton = [ArrowButton buttonWithType:UIButtonTypeCustom];
    milButton.frame = CGRectMake(0, recordButton.bottom, self.view.width, 44);
    [milButton addTarget:self action:@selector(didClickMilButton:) forControlEvents:UIControlEventTouchUpInside];
    milButton.text = @"我的订车里程";
    [self.view addSubview:milButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didClickCollectButton:(id)sender
{
    CollectViewController *collectViewController = [[CollectViewController alloc] init];
    collectViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:collectViewController animated:YES];
}

- (void)didClickRecordButton:(id)sender
{
    RecordViewController *recordViewController = [[RecordViewController alloc] init];
    recordViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:recordViewController animated:YES];
}

- (void)didClickMilButton:(id)sender
{
    MilViewController *milViewController = [[MilViewController alloc] init];
    milViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:milViewController animated:YES];
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
