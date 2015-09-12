//
//  OrderViewController.m
//  orderTest
//
//  Created by wangxu on 15/9/12.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "OrderViewController.h"
#import "YLYTipsTextField.h"

@interface OrderViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YLYTipsTextField *startPosition;
@property (nonatomic, strong) YLYTipsTextField *passPosition;
@property (nonatomic, strong) YLYTipsTextField *orderTime;
@property (nonatomic, strong) YLYTipsTextField *passengerTextField;
@property (nonatomic, strong) YLYTipsTextField *orderPersonTextField;

@end

@implementation OrderViewController
{
    CGFloat _gap;
    CGFloat _cellHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _gap = 10;
    _cellHeight = 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 49)];
    [self.view addSubview:scrollView];
    
    _startPosition = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, 0, self.view.width - _gap * 2, _cellHeight)];
    [scrollView addSubview:_startPosition];
    
    _passPosition = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, _startPosition.bottom, _startPosition.width, _cellHeight)];
    [scrollView addSubview:_passPosition];
    
    _orderTime = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, _passPosition.bottom, _startPosition.width, _cellHeight)];
    [scrollView addSubview:_orderTime];
    
    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(_gap, _orderTime.bottom, _startPosition.width, _cellHeight)];
    [scrollView addSubview:timeView];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, _cellHeight)];
    [timeView addSubview:timeLabel];
    UIButton *startTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startTimeButton.frame = CGRectMake(timeLabel.right, 0, (_startPosition.width - timeLabel.width - 40)/2.0, _cellHeight);
    [timeView addSubview:startTimeButton];
    UIButton *endTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    endTimeButton.frame = CGRectMake(startTimeButton.right + 40, 0, startTimeButton.width, _cellHeight);
    [timeView addSubview:endTimeButton];
    
    UIView *typeView = [[UIView alloc] initWithFrame:CGRectMake(_gap, timeView.bottom, _startPosition.width, _cellHeight)];
    [scrollView addSubview:typeView];
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, _cellHeight)];
    [typeView addSubview:typeLabel];
    UIButton *typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    typeButton.frame = CGRectMake(typeLabel.right, 0, _startPosition.width - typeLabel.width, _cellHeight);
    [typeView addSubview:typeButton];
    
    UIView *driverView = [[UIView alloc] initWithFrame:CGRectMake(_gap, typeView.bottom, _startPosition.width, _cellHeight)];
    [scrollView addSubview:driverView];
    UILabel *driverLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, _cellHeight)];
    [driverView addSubview:driverLabel];
    UIButton *driverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    driverButton.frame = CGRectMake(driverLabel.right, 0, _startPosition.width - driverLabel.width, _cellHeight);
    [driverView addSubview:driverButton];
    
    _passengerTextField = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, driverView.bottom, _startPosition.width, _cellHeight)];
    [scrollView addSubview:_passengerTextField];
    
    _orderPersonTextField = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, _passengerTextField.bottom, _startPosition.width, _cellHeight)];
    [scrollView addSubview:_orderPersonTextField];
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
