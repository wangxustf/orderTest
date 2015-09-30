//
//  OrderViewController.m
//  orderTest
//
//  Created by wangxu on 15/9/12.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "OrderViewController.h"
#import "RecordViewController.h"
#import "DriverListViewController.h"
#import "YLYTipsTextField.h"
#import "DashView.h"
#import "ImageButton.h"
#import "Service.h"
#import <MessageUI/MessageUI.h>

@interface OrderViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YLYTipsTextField *startPosition;
@property (nonatomic, strong) YLYTipsTextField *passPosition;
@property (nonatomic, strong) YLYTipsTextField *orderTime;
@property (nonatomic, strong) UITextField *startTimeTextField;
@property (nonatomic, strong) UITextField *endTimeTextField;
@property (nonatomic, strong) UIView *timeView;
@property (nonatomic, strong) ImageButton *startTimeButton;
@property (nonatomic, strong) ImageButton *endTimeButton;
@property (nonatomic, strong) UIView *typeView;
@property (nonatomic, strong) UITextField *carTypeTextField;
@property (nonatomic, strong) ImageButton *carTypeButton;
@property (nonatomic, strong) UIView *driverView;
@property (nonatomic, strong) UIButton *driverButton;
@property (nonatomic, strong) UILabel *driverNameLabel;
@property (nonatomic, strong) UILabel *driverPhoneLabel;
@property (nonatomic, strong) UIView *passengerView;
@property (nonatomic, strong) UITextField *passengerNameTextField;
@property (nonatomic, strong) UITextField *passengerPhoneTextField;
@property (nonatomic, strong) UIView *orderPersonView;
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
@property (nonatomic, strong) YLYUser *user;

@end

static MFMessageComposeViewController *controller;

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
        _user = [NSUserDefaults user];
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

- (void)setupUI
{
    switch (self.user.userType) {
        case UserTypeDingche:
        {
            self.startPosition.hidden = NO;
            self.passPosition.top = self.startPosition.bottom;
            self.timeView.top = self.passPosition.bottom;
            self.typeView.top = self.timeView.bottom;
            self.passengerView.top = self.typeView.bottom;
            self.orderPersonView.top = self.passengerView.bottom;
            self.orderButton.top = self.orderPersonView.bottom + 10;
            self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.orderButton.bottom + 10, self.scrollView.height));
        }
            break;
            
        default:
            break;
    }
    _contentSize = self.scrollView.contentSize;
//    [self setupAuthorityWithUser:self.user];
}

- (void)setupAuthorityWithUser:(YLYUser *)user
{
    switch (user.userType) {
        case UserTypeDingche:
        {
            self.startPosition.editEnable = YES;
            self.passPosition.editEnable = YES;
            self.startTimeButton.enabled = YES;
            self.endTimeButton.enabled = YES;
            self.carTypeButton.enabled = YES;
            self.driverButton.enabled = NO;
            self.orderButton.hidden = NO;
        }
            break;
            
        case UserTypeShenhe:
        {
            self.startPosition.editEnable = NO;
            self.passPosition.editEnable = NO;
            self.startTimeButton.enabled = NO;
            self.endTimeButton.enabled = NO;
            self.carTypeButton.enabled = NO;
            self.driverButton.enabled = NO;
            self.orderButton.hidden = YES;
            self.checkButton.hidden = NO;
            self.rejectButton.hidden = NO;
        }
            break;
            
        case UserTypePaiche:
        {
            self.startPosition.editEnable = NO;
            self.passPosition.editEnable = NO;
            self.startTimeButton.enabled = NO;
            self.endTimeButton.enabled = NO;
            self.carTypeButton.enabled = NO;
            self.driverButton.enabled = YES;
            self.orderButton.hidden = YES;
            self.checkButton.hidden = NO;
            self.rejectButton.hidden = NO;
        }
            break;
            
        case UserTypeDriver:
        {
            self.startPosition.editEnable = NO;
            self.passPosition.editEnable = NO;
            self.startTimeButton.enabled = NO;
            self.endTimeButton.enabled = NO;
            self.carTypeButton.enabled = NO;
            self.driverButton.enabled = NO;
            self.orderButton.hidden = YES;
            self.checkButton.hidden = NO;
            self.rejectButton.hidden = NO;
        }
            break;
            
        default:
            break;
    }
}

