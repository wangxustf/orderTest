//
//  RecordViewController.m
//  orderTest
//
//  Created by wangxu on 15/9/12.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordListViewController.h"
#import "ChoiceSegmentedView.h"
#import "Service.h"

@class OrderViewController;
@interface RecordViewController ()

@property (nonatomic, strong) RecordListViewController *unfinishedRecordListViewController;
@property (nonatomic, strong) RecordListViewController *jinxingzhongRecordListViewController;
@property (nonatomic, strong) RecordListViewController *finishedRecordListViewController;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, strong) ChoiceSegmentedView *segmentedView;
@property (nonatomic, strong) YLYUser *user;

@end

@implementation RecordViewController

- (id)init
{
    if (self = [super init]) {
        _unfinishedRecordListViewController= [[RecordListViewController alloc] initWithFinishType:FinishTypeUnfinished];
        _jinxingzhongRecordListViewController= [[RecordListViewController alloc] initWithFinishType:FinishTypeJinxingzhong];
        _finishedRecordListViewController = [[RecordListViewController alloc] initWithFinishType:FinishTypeFinished];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的订车记录";
    
    self.view.height = self.view.height - self.navigationController.navigationBar.height - 20;
    self.user = [NSUserDefaults user];
    
    _unfinishedRecordListViewController.isTab = _finishedRecordListViewController.isTab = self.isTab;
    if (self.user.userType == UserTypeDriver) {
        _jinxingzhongRecordListViewController.isTab = self.isTab;
    }
    _unfinishedRecordListViewController.view.frame = CGRectMake(0, 0, self.view.width, self.view.height - self.segmentedView.height - (self.isTab ? 49 : 0));
    __weak typeof(self) weakSelf = self;
    _unfinishedRecordListViewController.tongguoBlock = ^(Order *order) {
        if (weakSelf.user.userType == UserTypeDriver) {
            if ([order.orderState integerValue] == 5) {
                if (![weakSelf.finishedRecordListViewController parentViewController]) {
                    weakSelf.finishedRecordListViewController.view.frame = CGRectMake(0, 0, weakSelf.view.width, weakSelf.view.height - weakSelf.segmentedView.height);
                    [weakSelf addChildViewController:weakSelf.finishedRecordListViewController];
                }
                [weakSelf.jinxingzhongRecordListViewController addOrder:order];
            } else {
                if (![weakSelf.jinxingzhongRecordListViewController parentViewController]) {
                    weakSelf.jinxingzhongRecordListViewController.view.frame = CGRectMake(0, 0, weakSelf.view.width, weakSelf.view.height - weakSelf.segmentedView.height);
                    [weakSelf addChildViewController:weakSelf.jinxingzhongRecordListViewController];
                }
                [weakSelf.jinxingzhongRecordListViewController addOrder:order];
            }
        } else {
            if (![weakSelf.finishedRecordListViewController parentViewController]) {
                weakSelf.finishedRecordListViewController.view.frame = CGRectMake(0, 0, weakSelf.view.width, weakSelf.view.height - weakSelf.segmentedView.height);
                [weakSelf addChildViewController:weakSelf.finishedRecordListViewController];
            }
            [weakSelf.finishedRecordListViewController addOrder:order];
        }
    };
    [self addChildViewController:self.unfinishedRecordListViewController];
    self.currentViewController = self.unfinishedRecordListViewController;
    [self.view addSubview:self.currentViewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didClickChoiceSegmentView:(NSInteger)index
{
    index = index + 1;
    if ((self.currentViewController == self.unfinishedRecordListViewController && index == 1) ||
        (self.currentViewController == self.finishedRecordListViewController && index == 2)) {
        return;
    }
    switch (index) {
        case 1:
        {
            [self transitionFromViewController:self.currentViewController toViewController:self.unfinishedRecordListViewController duration:0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = self.unfinishedRecordListViewController;
                }
            }];
        }
            break;
        case 2:
        {
            if (![self.finishedRecordListViewController parentViewController]) {
                self.finishedRecordListViewController.view.frame = CGRectMake(0, 0, self.view.width, self.view.height - self.segmentedView.height);
                [self addChildViewController:self.finishedRecordListViewController];
            }
            [self transitionFromViewController:self.currentViewController toViewController:self.finishedRecordListViewController duration:0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = self.finishedRecordListViewController;
                }
            }];
        }
            break;
    }
}

- (void)didClickChoiceSegmentView1:(NSInteger)index
{
    index = index + 1;
    if ((self.currentViewController == self.unfinishedRecordListViewController && index == 1) ||
        (self.currentViewController == self.jinxingzhongRecordListViewController && index == 2) ||
        (self.currentViewController == self.finishedRecordListViewController && index == 3)) {
        return;
    }
    switch (index) {
        case 1:
        {
            [self transitionFromViewController:self.currentViewController toViewController:self.unfinishedRecordListViewController duration:0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = self.unfinishedRecordListViewController;
                }
            }];
        }
            break;
        case 2:
        {
            if (![self.jinxingzhongRecordListViewController parentViewController]) {
                self.jinxingzhongRecordListViewController.view.frame = CGRectMake(0, 0, self.view.width, self.view.height - self.segmentedView.height);
                [self addChildViewController:self.jinxingzhongRecordListViewController];
            }
            [self transitionFromViewController:self.currentViewController toViewController:self.jinxingzhongRecordListViewController duration:0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = self.jinxingzhongRecordListViewController;
                }
            }];
        }
            break;
        case 3:
        {
            if (![self.finishedRecordListViewController parentViewController]) {
                self.finishedRecordListViewController.view.frame = CGRectMake(0, 0, self.view.width, self.view.height - self.segmentedView.height);
                [self addChildViewController:self.finishedRecordListViewController];
            }
            [self transitionFromViewController:self.currentViewController toViewController:self.finishedRecordListViewController duration:0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = self.finishedRecordListViewController;
                }
            }];
        }
            break;
    }
}

#pragma mark - getter/setter

- (ChoiceSegmentedView *)segmentedView
{
    if (!_segmentedView) {
        _segmentedView = [[ChoiceSegmentedView alloc] initWithFrame:CGRectMake(0, self.view.height - 44 - (self.isTab ? 49 : 0), self.view.width, 44)];
        _segmentedView.layer.borderColor = [UIColor whiteColor].CGColor;
        _segmentedView.layer.borderWidth = 1.0;
        _segmentedView.layer.cornerRadius = 2.5;
        _segmentedView.backgroundColor = [UIColor clearColor];
        
        NSArray *contents = @[@"未完成", @"已完成"];
        if (self.user.userType == UserTypeDriver) {
            contents = @[@"未完成", @"进行中", @"已完成"];
        }
        [_segmentedView setWithSize2:CGSizeMake(_segmentedView.width, _segmentedView.height)
                   backImageViewName:nil
                     segmentedNumber:[contents count]
                            contents:contents
                              images:nil
                    backgroundColors:@[RGB(kMainColor), [UIColor whiteColor]]
                              colors:@[[UIColor whiteColor], RGB(kMainColor)]
                         selectedNum:0
                            fontSize:14];
        __weak typeof(self) weakSelf = self;
        _segmentedView.forumSegmentedBlock = ^(NSInteger clickNumber){
            if (weakSelf.user.userType == UserTypeDriver) {
                [weakSelf didClickChoiceSegmentView1:clickNumber];
            } else {
                [weakSelf didClickChoiceSegmentView:clickNumber];
            }
        };
        [self.view addSubview:_segmentedView];
    }
    return  _segmentedView;
}

@end
