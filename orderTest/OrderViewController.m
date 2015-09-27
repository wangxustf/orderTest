//
//  OrderViewController.m
//  orderTest
//
//  Created by wangxu on 15/9/12.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "OrderViewController.h"
#import "RecordListViewController.h"
#import "DriverListViewController.h"
#import "YLYTipsTextField.h"
#import "DashView.h"
#import "ImageButton.h"
#import "Service.h"

@interface OrderViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YLYTipsTextField *startPosition;
@property (nonatomic, strong) YLYTipsTextField *passPosition;
@property (nonatomic, strong) YLYTipsTextField *orderTime;
@property (nonatomic, strong) UITextField *startTimeTextField;
@property (nonatomic, strong) UITextField *endTimeTextField;
@property (nonatomic, strong) ImageButton *startTimeButton;
@property (nonatomic, strong) ImageButton *endTimeButton;
@property (nonatomic, strong) UITextField *carTypeTextField;
@property (nonatomic, strong) ImageButton *carTypeButton;
@property (nonatomic, strong) UILabel *driverNameLabel;
@property (nonatomic, strong) UILabel *driverPhoneLabel;
@property (nonatomic, strong) UITextField *passengerNameTextField;
@property (nonatomic, strong) UITextField *passengerPhoneTextField;
@property (nonatomic, strong) UILabel *orderPersonNameLabel;
@property (nonatomic, strong) UILabel *orderPersonPhoneLabel;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UITextField *currentTextField;
@property (nonatomic, strong) NSArray *carArray;
@property (nonatomic, assign) NSInteger selectedCarRow;
@property (nonatomic, strong) UIButton *orderButton;
@property (nonatomic, strong) UIButton *checkButton;
@property (nonatomic, strong) UIButton *rejectButton;
@property (nonatomic, strong) Driver *driver;

@end

@implementation OrderViewController
{
    CGFloat _gap;
    CGFloat _cellHeight;
    CGSize _contentSize;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"订车";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"订车历史" style:UIBarButtonItemStyleDone target:self action:@selector(didClickRightBarButtonItem:)];
    _gap = 0;
    _cellHeight = 60;
    _carArray = @[@"经济型", @"舒适型", @"商务型", @"豪华型", @"16座客车", @"32座客车"];
    _selectedCarRow = 0;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapGestureRecognizer:)]];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didClickRightBarButtonItem:(id)sender
{
    RecordListViewController *recordListViewController = [[RecordListViewController alloc] init];
    recordListViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:recordListViewController animated:YES];
}

- (void)didTapGestureRecognizer:(id)sender
{
     [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)didClickStartButton:(id)sender
{
    [self.startTimeTextField becomeFirstResponder];
}

- (void)didClickEndButton:(id)sender
{
    [self.endTimeTextField becomeFirstResponder];
}

- (void)didClickTypeButton:(id)sender
{
    [self.carTypeTextField becomeFirstResponder];
}

- (void)didClickDriverButton:(id)sender
{
    DriverListViewController *driverListViewController = [[DriverListViewController alloc] init];
    driverListViewController.selectBlock = ^(Driver *driver) {
        self.driver = driver;
        self.driverNameLabel.text = driver.driverName;
        self.driverPhoneLabel.text = driver.driverPhone;
    };
    driverListViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:driverListViewController animated:YES];
}

- (void)didClickOrderButton:(id)sender
{
    self.checkButton.hidden = self.rejectButton.hidden = NO;
    self.orderButton.hidden = YES;
}

- (void)didClickCheckButton:(id)sender
{
    Service *service = [[Service alloc] init];
    YLYUser *user = [NSUserDefaults user];
    Order *order = [[Order alloc] init];
    order.jiecheAddress = self.startPosition.text;
    order.jingguoAddress = self.passPosition.text;
    order.yuyueTime = self.orderTime.text;
    order.startTime = self.startTimeTextField.text;
    order.endTime = self.endTimeTextField.text;
    order.carType = self.carArray[_selectedCarRow];
    order.userName = self.passengerNameTextField.text;
    order.userPhone = self.passengerPhoneTextField.text;
    order.driverID = self.driver.driverID;
    order.driverName = self.driverNameLabel.text;
    order.driverPhone = self.driverPhoneLabel.text;
    order.dingcherenID = user.userID;
    order.dingcherenDep = user.depName;
    order.dingcherenDepID = user.depID;
    order.dingcherenName = user.username;
    order.dingcherenPhone = user.phone;
//    [service loadDingCheWithOrder:<#(Order *)#> completion:^(BOOL success, YLYUser *user, NSString *msg) {
    
//    }];
}