- (void)didClickOrderButton:(id)sender
{
    if (self.startPosition.text.length <= 0) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"接车地点不能为空"];
        return;
    }
    if (self.passPosition.text.length <= 0) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"经过地点不能为空"];
        return;
    }
    if (self.startTimeButton.titleLabel.text.length <= 0) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"起始时间不能为空"];
        return;
    }
    if (self.endTimeButton.text.length <= 0) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"结束时间不能为空"];
        return;
    }
    if (self.carTypeButton.text.length <= 0) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"车辆类型不能为空"];
        return;
    }
    Service *service = [[Service alloc] init];
    YLYUser *user = [NSUserDefaults user];
    Order *order = [[Order alloc] init];
    order.orderID = nil;
    order.jiecheAddress = self.startPosition.text;
    order.jingguoAddress = self.passPosition.text;
    order.realJingguoAddress = @"";
    order.yuyueTime = self.orderTime.text;
    order.startTime = self.startTimeTextField.text;
    order.endTime = self.endTimeTextField.text;
    order.realStartTime = @"";
    order.realEndTime = @"";
    order.isPublic = @"";
    order.carType = [@(_selectedCarRow) stringValue];
    order.userName = self.passengerNameTextField.text;
    order.userPhone = self.passengerPhoneTextField.text;
    order.carID = @"";
    order.dingcherenID = user.userID;
    order.dingcherenName = user.username;
    order.dingcherenPhone = user.phone;
    order.dingcherenDep = user.depName;
    order.dingcherenDepID = user.depID;
    order.orderState = @"";
    order.shenpirenName = @"";
    order.shenpirenID = @"";
    order.paicherenID = @"";
    order.driverID = @"";//self.driver.driverID;
    order.driverName = @"";//self.driverNameLabel.text;
    order.driverPhone = @"";//self.driverPhoneLabel.text;
    order.startMetre = @"";
    order.endMetre = @"";
    order.shenheYiJian = @"";
    order.facheYijian = @"";
    order.bohuiYuanYin = @"";
    order.countMetre = @"";
    order.pingjia = @"";
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
    [service DingCheWithOrder:order completion:^(BOOL success, NSString *msg) {
        [DejalBezelActivityView removeView];
        
    }];
}
- (void)didClickRightBarButtonItem:(id)sender
{
    RecordViewController *recordViewController = [[RecordViewController alloc] init];
    recordViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:recordViewController animated:YES];
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

- (void)didClickCheckButton:(id)sender
{
    
}

- (void)didClickRejectButton:(id)sender
{
    
}

-(void)showMessageView:(NSArray *)phones body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        //        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissModalViewControllerAnimated:NO];//关键的一句   不能为YES
    switch ( result ) {
        case MessageComposeResultCancelled:
        {
            //click cancel button
        }
            break;
        case MessageComposeResultFailed:// send failed
            
            break;
        case MessageComposeResultSent:
        {
            
            //do something
        }
            break;
        default:
            break;
    }
    
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
    }
    return _datePicker;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 49)];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (YLYTipsTextField *)startPosition
{
    if (!_startPosition) {
        _startPosition = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, 0, self.view.width - _gap * 2, _cellHeight)];
        [_startPosition tipsTextFieldWithTips:@"接车地点" placeholder:@"请输入接车地点！" isPassword:NO];
        [self.scrollView addSubview:_startPosition];
    }
    return _startPosition;
}

- (YLYTipsTextField *)passPosition
{
    if (!_passPosition) {
        _passPosition = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, self.startPosition.bottom, self.startPosition.width, _cellHeight)];
        [_passPosition tipsTextFieldWithTips:@"经过地点" placeholder:@"请输入经过地点！" isPassword:NO];
        [self.scrollView addSubview:_passPosition];
    }
    return _passPosition;
}

- (YLYTipsTextField *)orderTime
{
    if (!_orderTime) {
        _orderTime = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [_orderTime tipsTextFieldWithTips:@"预约时间" placeholder:[NSDate convertStringFromDate:[NSDate date]] isPassword:NO];
        _orderTime.editEnable = NO;
        [self.scrollView addSubview:_orderTime];
    }
    return _orderTime;
}

