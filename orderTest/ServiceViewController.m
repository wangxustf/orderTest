//
//  ServiceViewController.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "ServiceViewController.h"
#import "ImageButton.h"

@interface ServiceViewController ()

@property (nonatomic, strong) ImageButton *telImageButton;

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"客服中心";
    
    _telImageButton = [ImageButton buttonWithType:UIButtonTypeCustom];
    _telImageButton.frame = CGRectMake(0, 0, self.view.width, 44);
    [_telImageButton setWithText:@"18710889507" imageName:@"phone.jpg"];
    [_telImageButton addTarget:self action:@selector(didClickTelImageButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_telImageButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didClickTelImageButton:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://13096917736"]];
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