- (void)didClickRejectButton:(id)sender
{
    
}

//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    self.scrollView.height = self.view.height - keyboardBounds.size.height;
    
    // commit animations
    [UIView commitAnimations];
    self.scrollView.contentOffset = CGPointMake(0, _contentSize.height - self.scrollView.height);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(_contentSize.height, self.scrollView.height));
}

- (void)keyboardWillHide:(NSNotification *)note
{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    self.scrollView.height = self.view.height;
    
    // commit animations
    [UIView commitAnimations];
    self.scrollView.contentSize = _contentSize;
}

- (void)didClickCancelItem:(id)sender
{
    [self.currentTextField resignFirstResponder];
}

- (void)didClickDoneItem:(id)sender
{
    if (self.currentTextField == self.startTimeTextField) {
        self.startTimeButton.text = [NSDate convertStringFromDate:self.datePicker.date];
    } else if (self.currentTextField == self.endTimeTextField) {
        self.endTimeButton.text = [NSDate convertStringFromDate:self.datePicker.date];
    } else {
        self.carTypeButton.text = self.carArray[self.selectedCarRow];
    }
    [self.currentTextField resignFirstResponder];
}

- (void)setupStartTimeTextField
{
    self.startTimeTextField.inputView = self.datePicker;
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.view.width, 44);
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(didClickCancelItem:)];
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(didClickDoneItem:)];
    
    toolbar.items = @[cancelItem, flexibleItem, doneItem];
    self.startTimeTextField.inputAccessoryView = toolbar;
}

- (void)setupEndTimeTextField
{
    self.endTimeTextField.inputView = self.datePicker;
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.view.width, 44);
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(didClickCancelItem:)];
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(didClickDoneItem:)];
    
    toolbar.items = @[cancelItem, flexibleItem, doneItem];
    self.endTimeTextField.inputAccessoryView = toolbar;
}

- (void)setupCarTypeTextField
{
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 300)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    self.carTypeTextField.inputView = pickerView;
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.view.width, 44);
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(didClickCancelItem:)];
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(didClickDoneItem:)];
    
    toolbar.items = @[cancelItem, flexibleItem, doneItem];
    self.carTypeTextField.inputAccessoryView = toolbar;
}

#pragma mark -- UIPickerViewDataSource/Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.carArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.carArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectedCarRow = row;
}
    
