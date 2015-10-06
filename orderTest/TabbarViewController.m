//
//  YLYTabBarViewController.m
//  E6BusinessMobile
//
//  Created by wangxu on 15/9/2.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "TabbarViewController.h"
#import "HomeViewController.h"
#import "OrderViewController.h"
#import "ServiceViewController.h"
#import "MineViewController.h"
#import "YLYLoginViewController.h"
#import "RecordViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.tabBar.barTintColor = [UIColor yellowColor];
    self.tabBar.tintColor = RGB(0xffffff);
    
    [self setupViewControllers];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupViewControllers];
    
    YLYUser *user = [NSUserDefaults user];
    if (!user) {
        UINavigationController *loginViewController = [[UINavigationController alloc] initWithRootViewController:[[YLYLoginViewController alloc] init]];
        loginViewController.navigationBar.barTintColor = RGB(kMainColor);
        loginViewController.navigationBar.tintColor = [UIColor blueColor];
        [loginViewController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
}

- (void)setupViewControllers
{
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    UITabBarItem *homeTabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"icon_TabBar_Session.png"] selectedImage:nil];
    OrderViewController *orderViewController = [[OrderViewController alloc] init];
    RecordViewController *recordViewController = [[RecordViewController alloc] init];
    recordViewController.isTab = YES;
    UITabBarItem *orderTabBarItem = [[UITabBarItem alloc] initWithTitle:@"订车" image:[UIImage imageNamed:@"icon_TabBar_Plan.png"] selectedImage:nil];
    ServiceViewController *serviceViewController = [[ServiceViewController alloc] init];
    UITabBarItem *serviceTabBarItem = [[UITabBarItem alloc] initWithTitle:@"客服中心" image:[UIImage imageNamed:@"icon_TabBar_Forum.png"] selectedImage:nil];
    MineViewController *mineViewController = [[MineViewController alloc] init];
    UITabBarItem *mineTabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"icon_TabBar_People.png"] selectedImage:nil];
    
    NSArray *viewControllers = @[homeViewController, orderViewController, serviceViewController, mineViewController];
    YLYUser *user = [NSUserDefaults user];
    if (user.userType != UserTypeDingche) {
        viewControllers = @[homeViewController, recordViewController, serviceViewController, mineViewController];
    }
    NSArray *tabBarItems = @[homeTabBarItem, orderTabBarItem, serviceTabBarItem, mineTabBarItem];
    NSMutableArray *navigationControllers = [NSMutableArray array];
    for (UIViewController *viewController in viewControllers) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        navigationController.navigationBar.barTintColor = RGB(kMainColor);
        navigationController.navigationBar.tintColor = [UIColor blackColor];
        [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        navigationController.tabBarItem = tabBarItems[[viewControllers indexOfObject:viewController]];
        [navigationControllers addObject:navigationController];
    }
    
    self.viewControllers = navigationControllers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
