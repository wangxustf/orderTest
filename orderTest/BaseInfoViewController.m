//
//  BaseInfoViewController.m
//  orderTest
//
//  Created by wangxu on 15/9/27.
//  Copyright © 2015年 wangxu. All rights reserved.
//

#import "BaseInfoViewController.h"
#import "TipsLabel.h"

@interface BaseInfoViewController ()

@end

@implementation BaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"基础信息";
    
    NSArray *tipsArray = @[@"姓名", @"手机", @"部门", @"用户类型"];
    YLYUser *user = [NSUserDefaults user];
    NSArray *valuesArray = @[user.username, user.phone, user.depName, user.userTypeName];
    CGFloat top = 10;
    CGFloat gap = 10;
    CGFloat height = 44;
    for (int i = 0; i < 4; i++) {
        TipsLabel *label = [[TipsLabel alloc] initWithFrame:CGRectMake(0, top, self.view.width, height)];
        [label setWithTip:tipsArray[i] value:valuesArray[i]];
        [self.view addSubview:label];
        top += gap + height;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
