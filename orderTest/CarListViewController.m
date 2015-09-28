//
//  DriverListViewController.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "CarListViewController.h"
#import "SubCarListViewController.h"
#import "CarTableViewCell.h"
#import "Service.h"

@interface CarListViewController ()

@property (nonatomic, strong) SubCarListViewController *jingjiCarListViewController;
@property (nonatomic, strong) SubCarListViewController *shushiCarListViewController;
@property (nonatomic, strong) SubCarListViewController *haohuaJingjiCarListViewController;
@property (nonatomic, strong) SubCarListViewController *shangWuJingjiCarListViewController;
@property (nonatomic, strong) SubCarListViewController *zuo16JingjiCarListViewController;
@property (nonatomic, strong) SubCarListViewController *zuo32JingjiCarListViewController;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *buttonsArray;

@end

@implementation CarListViewController

- (id)init
{
    if (self = [super init]) {
        _jingjiCarListViewController = [[SubCarListViewController alloc] initWithCarType:CarTypeJingji];
        _shushiCarListViewController = [[SubCarListViewController alloc] initWithCarType:CarTypeShushi];
        _haohuaJingjiCarListViewController = [[SubCarListViewController alloc] initWithCarType:CarTypeHaohua];
        _shangWuJingjiCarListViewController = [[SubCarListViewController alloc] initWithCarType:CarTypeShangwu];
        _zuo16JingjiCarListViewController = [[SubCarListViewController alloc] initWithCarType:CarType16zuo];
        _zuo32JingjiCarListViewController = [[SubCarListViewController alloc] initWithCarType:CarType32zuo];
        _jingjiCarListViewController.selectBlock = _shushiCarListViewController.selectBlock = _haohuaJingjiCarListViewController.selectBlock = _shangWuJingjiCarListViewController.selectBlock = _zuo16JingjiCarListViewController.selectBlock = _zuo32JingjiCarListViewController.selectBlock = self.selectBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.title = @"车辆信息";
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    [self.view addSubview:_scrollView];
    NSArray *imageArray = @[@"icon_jingji.png", @"icon_shushi.png", @"icon_haohua.png", @"icon_shangwu.png", @"icon_16zuo.png", @"icon_32zuo.png"];
    NSArray *imageSelectedArray = @[@"icon_jingji_selected.png", @"icon_shushi_selected.png", @"icon_haohua_selected.png", @"icon_shangwu_selected.png", @"icon_16zuo_selected.png", @"icon_32zuo_selected.png"];
    self.buttonsArray = [NSMutableArray array];
    CGFloat gap = 10;
    CGFloat width = self.view.width / 6.0;
    for(int i = 0; i < 6; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:imageSelectedArray[i]] forState:UIControlStateSelected];
        button.frame = CGRectMake(width * i, 0, 44, width);
        button.tag = i;
        if (i == 0) {
            button.selected = YES;
        }
        [button addTarget:self action:@selector(didClickChoiceSegmentView:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
        [self.buttonsArray addObject:button];
    }
    _scrollView.contentSize = CGSizeMake(_scrollView.width, 44);
    
    _jingjiCarListViewController.view.frame = CGRectMake(0, _scrollView.bottom, self.view.width, self.view.height - 64 - _scrollView.bottom);
    [self addChildViewController:self.jingjiCarListViewController];
    self.currentViewController = self.jingjiCarListViewController;
    [self.view addSubview:self.currentViewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didClickChoiceSegmentView:(UIButton *)sender
{
    for (UIButton *button in self.buttonsArray) {
        button.selected = (button == sender) ? YES : NO;
    }
    NSInteger index = sender.tag + 1;
    if ((self.currentViewController == self.jingjiCarListViewController && index == 1) ||
        (self.currentViewController == self.shushiCarListViewController && index == 2) ||
        (self.currentViewController == self.haohuaJingjiCarListViewController && index == 3) ||
        (self.currentViewController == self.shangWuJingjiCarListViewController && index == 4) ||
        (self.currentViewController == self.zuo16JingjiCarListViewController && index == 5) ||
        (self.currentViewController == self.zuo32JingjiCarListViewController && index == 6)) {
        return;
    }
    switch (index) {
        case 1:
        {
            [self transitionFromViewController:self.currentViewController toViewController:self.jingjiCarListViewController duration:0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = self.jingjiCarListViewController;
                }
            }];
        }
            break;
        case 2:
        {
            if (![self.shushiCarListViewController parentViewController]) {
                self.shushiCarListViewController.view.frame = CGRectMake(0, _scrollView.bottom, self.view.width, self.view.height - _scrollView.bottom);
                [self addChildViewController:self.shushiCarListViewController];
            }
            [self transitionFromViewController:self.currentViewController toViewController:self.shushiCarListViewController duration:0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = self.shushiCarListViewController;
                }
            }];
        }
            break;
        case 3:
        {
            if (![self.haohuaJingjiCarListViewController parentViewController]) {
                self.haohuaJingjiCarListViewController.view.frame = CGRectMake(0, _scrollView.bottom, self.view.width, self.view.height - _scrollView.bottom);
                [self addChildViewController:self.haohuaJingjiCarListViewController];
            }
            [self transitionFromViewController:self.currentViewController toViewController:self.haohuaJingjiCarListViewController duration:0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = self.haohuaJingjiCarListViewController;
                }
            }];
        }
            break;
        case 4:
        {
            if (![self.shangWuJingjiCarListViewController parentViewController]) {
                self.shangWuJingjiCarListViewController.view.frame = CGRectMake(0, _scrollView.bottom, self.view.width, self.view.height - _scrollView.bottom);
                [self addChildViewController:self.shangWuJingjiCarListViewController];
            }
            [self transitionFromViewController:self.currentViewController toViewController:self.shangWuJingjiCarListViewController duration:0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = self.shangWuJingjiCarListViewController;
                }
            }];
        }
            break;
        case 5:
        {
            if (![self.zuo16JingjiCarListViewController parentViewController]) {
                self.zuo16JingjiCarListViewController.view.frame = CGRectMake(0, _scrollView.bottom, self.view.width, self.view.height - _scrollView.bottom);
                [self addChildViewController:self.zuo16JingjiCarListViewController];
            }
            [self transitionFromViewController:self.currentViewController toViewController:self.zuo16JingjiCarListViewController duration:0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = self.zuo16JingjiCarListViewController;
                }
            }];
        }
            break;
        case 6:
        {
            if (![self.zuo32JingjiCarListViewController parentViewController]) {
                self.zuo32JingjiCarListViewController.view.frame = CGRectMake(0, _scrollView.bottom, self.view.width, self.view.height - _scrollView.bottom);
                [self addChildViewController:self.zuo32JingjiCarListViewController];
            }
            [self transitionFromViewController:self.currentViewController toViewController:self.zuo32JingjiCarListViewController duration:0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = self.zuo32JingjiCarListViewController;
                }
            }];
        }
            break;
    }
}

@end