- (UIView *)timeView
{
    if (!_timeView) {
        _timeView = [[UIView alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [self.scrollView addSubview:_timeView];
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, _cellHeight)];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.font = Font(12.0);
        timeLabel.text = @"使用时间";
        [_timeView addSubview:timeLabel];
        _startTimeButton = [ImageButton buttonWithType:UIButtonTypeCustom];
        _startTimeButton.frame = CGRectMake(timeLabel.right + 10, 0, (self.startPosition.width - timeLabel.width - 10 - 16)/2.0, _cellHeight);
        [_startTimeButton addTarget:self action:@selector(didClickStartButton:) forControlEvents:UIControlEventTouchUpInside];
        [_startTimeButton setWithText:nil imageName:@"downArrow.png"];
        [_timeView addSubview:_startTimeButton];
        _startTimeButton.fontSize = 12;
        _startTimeTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _startTimeTextField.delegate = self;
        [_timeView addSubview:_startTimeTextField];
        [self setupStartTimeTextField];
        UILabel *zhiLabel = [[UILabel alloc] initWithFrame:CGRectMake(_startTimeButton.right, 0, 16, _cellHeight)];
        zhiLabel.textAlignment = NSTextAlignmentCenter;
        zhiLabel.font = Font(12.0);
        zhiLabel.text = @"至";
        [_timeView addSubview:zhiLabel];
        _endTimeButton = [ImageButton buttonWithType:UIButtonTypeCustom];
        _endTimeButton.frame = CGRectMake(_startTimeButton.right + 16, 0, _startTimeButton.width, _cellHeight);
        [_endTimeButton addTarget:self action:@selector(didClickEndButton:) forControlEvents:UIControlEventTouchUpInside];
        [_endTimeButton setWithText:nil imageName:@"downArrow.png"];
        [_timeView addSubview:_endTimeButton];
        _endTimeButton.fontSize = _startTimeButton.fontSize;
        _endTimeTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _endTimeTextField.delegate = self;
        [_timeView addSubview:_endTimeTextField];
        [self setupEndTimeTextField];
    }
    return _timeView;
}

- (UIView *)typeView
{
    if (!_typeView) {
        _typeView = [[UIView alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [self.scrollView addSubview:_typeView];
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, _cellHeight)];
        typeLabel.textAlignment = NSTextAlignmentRight;
        typeLabel.font = Font(12.0);
        typeLabel.text = @"车辆类型";
        [_typeView addSubview:typeLabel];
        _carTypeButton = [ImageButton buttonWithType:UIButtonTypeCustom];
        _carTypeButton.frame = CGRectMake(typeLabel.right + 10, 0, self.startPosition.width - typeLabel.width, _cellHeight);
        _carTypeButton.fontSize = 12;
        [_carTypeButton addTarget:self action:@selector(didClickTypeButton:) forControlEvents:UIControlEventTouchUpInside];
        [_carTypeButton setWithText:nil imageName:@"downArrow.png"];
        [_typeView addSubview:_carTypeButton];
        _carTypeTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _carTypeTextField.delegate = self;
        [_typeView addSubview:_carTypeTextField];
        [self setupCarTypeTextField];
    }
    return _typeView;
}

- (UIView *)driverView
{
    if (!_driverView) {
        _driverView = [[UIView alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [self.scrollView addSubview:_driverView];
        UILabel *driverLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, _cellHeight)];
        driverLabel.textAlignment = NSTextAlignmentRight;
        driverLabel.font = Font(12.0);
        driverLabel.text = @"选择驾驶员";
        [_driverView addSubview:driverLabel];
        _driverNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(driverLabel.right + 10, 0, 100, _cellHeight/2.0)];
        _driverNameLabel.textAlignment = NSTextAlignmentLeft;
        _driverNameLabel.textColor = [UIColor blackColor];
        _driverNameLabel.font = Font(12);
        [_driverView addSubview:_driverNameLabel];
        _driverPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(_driverNameLabel.left, _driverNameLabel.bottom, 100, _cellHeight/2.0)];
        _driverPhoneLabel.textAlignment = NSTextAlignmentLeft;
        _driverPhoneLabel.textColor = [UIColor blackColor];
        _driverPhoneLabel.font = Font(12);
        [_driverView addSubview:_driverPhoneLabel];
        UIButton *driverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        driverButton.frame = CGRectMake(self.view.width - 60, (_driverView.height - 40)/2.0, 40, 40);
        [driverButton setBackgroundImage:[UIImage imageNamed:@"addDriver.png"] forState:UIControlStateNormal];
        [driverButton addTarget:self action:@selector(didClickDriverButton:) forControlEvents:UIControlEventTouchUpInside];
        [_driverView addSubview:driverButton];
        _driverButton = driverButton;
    }
    return _driverView;
}