- (void)setupUI
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 49)];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    _startPosition = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, 0, self.view.width - _gap * 2, _cellHeight)];
    [_startPosition tipsTextFieldWithTips:@"接车地点" placeholder:@"Type something" isPassword:NO];
    [scrollView addSubview:_startPosition];
    
    _passPosition = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, _startPosition.bottom, _startPosition.width, _cellHeight)];
    [_passPosition tipsTextFieldWithTips:@"经过地点" placeholder:@"高新十字" isPassword:NO];
    [scrollView addSubview:_passPosition];
    
    _orderTime = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, _passPosition.bottom, _startPosition.width, _cellHeight)];
    [_orderTime tipsTextFieldWithTips:@"预约时间" placeholder:[NSDate convertStringFromDate:[NSDate date]] isPassword:NO];
    _orderTime.editEnable = NO;
    [scrollView addSubview:_orderTime];
    
    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(_gap, _orderTime.bottom, _startPosition.width, _cellHeight)];
    [scrollView addSubview:timeView];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, _cellHeight)];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.font = Font(14.0);
    timeLabel.text = @"使用时间";
    [timeView addSubview:timeLabel];
    _startTimeButton = [ImageButton buttonWithType:UIButtonTypeCustom];
    _startTimeButton.frame = CGRectMake(timeLabel.right, 0, (_startPosition.width - timeLabel.width - 40)/2.0, _cellHeight);
    [_startTimeButton addTarget:self action:@selector(didClickStartButton:) forControlEvents:UIControlEventTouchUpInside];
    [_startTimeButton setWithText:nil imageName:@"downArrow.png"];
    [timeView addSubview:_startTimeButton];
    _startTimeButton.fontSize = 10.0;
    _startTimeTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    _startTimeTextField.delegate = self;
    [timeView addSubview:_startTimeTextField];
    [self setupStartTimeTextField];
    UILabel *zhiLabel = [[UILabel alloc] initWithFrame:CGRectMake(_startTimeButton.right, 0, 40, _cellHeight)];
    zhiLabel.textAlignment = NSTextAlignmentCenter;
    zhiLabel.font = Font(14.0);
    zhiLabel.text = @"至";
    [timeView addSubview:zhiLabel];
    _endTimeButton = [ImageButton buttonWithType:UIButtonTypeCustom];
    _endTimeButton.frame = CGRectMake(_startTimeButton.right + 40, 0, _startTimeButton.width, _cellHeight);
    [_endTimeButton addTarget:self action:@selector(didClickEndButton:) forControlEvents:UIControlEventTouchUpInside];
    [_endTimeButton setWithText:nil imageName:@"downArrow.png"];
    [timeView addSubview:_endTimeButton];
    _endTimeButton.fontSize = 10.0;
    _endTimeTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    _endTimeTextField.delegate = self;
    [timeView addSubview:_endTimeTextField];
    [self setupEndTimeTextField];
    
    UIView *typeView = [[UIView alloc] initWithFrame:CGRectMake(_gap, timeView.bottom, _startPosition.width, _cellHeight)];
    [scrollView addSubview:typeView];
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, _cellHeight)];
    typeLabel.textAlignment = NSTextAlignmentLeft;
    typeLabel.font = Font(14.0);
    typeLabel.text = @"选择车型";
    [typeView addSubview:typeLabel];
    _carTypeButton = [ImageButton buttonWithType:UIButtonTypeCustom];
    _carTypeButton.frame = CGRectMake(typeLabel.right, 0, _startPosition.width - typeLabel.width, _cellHeight);
    [_carTypeButton addTarget:self action:@selector(didClickTypeButton:) forControlEvents:UIControlEventTouchUpInside];
    [_carTypeButton setWithText:nil imageName:@"downArrow.png"];
    [typeView addSubview:_carTypeButton];
    _carTypeTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    _carTypeTextField.delegate = self;
    [typeView addSubview:_carTypeTextField];
    [self setupCarTypeTextField];
    
    UIView *driverView = [[UIView alloc] initWithFrame:CGRectMake(_gap, typeView.bottom, _startPosition.width, _cellHeight)];
    [scrollView addSubview:driverView];
    UILabel *driverLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, _cellHeight)];
    driverLabel.textAlignment = NSTextAlignmentLeft;
    driverLabel.font = Font(14.0);
    driverLabel.text = @"选择驾驶员";
    [driverView addSubview:driverLabel];
    _driverNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, _cellHeight/2.0)];
    _driverNameLabel.textAlignment = NSTextAlignmentLeft;
    _driverNameLabel.textColor = [UIColor blackColor];
    [driverView addSubview:_driverNameLabel];
    _driverPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _driverNameLabel.bottom, 100, _cellHeight/2.0)];
    _driverPhoneLabel.textAlignment = NSTextAlignmentLeft;
    _driverPhoneLabel.textColor = [UIColor blackColor];
    [driverView addSubview:_driverPhoneLabel];
    UIButton *driverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    driverButton.frame = CGRectMake(self.view.width - 60, (driverView.height - 40)/2.0, 40, 40);
    [driverButton setBackgroundImage:[UIImage imageNamed:@"addDriver.png"] forState:UIControlStateNormal];
    [driverButton addTarget:self action:@selector(didClickDriverButton:) forControlEvents:UIControlEventTouchUpInside];
    [driverView addSubview:driverButton];
    
    UIView *passengerView = [[UIView alloc] initWithFrame:CGRectMake(_gap, driverView.bottom, _startPosition.width, _cellHeight)];
    [scrollView addSubview:passengerView];
    UILabel *passengerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, _cellHeight)];
    passengerLabel.textAlignment = NSTextAlignmentLeft;
    passengerLabel.textColor = [UIColor blackColor];
    passengerLabel.text = @"乘用者";
    [passengerView addSubview:passengerLabel];
    _passengerNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(passengerLabel.right, 0, self.view.width - passengerLabel.right, _cellHeight/2.0)];
    _passengerNameTextField.placeholder = @"姓名";
    [passengerView addSubview:_passengerNameTextField];
    _passengerPhoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(passengerLabel.right, _passengerNameTextField.bottom, self.view.width - passengerLabel.right, _cellHeight/2.0)];
    _passengerPhoneTextField.placeholder = @"联系电话";
    [passengerView addSubview:_passengerPhoneTextField];
    
    UIView *orderPersonView = [[UIView alloc] initWithFrame:CGRectMake(_gap, passengerView.bottom, _startPosition.width, _cellHeight)];
    [scrollView addSubview:orderPersonView];
    UILabel *orderPersonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, _cellHeight)];
    orderPersonLabel.textAlignment = NSTextAlignmentLeft;
    orderPersonLabel.textColor = [UIColor blackColor];
    orderPersonLabel.text = @"订车人";
    [orderPersonView addSubview:orderPersonLabel];
    _orderPersonNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, _cellHeight/2.0)];
    _orderPersonNameLabel.textAlignment = NSTextAlignmentLeft;
    _orderPersonNameLabel.textColor = [UIColor blackColor];
    [orderPersonView addSubview:_orderPersonNameLabel];
    _orderPersonPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _orderPersonNameLabel.bottom, 100, _cellHeight/2.0)];
    _orderPersonPhoneLabel.textAlignment = NSTextAlignmentLeft;
    _orderPersonPhoneLabel.textColor = [UIColor blackColor];
    [orderPersonView addSubview:_orderPersonPhoneLabel];
    
    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    orderButton.frame = CGRectMake((self.view.width - 250)/2.0, orderPersonView.bottom + 10, 250, _cellHeight);
    orderButton.backgroundColor = RGB(kMainColor);
    [orderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [orderButton setTitle:@"订    车" forState:UIControlStateNormal];
    [orderButton addTarget:self action:@selector(didClickOrderButton:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:orderButton];
    _orderButton = orderButton;
    
    CGFloat buttonGap = 50;
    CGFloat buttonWidth = (self.view.width - buttonGap * 3)/2.0;
    _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _checkButton.frame = CGRectMake(buttonGap, orderButton.top, buttonWidth, _cellHeight);
    _checkButton.backgroundColor = RGB(kMainColor);
    [_checkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_checkButton setTitle:@"审 核" forState:UIControlStateNormal];
    [_checkButton addTarget:self action:@selector(didClickCheckButton:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:_checkButton];
    _checkButton.hidden = YES;
    
    _rejectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rejectButton.frame = CGRectMake(_checkButton.right + buttonGap, orderButton.top, buttonWidth, _cellHeight);
    _rejectButton.backgroundColor = RGB(kMainColor);
    [_rejectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rejectButton setTitle:@"驳 回" forState:UIControlStateNormal];
    [_rejectButton addTarget:self action:@selector(didClickRejectButton:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:_rejectButton];
    _rejectButton.hidden = YES;
    
    scrollView.contentSize = CGSizeMake(scrollView.width, MAX(scrollView.height, orderButton.bottom + 10));
    _contentSize = scrollView.contentSize;
    
    for (UIView *subView in scrollView.subviews) {
        if (subView == orderButton || subView == _checkButton || subView == _rejectButton) {
            continue;
        }
        [subView addSubview:[DashView dashViewWithRect:CGRectMake(0, subView.height - 1, subView.width, 1)]];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _currentTextField = textField;
}

- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        [_datePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
//        _datePicker.date = self.user.birthDate;
    }
    return _datePicker;
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
