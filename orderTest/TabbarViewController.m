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
#import "MineViewController.h"
#import "YLYLoginViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.tabBar.barTintColor = [UIColor yellowColor];
    self.tabBar.tintColor = [UIColor greenColor];
    
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    UITabBarItem *homeTabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:nil selectedImage:nil];
    OrderViewController *orderViewController = [[OrderViewController alloc] init];
    UITabBarItem *orderTabBarItem = [[UITabBarItem alloc] initWithTitle:@"管理状态" image:nil selectedImage:nil];
    MineViewController *mineViewController = [[MineViewController alloc] init];
    UITabBarItem *mineTabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:nil selectedImage:nil];
    
    NSArray *viewControllers = @[homeViewController, orderViewController, mineViewController];
    NSArray *tabBarItems = @[homeTabBarItem, orderTabBarItem, mineTabBarItem];
    NSMutableArray *navigationControllers = [NSMutableArray array];
    for (UIViewController *viewController in viewControllers) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        navigationController.navigationBar.barTintColor = [UIColor redColor];
        navigationController.navigationBar.tintColor = [UIColor blueColor];
        [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        navigationController.tabBarItem = tabBarItems[[viewControllers indexOfObject:viewController]];
        [navigationControllers addObject:navigationController];
    }
    
    self.viewControllers = navigationControllers;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    YLYUser *user = [NSUserDefaults user];
//    if (!user) {
//        UINavigationController *loginViewController = [[UINavigationController alloc] initWithRootViewController:[[YLYLoginViewController alloc] init]];
//        [self presentViewController:loginViewController animated:YES completion:nil];
//    }
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