- (UIView *)passengerView
{
    if (!_passengerView) {
        _passengerView = [[UIView alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [self.scrollView addSubview:_passengerView];
        UILabel *passengerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, _cellHeight)];
        passengerLabel.textAlignment = NSTextAlignmentRight;
        passengerLabel.textColor = [UIColor blackColor];
        passengerLabel.text = @"乘车人";
        passengerLabel.font = Font(12);
        [_passengerView addSubview:passengerLabel];
        _passengerNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(passengerLabel.right + 10, 0, self.view.width - passengerLabel.right, _cellHeight/2.0)];
        _passengerNameTextField.font = Font(12);
        [_passengerNameTextField setValue:Font(12) forKeyPath:@"_placeholderLabel.font"];
        _passengerNameTextField.placeholder = @"请输入乘车人姓名！（如是本人可免）";
        [_passengerView addSubview:_passengerNameTextField];
        _passengerPhoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(_passengerNameTextField.left, _passengerNameTextField.bottom, self.view.width - passengerLabel.right, _cellHeight/2.0)];
        _passengerPhoneTextField.font = Font(12);
        [_passengerPhoneTextField setValue:Font(12) forKeyPath:@"_placeholderLabel.font"];
        _passengerPhoneTextField.placeholder = @"请输入乘车人电话！（如是本人可免）";
        [_passengerView addSubview:_passengerPhoneTextField];
    }
    return _passengerView;
}

- (UIView *)orderPersonView
{
    if (!_orderPersonView) {
        _orderPersonView = [[UIView alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [self.scrollView addSubview:_orderPersonView];
        UILabel *orderPersonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, _cellHeight)];
        orderPersonLabel.textAlignment = NSTextAlignmentRight;
        orderPersonLabel.textColor = [UIColor blackColor];
        orderPersonLabel.font = Font(12);
        orderPersonLabel.text = @"订车人";
        [_orderPersonView addSubview:orderPersonLabel];
        _orderPersonNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(orderPersonLabel.right + 10, 0, 100, _cellHeight/2.0)];
        _orderPersonNameLabel.textAlignment = NSTextAlignmentLeft;
        _orderPersonNameLabel.textColor = [UIColor blackColor];
        _orderPersonNameLabel.font = Font(12);
        _orderPersonNameLabel.text = self.user.username;
        [_orderPersonView addSubview:_orderPersonNameLabel];
        _orderPersonPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(_orderPersonNameLabel.left, _orderPersonNameLabel.bottom, 100, _cellHeight/2.0)];
        _orderPersonPhoneLabel.textAlignment = NSTextAlignmentLeft;
        _orderPersonPhoneLabel.textColor = [UIColor blackColor];
        _orderPersonPhoneLabel.font = Font(12);
        _orderPersonPhoneLabel.text = self.user.phone;
        [_orderPersonView addSubview:_orderPersonPhoneLabel];
    }
    return _orderPersonView;
}

- (UIButton *)orderButton
{
    if (!_orderButton) {
        _orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _orderButton.frame = CGRectMake((self.view.width - 250)/2.0, 0, 250, _cellHeight);
        _orderButton.backgroundColor = RGB(kMainColor);
        [_orderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_orderButton setTitle:@"订    车" forState:UIControlStateNormal];
        [_orderButton addTarget:self action:@selector(didClickOrderButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:_orderButton];
    }
    return _orderButton;
}

- (UIButton *)checkButton
{
    if (!_checkButton) {
        CGFloat buttonGap = 50;
        CGFloat buttonWidth = (self.view.width - buttonGap * 3)/2.0;
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkButton.frame = CGRectMake(buttonGap, 0, buttonWidth, _cellHeight);
        _checkButton.backgroundColor = RGB(kMainColor);
        [_checkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_checkButton setTitle:@"审 核" forState:UIControlStateNormal];
        [_checkButton addTarget:self action:@selector(didClickCheckButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:_checkButton];
    }
    return _checkButton;
}

- (UIButton *)rejectButton
{
    if (!_rejectButton) {
        CGFloat buttonGap = 50;
        CGFloat buttonWidth = (self.view.width - buttonGap * 3)/2.0;
        _rejectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rejectButton.frame = CGRectMake(self.checkButton.right + buttonGap, 0, buttonWidth, _cellHeight);
        _rejectButton.backgroundColor = RGB(kMainColor);
        [_rejectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rejectButton setTitle:@"驳 回" forState:UIControlStateNormal];
        [_rejectButton addTarget:self action:@selector(didClickRejectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:_rejectButton];
    }
    return _rejectButton;
}

@end
