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
#import "CarListViewController.h"
#import "YLYTipsTextField.h"
#import "DashView.h"
#import "ImageButton.h"
#import "Service.h"
#import <MessageUI/MessageUI.h>
#import "CWStarRateView.h"

//0	//:订车
//1	//:审核通过
//11	//:审核驳回
//2	//:派车人确认
//22	//:派车人驳回
//3       //:司机确认通过
//33      //:司机确认驳回
//4       //:派车人发车
//5	//:司机开始
//6	//:司机结束
//7	//客户确认
//8       //:派车流程终了

@interface OrderViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, MFMessageComposeViewControllerDelegate, CWStarRateViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YLYTipsTextField *startPosition;
@property (nonatomic, strong) YLYTipsTextField *passPosition;
@property (nonatomic, strong) YLYTipsTextField *realPassPosition;
@property (nonatomic, strong) YLYTipsTextField *orderTime;
@property (nonatomic, strong) UITextField *startTimeTextField;
@property (nonatomic, strong) UITextField *endTimeTextField;
@property (nonatomic, strong) UIView *timeView;
@property (nonatomic, strong) ImageButton *startTimeButton;
@property (nonatomic, strong) ImageButton *endTimeButton;
@property (nonatomic, strong) UIView *realTimeView;
@property (nonatomic, strong) ImageButton *realStartTimeButton;
@property (nonatomic, strong) ImageButton *realEndTimeButton;
@property (nonatomic, strong) UITextField *realStartTimeTextField;
@property (nonatomic, strong) UITextField *realEndTimeTextField;
@property (nonatomic, strong) UIView *carView;
@property (nonatomic, strong) UILabel *carNameLabel;
@property (nonatomic, strong) UIButton *carButton;
@property (nonatomic, strong) UIView *typeView;
@property (nonatomic, strong) UITextField *carTypeTextField;
@property (nonatomic, strong) ImageButton *carTypeButton;
@property (nonatomic, strong) YLYTipsTextField *carNotes;
@property (nonatomic, strong) UIView *isPublicView;
@property (nonatomic, strong) UIButton *publicButton;
@property (nonatomic, strong) UIView *driverView;
@property (nonatomic, strong) UIButton *driverButton;
@property (nonatomic, strong) UILabel *driverNameLabel;
@property (nonatomic, strong) UILabel *driverPhoneLabel;
@property (nonatomic, strong) UIView *passengerView;
@property (nonatomic, strong) UITextField *passengerNameTextField;
@property (nonatomic, strong) UITextField *passengerPhoneTextField;
@property (nonatomic, strong) YLYTipsTextField *passengerNumberTextField;
@property (nonatomic, strong) UIView *orderPersonView;
@property (nonatomic, strong) UILabel *orderDepNameLabel;
@property (nonatomic, strong) UILabel *orderPersonNameLabel;
@property (nonatomic, strong) UILabel *orderPersonPhoneLabel;
@property (nonatomic, strong) YLYTipsTextField *shenherenTextField;
@property (nonatomic, strong) YLYTipsTextField *shenheyijianTextField;
@property (nonatomic, strong) YLYTipsTextField *bohuiyijianTextField;
@property (nonatomic, strong) YLYTipsTextField *tripDistanceTextField;
@property (nonatomic, strong) YLYTipsTextField *pricePerKilometerTextField;
@property (nonatomic, strong) YLYTipsTextField *roadChargeTextField;
@property (nonatomic, strong) YLYTipsTextField *bridgeChargeTextField;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UITextField *currentTextField;
@property (nonatomic, strong) NSArray *carArray;
@property (nonatomic, strong) NSArray *carTitleArray;
@property (nonatomic, assign) NSInteger selectedCarRow;
@property (nonatomic, strong) UIButton *orderButton;
@property (nonatomic, strong) UIButton *checkButton;
@property (nonatomic, strong) UIButton *rejectButton;
@property (nonatomic, strong) Driver *driver;
@property (nonatomic, strong) Car *car;
@property (nonatomic, strong) YLYUser *user;
@property (nonatomic, strong) Service *service;
@property (nonatomic, strong) CWStarRateView *starRateView;

@end

static MFMessageComposeViewController *controller;

@implementation OrderViewController
{
    CGFloat _gap;
    CGFloat _cellHeight;
    CGSize _contentSize;
    CGPoint _contentOffset;
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
        _service = [[Service alloc] init];
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
    if (self.user.userType == UserTypeDingche) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"订车历史" style:UIBarButtonItemStyleDone target:self action:@selector(didClickRightBarButtonItem:)];
    }
    _gap = 0;
    _cellHeight = 60;
    _carArray = @[@"经济型", @"舒适型", @"豪华型", @"商务型", @"16座客车", @"32座客车"];
    _carTitleArray = @[@"01", @"02", @"03", @"04", @"05", @"06"];
    _selectedCarRow = 0;
    if (!_order) {
        _order = [[Order alloc] init];
    }
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapGestureRecognizer:)]];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setOrder:(Order *)order
{
    _order = [order copy];
}

- (void)setupUI
{
    switch (self.user.userType) {
        case UserTypeDingche:
        {
            if (self.order.orderID.length <= 0) {
                self.passPosition.top = self.startPosition.bottom;
                self.orderTime.top = self.passPosition.bottom;
                self.timeView.top = self.orderTime.bottom;
                self.typeView.top = self.timeView.bottom;
                self.carNotes.top = self.typeView.bottom;
                self.isPublicView.top = self.carNotes.bottom;
                self.passengerNumberTextField.top = self.isPublicView.bottom;
                self.passengerView.top = self.passengerNumberTextField.bottom;
                self.orderPersonView.top = self.passengerView.bottom;
                if (!_finished) {
                    self.orderButton.top = self.orderPersonView.bottom + 10;
                    [self.orderButton setTitle:@"订车" forState:UIControlStateNormal];
                    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.orderButton.bottom + 10, self.scrollView.height));
                } else {
                    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.orderPersonView.bottom + 10, self.scrollView.height));
                }
                
                self.orderDepNameLabel.text = self.user.depName;
                self.orderPersonNameLabel.text = self.user.username;
                self.orderPersonPhoneLabel.text = self.user.phone;
            } else {
                self.passPosition.top = self.startPosition.bottom;
                self.realPassPosition.top = self.passPosition.bottom;
                self.orderTime.top = self.realPassPosition.bottom;
                self.timeView.top = self.orderTime.bottom;
                self.realTimeView.top = self.timeView.bottom;
                self.carNotes.top = self.realTimeView.bottom;
                self.tripDistanceTextField.top = self.carNotes.bottom;
                self.pricePerKilometerTextField.top = self.tripDistanceTextField.bottom;
                self.roadChargeTextField.top = self.pricePerKilometerTextField.bottom;
                self.bridgeChargeTextField.top = self.roadChargeTextField.bottom;
                self.passengerView.top = self.bridgeChargeTextField.bottom;
                self.orderPersonView.top = self.passengerView.bottom;
                self.starRateView.top = self.orderPersonView.bottom;
                if (!_finished) {
                    self.orderButton.top = self.starRateView.bottom + 10;
                    [self.orderButton setTitle:@"确认" forState:UIControlStateNormal];
                    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.orderButton.bottom + 10, self.scrollView.height));
                } else {
                    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.starRateView.bottom + 10, self.scrollView.height));
                }
                
                self.startPosition.editEnable = NO;
                self.passPosition.editEnable = NO;
                self.realPassPosition.editEnable = NO;
                self.startTimeButton.enabled = NO;
                self.endTimeButton.enabled = NO;
                self.realStartTimeButton.enabled = NO;
                self.realEndTimeButton.enabled = NO;
                self.carNotes.editEnable = NO;
                self.tripDistanceTextField.editEnable = NO;
                self.pricePerKilometerTextField.editEnable = NO;
                self.roadChargeTextField.editEnable = NO;
                self.bridgeChargeTextField.editEnable = NO;
                self.passengerNameTextField.enabled = NO;
                self.passengerPhoneTextField.enabled = NO;
                
                self.startPosition.text = self.order.jiecheAddress;
                self.passPosition.text = self.order.jingguoAddress;
                self.realPassPosition.text = self.order.realJingguoAddress;
                self.orderTime.text = self.order.yuyueTime;
                self.startTimeButton.text = self.order.startTime;
                self.endTimeButton.text = self.order.endTime;
                self.realStartTimeButton.text = self.order.realStartTime;
                self.realEndTimeButton.text = self.order.realEndTime;
                self.carNotes.text = self.order.yongcheshiyi;
                self.tripDistanceTextField.text = self.order.countMetre;
                self.pricePerKilometerTextField.text = self.order.gonglidanjia;
                self.roadChargeTextField.text = self.order.tingcheguolufei;
                self.bridgeChargeTextField.text = self.order.guoqiaofei;
                self.passengerNameTextField.text = self.order.userName;
                self.passengerPhoneTextField.text = self.order.userPhone;
                self.orderDepNameLabel.text = self.order.dingcherenDep;
                self.orderPersonNameLabel.text = self.order.dingcherenName;
                self.orderPersonPhoneLabel.text = self.order.dingcherenPhone;
            }
        }
            break;
            
        case UserTypeShenhe:
        {
            self.passPosition.top = self.startPosition.bottom;
            self.orderTime.top = self.passPosition.bottom;
            self.timeView.top = self.orderTime.bottom;
            self.typeView.top = self.timeView.bottom;
            self.carNotes.top = self.typeView.bottom;
            self.passengerNumberTextField.top = self.carNotes.bottom;
            self.passengerView.top = self.passengerNumberTextField.bottom;
            self.orderPersonView.top = self.passengerView.bottom;
            if (!_finished) {
                self.rejectButton.top = self.checkButton.top = self.orderPersonView.bottom + 10;
                [self.checkButton setTitle:@"通过" forState:UIControlStateNormal];
                [self.rejectButton setTitle:@"驳回" forState:UIControlStateNormal];
                self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.rejectButton.bottom + 10, self.scrollView.height));
            } else {
                self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.orderPersonView.bottom + 10, self.scrollView.height));
            }
            
            self.startPosition.editEnable = NO;
            self.passPosition.editEnable = NO;
            self.startTimeButton.enabled = NO;
            self.endTimeButton.enabled = NO;
            self.carTypeButton.enabled = NO;
            self.carNotes.editEnable = NO;
            self.passengerNumberTextField.editEnable = NO;
            self.passengerNameTextField.enabled = NO;
            self.passengerPhoneTextField.enabled = NO;
            
            self.startPosition.text = self.order.jiecheAddress;
            self.passPosition.text = self.order.jingguoAddress;
            self.orderTime.text = self.order.yuyueTime;
            self.startTimeButton.text = self.order.startTime;
            self.endTimeButton.text = self.order.endTime;
            self.carNotes.text = self.order.yongcheshiyi;
            self.carTypeButton.text = self.order.carType;
            NSInteger i = 0;
            for (NSString *title in _carTitleArray) {
                if ([title containsString:self.carTypeButton.text]) {
                    break;
                }
                i++;
            }
            if (i == 6) {
                i = 0;
            }
            self.carTypeButton.text = _carArray[i];
            self.passengerNameTextField.text = self.order.userName;
            self.passengerPhoneTextField.text = self.order.userPhone;
            self.orderDepNameLabel.text = self.order.dingcherenDep;
            self.orderPersonNameLabel.text = self.order.dingcherenName;
            self.orderPersonPhoneLabel.text = self.order.dingcherenPhone;
        }
            break;
            
        case UserTypePaiche:
        {
            if ([self.order.orderState integerValue] == OrderStateShenhetongguo || [self.order.orderState integerValue] == OrderStatePaichequeren) {
                self.passPosition.top = self.startPosition.bottom;
                self.orderTime.top = self.passPosition.bottom;
                self.timeView.top = self.orderTime.bottom;
                self.isPublicView.top = self.timeView.bottom;
                self.carNotes.top = self.isPublicView.bottom;
                self.passengerNumberTextField.top = self.carNotes.bottom;
                self.carView.top = self.passengerNumberTextField.bottom;
                self.driverView.top = self.carView.bottom;
                self.passengerView.top = self.driverView.bottom;
                self.orderPersonView.top = self.passengerView.bottom;
                self.shenherenTextField.top = self.orderPersonView.bottom;
                self.shenheyijianTextField.top = self.shenherenTextField.bottom;
                self.bohuiyijianTextField.top = self.shenheyijianTextField.bottom;
                if (!_finished) {
                    self.rejectButton.top = self.checkButton.top = self.bohuiyijianTextField.bottom + 10;
                    [self.checkButton setTitle:@"通过" forState:UIControlStateNormal];
                    [self.rejectButton setTitle:@"驳回" forState:UIControlStateNormal];
                    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.checkButton.bottom + 10, self.scrollView.height));
                } else {
                    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.bohuiyijianTextField.bottom + 10, self.scrollView.height));
                }
                
                self.startPosition.editEnable = NO;
                self.passPosition.editEnable = NO;
                self.startTimeButton.enabled = NO;
                self.endTimeButton.enabled = NO;
                self.publicButton.enabled = NO;
                self.carNotes.editEnable = NO;
                self.passengerNumberTextField.editEnable = NO;
                self.passengerNameTextField.enabled = NO;
                self.passengerPhoneTextField.enabled = NO;
                self.shenherenTextField.editEnable = NO;
                self.shenheyijianTextField.editEnable = NO;
                
                self.startPosition.text = self.order.jiecheAddress;
                self.passPosition.text = self.order.jingguoAddress;
                self.orderTime.text = self.order.yuyueTime;
                self.startTimeButton.text = self.order.startTime;
                self.endTimeButton.text = self.order.endTime;
                [self.publicButton setImage:[UIImage imageNamed:([self.order.isPublic integerValue] == 0) ? @"icon_selected.png" : @"icon_unselected.png"] forState:UIControlStateNormal];
                self.carNotes.text = self.order.yongcheshiyi;
                self.passengerNameTextField.text = self.order.userName;
                self.passengerPhoneTextField.text = self.order.userPhone;
                self.orderDepNameLabel.text = self.order.dingcherenDep;
                self.orderPersonNameLabel.text = self.order.dingcherenName;
                self.orderPersonPhoneLabel.text = self.order.dingcherenPhone;
                self.shenherenTextField.text = self.order.shenpirenName;
                self.shenheyijianTextField.text = self.order.shenheYiJian;
            } else if ([self.order.orderState integerValue] == OrderStateSijiqueren || [self.order.orderState integerValue] == OrderStatePaichefache) {
                self.passPosition.top = self.startPosition.bottom;
                self.orderTime.top = self.passPosition.bottom;
                self.timeView.top = self.orderTime.bottom;
                self.isPublicView.top = self.timeView.bottom;
                self.carNotes.top = self.isPublicView.bottom;
                self.passengerNumberTextField.top = self.carNotes.bottom;
                self.carView.top = self.passengerNumberTextField.bottom;
                self.driverView.top = self.carView.bottom;
                self.passengerView.top = self.driverView.bottom;
                self.shenherenTextField.top = self.passengerView.bottom;
                self.orderPersonView.top = self.shenherenTextField.bottom;
                if (!_finished) {
                    self.rejectButton.top = self.checkButton.top = self.orderPersonView.bottom + 10;
                    self.orderButton.top = self.rejectButton.top;
                    [self.orderButton setTitle:@"发车" forState:UIControlStateNormal];
                    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.orderButton.bottom + 10, self.scrollView.height));
                } else {
                    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.orderPersonView.bottom + 10, self.scrollView.height));
                }
                
                self.startPosition.editEnable = NO;
                self.passPosition.editEnable = NO;
                self.startTimeButton.enabled = NO;
                self.endTimeButton.enabled = NO;
                self.publicButton.enabled = NO;
                self.carNotes.editEnable = NO;
                self.passengerNumberTextField.editEnable = NO;
                self.carButton.enabled = NO;
                self.driverButton.enabled = NO;
                self.passengerNameTextField.enabled = NO;
                self.passengerPhoneTextField.enabled = NO;
                self.shenherenTextField.editEnable = NO;
                
                self.startPosition.text = self.order.jiecheAddress;
                self.passPosition.text = self.order.jingguoAddress;
                self.orderTime.text = self.order.yuyueTime;
                self.startTimeButton.text = self.order.startTime;
                self.endTimeButton.text = self.order.endTime;
                [self.publicButton setImage:[UIImage imageNamed:([self.order.isPublic integerValue] == 0) ? @"icon_selected.png" : @"icon_unselected.png"] forState:UIControlStateNormal];
                self.carNotes.text = self.order.yongcheshiyi;
                [self.carButton setTitle:self.order.carType forState:UIControlStateNormal];
                self.driverNameLabel.text = self.order.driverName;
                self.driverPhoneLabel.text = self.order.driverPhone;
                self.passengerNameTextField.text = self.order.userName;
                self.passengerPhoneTextField.text = self.order.userPhone;
                self.shenherenTextField.text = self.order.shenpirenName;
                self.orderDepNameLabel.text = self.order.dingcherenDep;
                self.orderPersonNameLabel.text = self.order.dingcherenName;
                self.orderPersonPhoneLabel.text = self.order.dingcherenPhone;
            } else  {
                self.passPosition.top = self.startPosition.bottom;
                self.realPassPosition.top = self.passPosition.bottom;
                self.orderTime.top = self.realPassPosition.bottom;
                self.timeView.top = self.orderTime.bottom;
                self.realTimeView.top = self.timeView.bottom;
                self.carNotes.top = self.realTimeView.bottom;
                self.tripDistanceTextField.top = self.carNotes.bottom;
                self.pricePerKilometerTextField.top = self.tripDistanceTextField.bottom;
                self.roadChargeTextField.top = self.pricePerKilometerTextField.bottom;
                self.bridgeChargeTextField.top = self.roadChargeTextField.bottom;
                self.passengerView.top = self.bridgeChargeTextField.bottom;
                self.orderPersonView.top = self.passengerView.bottom;
                self.starRateView.top = self.orderPersonView.bottom;
                if (!_finished) {
                    self.orderButton.top = self.starRateView.bottom + 10;
                    [self.orderButton setTitle:@"终了" forState:UIControlStateNormal];
                    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.orderButton.bottom + 10, self.scrollView.height));
                } else {
                    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.starRateView.bottom + 10, self.scrollView.height));
                }
                
                self.startPosition.editEnable = NO;
                self.passPosition.editEnable = NO;
                self.realPassPosition.editEnable = NO;
                self.startTimeButton.enabled = NO;
                self.endTimeButton.enabled = NO;
                self.realStartTimeButton.enabled = NO;
                self.realEndTimeButton.enabled = NO;
                self.carNotes.editEnable = NO;
                self.tripDistanceTextField.editEnable = NO;
                self.pricePerKilometerTextField.editEnable = NO;
                self.roadChargeTextField.editEnable = NO;
                self.bridgeChargeTextField.editEnable = NO;
                self.passengerNameTextField.enabled = NO;
                self.passengerPhoneTextField.enabled = NO;
                self.starRateView.disEnable = YES;
                
                self.startPosition.text = self.order.jiecheAddress;
                self.passPosition.text = self.order.jingguoAddress;
                self.orderTime.text = self.order.yuyueTime;
                self.startTimeButton.text = self.order.startTime;
                self.endTimeButton.text = self.order.endTime;
                self.realStartTimeButton.text = self.order.realStartTime;
                self.realEndTimeButton.text = self.order.realEndTime;
                self.carNotes.text = self.order.yongcheshiyi;
                self.tripDistanceTextField.text = self.order.countMetre;
                self.pricePerKilometerTextField.text = self.order.gonglidanjia;
                self.roadChargeTextField.text = self.order.tingcheguolufei;
                self.bridgeChargeTextField.text = self.order.guoqiaofei;
                self.passengerNameTextField.text = self.order.userName;
                self.passengerPhoneTextField.text = self.order.userPhone;
                self.orderDepNameLabel.text = self.order.dingcherenDep;
                self.orderPersonNameLabel.text = self.order.dingcherenName;
                self.orderPersonPhoneLabel.text = self.order.dingcherenPhone;
            }
        }
            break;
            
        case UserTypeDriver:
        {
            if ([self.order.orderState integerValue] == OrderStatePaichequeren) {
                self.passPosition.top = self.startPosition.bottom;
                self.orderTime.top = self.passPosition.bottom;
                self.timeView.top = self.orderTime.bottom;
                self.isPublicView.top = self.timeView.bottom;
                self.carNotes.top = self.isPublicView.bottom;
                self.passengerNumberTextField.top = self.carNotes.bottom;
                self.carView.top = self.passengerNumberTextField.bottom;
                self.driverView.top = self.carView.bottom;
                self.passengerView.top = self.driverView.bottom;
                self.orderPersonView.top = self.passengerView.bottom;
                if (!_finished) {
                    self.rejectButton.top = self.checkButton.top = self.orderPersonView.bottom + 10;
                    [self.checkButton setTitle:@"通过" forState:UIControlStateNormal];
                    [self.rejectButton setTitle:@"驳回" forState:UIControlStateNormal];
                    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.checkButton.bottom + 10, self.scrollView.height));
                } else {
                    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.orderPersonView.bottom + 10, self.scrollView.height));
                }
                
                self.startPosition.editEnable = NO;
                self.passPosition.editEnable = NO;
                self.startTimeButton.enabled = NO;
                self.endTimeButton.enabled = NO;
                self.publicButton.enabled = NO;
                self.carNotes.editEnable = NO;
                self.carButton.enabled = NO;
                self.driverButton.enabled = NO;
                self.passengerNumberTextField.editEnable = NO;
                self.carButton.enabled = NO;
                self.driverButton.enabled = NO;
                self.passengerNameTextField.enabled = NO;
                self.passengerPhoneTextField.enabled = NO;
                
                self.startPosition.text = self.order.jiecheAddress;
                self.passPosition.text = self.order.jingguoAddress;
                self.orderTime.text = self.order.yuyueTime;
                self.startTimeButton.text = self.order.startTime;
                self.endTimeButton.text = self.order.endTime;
                [self.publicButton setImage:[UIImage imageNamed:([self.order.isPublic integerValue] == 0) ? @"icon_selected.png" : @"icon_unselected.png"] forState:UIControlStateNormal];
                self.carNotes.text = self.order.yongcheshiyi;
//                [self.carButton setTitle:self.order.carType forState:UIControlStateNormal];
                self.carNameLabel.text = self.order.startMetre;
                self.driverNameLabel.text = self.order.driverName;
                self.driverPhoneLabel.text = self.order.driverPhone;
                self.passengerNameTextField.text = self.order.userName;
                self.passengerPhoneTextField.text = self.order.userPhone;
                self.orderDepNameLabel.text = self.order.dingcherenDep;
                self.orderPersonNameLabel.text = self.order.dingcherenName;
                self.orderPersonPhoneLabel.text = self.order.dingcherenPhone;
            } else {
                self.passPosition.top = self.startPosition.bottom;
                self.realPassPosition.top = self.passPosition.bottom;
                self.orderTime.top = self.realPassPosition.bottom;
                self.timeView.top = self.orderTime.bottom;
                self.realTimeView.top = self.timeView.bottom;
                self.carNotes.top = self.realTimeView.bottom;
                self.tripDistanceTextField.top = self.carNotes.bottom;
                self.pricePerKilometerTextField.top = self.tripDistanceTextField.bottom;
                self.roadChargeTextField.top = self.pricePerKilometerTextField.bottom;
                self.bridgeChargeTextField.top = self.roadChargeTextField.bottom;
                self.passengerView.top = self.bridgeChargeTextField.bottom;
                self.orderPersonView.top = self.passengerView.bottom;
                if (!_finished) {
                    self.rejectButton.top = self.checkButton.top = self.orderPersonView.bottom + 10;
                    [self.checkButton setTitle:@"开始" forState:UIControlStateNormal];
                    [self.rejectButton setTitle:@"结束" forState:UIControlStateNormal];
                    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.checkButton.bottom + 10, self.scrollView.height));
                } else {
                    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.orderPersonView.bottom + 10, self.scrollView.height));
                }
                
                self.startPosition.editEnable = NO;
                self.passPosition.editEnable = NO;
                if ([self.order.orderState integerValue] == OrderStateSijikaishi) {
                    self.realPassPosition.editEnable = NO;
                }
                self.startTimeButton.enabled = NO;
                self.endTimeButton.enabled = NO;
                self.carNotes.editEnable = NO;
                self.passengerNameTextField.enabled = NO;
                self.passengerPhoneTextField.enabled = NO;
                if ([self.order.orderState integerValue] == OrderStatePaichefache) {
                    self.realEndTimeButton.enabled = NO;
                } else if ([self.order.orderState integerValue] == OrderStateSijikaishi) {
                    self.realStartTimeButton.enabled = NO;
                }
                
                self.startPosition.text = self.order.jiecheAddress;
                self.passPosition.text = self.order.jingguoAddress;
                if ([self.order.orderState integerValue] == OrderStateSijikaishi) {
                    self.realPassPosition.text = self.order.realJingguoAddress;
                }
                self.orderTime.text = self.order.yuyueTime;
                self.startTimeButton.text = self.order.startTime;
                self.endTimeButton.text = self.order.endTime;
                if ([self.order.orderState integerValue] == OrderStateSijikaishi) {
                    self.realStartTimeButton.text = self.order.realStartTime;
                }
                self.carNotes.text = self.order.yongcheshiyi;
                self.passengerNameTextField.text = self.order.userName;
                self.passengerPhoneTextField.text = self.order.userPhone;
                self.orderDepNameLabel.text = self.order.dingcherenDep;
                self.orderPersonNameLabel.text = self.order.dingcherenName;
                self.orderPersonPhoneLabel.text = self.order.dingcherenPhone;
            }
        }
            break;
            
        default:
            break;
    }
    _contentSize = self.scrollView.contentSize;
}

- (void)didClickOrderButton:(id)sender
{
    if (self.startPosition.text.length <= 0) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"接车地点不能为空"];
        return;
    }
//    if (self.passPosition.text.length <= 0) {
//        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"经过地点不能为空"];
//        return;
//    }
    if (self.startTimeButton.text.length <= 0) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"起始时间不能为空"];
        return;
    }
    if (self.endTimeButton.text.length <= 0) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"结束时间不能为空"];
        return;
    }
    if (self.user.userType == UserTypeDingche && ([self.order.orderState integerValue] == OrderStateDingche)) {
        if (self.carTypeButton.text.length <= 0) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"车辆类型不能为空"];
            return;
        }
    }
//    if (self.carNotes.text.length <= 0) {
//        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"用车事宜不能为空"];
//        return;
//    }
    YLYUser *user = [NSUserDefaults user];
    if (_order.orderID.length <= 0) {
        _order.orderState = [@(OrderStateDingche) stringValue];
        _order.jiecheAddress = self.startPosition.text;
        _order.jingguoAddress = self.passPosition.text;
        _order.yuyueTime = self.orderTime.text;
        _order.startTime = self.startTimeButton.text;
        _order.endTime = self.endTimeButton.text;
        _order.carType =  _carTitleArray[_selectedCarRow];
        _order.yongcheshiyi = self.carNotes.text;
        _order.isPublic = self.order.isPublic ?  @"0" : @"1";
        _order.userName = self.passengerNameTextField.text.length > 0 ? self.passengerNameTextField.text : user.username;
        _order.userPhone = self.passengerPhoneTextField.text.length > 0 ? self.passengerPhoneTextField.text : user.phone;;
        _order.dingcherenID = user.userID;
        _order.dingcherenName = user.username;
        _order.dingcherenPhone = user.phone;
        _order.dingcherenDep = user.depName;
        _order.dingcherenDepID = user.depID;
    } else {
        self.startPosition.editEnable = NO;
        self.passPosition.editEnable = NO;
        self.startTimeButton.enabled = NO;
        self.endTimeButton.enabled = NO;
        self.carTypeButton.enabled = NO;
        self.passengerNameTextField.enabled = NO;
        self.passengerPhoneTextField.enabled = NO;
        switch ([_order.orderState integerValue]) {
            case OrderStateSijiqueren:
                self.order.orderState = [@(OrderStatePaichefache) stringValue];
                break;
                
            case OrderStateSijijieshu:
                self.order.orderState = [@(OrderStateKehuqueren) stringValue];
                self.order.pingjia = [@(self.starRateView.scorePercent) stringValue];
                break;
                
            case OrderStateKehuqueren:
                self.order.orderState = [@(OrderStatePaichezhongliao) stringValue];
                break;
                
            default:
                break;
        }
    }
    [self reportOrder];
}

- (void)didClickCheckButton:(id)sender
{
    switch (self.user.userType) {
        case UserTypeShenhe:
            self.order.orderState = [@(OrderStateShenhetongguo) stringValue];
            self.order.shenpirenID = self.user.userID;
            self.order.shenpirenName = self.user.username;
            break;
            
        case UserTypePaiche:
            if ([self.order.orderState integerValue] == OrderStateShenhetongguo) {
                self.order.orderState = [@(OrderStatePaichequeren) stringValue];
                if (self.car.carID.length <= 0) {
                    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"车辆不能为空"];
                    return;
                }
                if (self.driver.driverID.length <= 0) {
                    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"司机不能为空"];
                    return;
                }
            } else if ([self.order.orderState integerValue] == OrderStateSijiqueren) {
                self.order.orderState = [@(OrderStatePaichefache) stringValue];
            }
            self.order.carID = self.car.carID;
            self.order.driverID = self.driver.driverID;
            self.order.driverName = self.driver.driverName;
            self.order.driverPhone = self.driver.driverPhone;
            self.order.paicherenID = self.user.userID;
            break;
            
        case UserTypeDriver:
            self.order.orderState = ([self.order.orderState integerValue] == OrderStatePaichequeren) ? [@(OrderStateSijiqueren) stringValue] : [@(OrderStateSijikaishi) stringValue];
            if ([self.order.orderState integerValue] == OrderStateSijikaishi) {
                self.order.countMetre = self.tripDistanceTextField.text;
                self.order.gonglidanjia = self.pricePerKilometerTextField.text;
                self.order.guoqiaofei = self.bridgeChargeTextField.text;
                self.order.tingcheguolufei = self.roadChargeTextField.text;
                self.order.realStartTime = self.realStartTimeButton.text;
            }
            break;
            
        default:
            break;
    }
    [self reportOrder];
}

- (void)didClickRejectButton:(id)sender
{
    switch (self.user.userType) {
        case UserTypeShenhe:
            self.order.orderState = [@(OrderStateShenhebohui) stringValue];
            break;
            
        case UserTypePaiche:
            self.order.orderState = [@(OrderStatePaichebohui) stringValue];
            self.order.carID = self.car.carID;
            self.order.driverID = self.driver.driverID;
            self.order.driverName = self.driver.driverName;
            self.order.driverPhone = self.driver.driverPhone;
            self.order.bohuiYuanYin = self.bohuiyijianTextField.text;
            break;
            
        case UserTypeDriver:
            self.order.orderState = ([self.order.orderState integerValue] == OrderStatePaichequeren) ? [@(OrderStateSijibohui) stringValue]: [@(OrderStateSijijieshu) stringValue];
            if ([self.order.orderState integerValue] == OrderStateSijijieshu) {
                self.order.countMetre = self.tripDistanceTextField.text;
                self.order.gonglidanjia = self.pricePerKilometerTextField.text;
                self.order.guoqiaofei = self.bridgeChargeTextField.text;
                self.order.tingcheguolufei = self.roadChargeTextField.text;
                self.order.realEndTime = self.realEndTimeButton.text;
            }
            break;
            
        default:
            break;
    }
    [self reportOrder];
}

- (void)sendMsg
{
    NSMutableArray *phonesArray = [NSMutableArray array];
    NSInteger i = 0;
    for (NSString *title in _carTitleArray) {
        if ([title containsString:self.order.carType]) {
            break;
        }
        i++;
    }
    if (i == 6) {
        i = 0;
    }
    NSString *msg = [NSString stringWithFormat:@"%@欲于%@开始至%@预定一辆(%@)轿车", self.order.dingcherenName, self.order.startTime, self.order.endTime, _carArray[i]];
    switch ([self.order.orderState integerValue]) {
        case OrderStateDingche:
            [phonesArray addObjectsFromArray:self.user.shenpirenPhone];
            msg = [NSString stringWithFormat:@"%@，请核实。", msg];
            break;
            
        case OrderStateShenhetongguo:
            [phonesArray addObjectsFromArray:@[self.order.dingcherenPhone]];
            [phonesArray addObjectsFromArray:self.user.paicherenPhone];
            msg = [NSString stringWithFormat:@"%@订单，审核通过。", msg];
            break;
            
        case OrderStateShenhebohui:
            [phonesArray addObjectsFromArray:@[self.order.dingcherenPhone]];
            msg = [NSString stringWithFormat:@"%@订单，审核不通过。请再次核实。", msg];
            break;
            
        case OrderStatePaichequeren:
            if (self.order.driverPhone.length > 0) {
                [phonesArray addObjectsFromArray:@[self.order.driverPhone]];
            }
            msg = [NSString stringWithFormat:@"%@订单，请确认。", msg];
            break;
            
        case OrderStateSijiqueren:
            [phonesArray addObjectsFromArray:self.user.paicherenPhone];
            msg = [NSString stringWithFormat:@"%@订单，请确认。", msg];
            break;
            
        case OrderStateSijibohui:
            [phonesArray addObjectsFromArray:self.user.paicherenPhone];
            msg = [NSString stringWithFormat:@"%@订单，无法成行。", msg];
            break;
            
        case OrderStatePaichefache:
            if (self.order.driverPhone.length > 0) {
                [phonesArray addObjectsFromArray:@[self.order.driverPhone, self.order.dingcherenPhone, self.order.userPhone]];
            }
            msg = [NSString stringWithFormat:@"%@，已派车。\n接车地点：％@ 预计经过地点：％@ 乘客姓名：％@\n电话：％@ 用车事宜:%@。\n车牌号码：％@ 驾驶员电话：％@", msg, self.order.jiecheAddress, self.order.jingguoAddress, self.order.userName, self.order.userPhone, self.order.yongcheshiyi, self.order.carCode, self.order.driverPhone];
            break;
            
        case OrderStateSijijieshu:
            [phonesArray addObjectsFromArray:@[self.user.paicherenPhone, self.order.dingcherenPhone]];
            msg = [NSString stringWithFormat:@"%@订单，已完成。", msg];
            break;
            
        default:
            break;
    }
    if (phonesArray.count > 0) {
        [self showMessageView:phonesArray body:msg];
    }
}

- (void)reportOrder
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
    [self.service DingCheWithOrder:self.order completion:^(BOOL success, NSString *msg) {
        [DejalBezelActivityView removeView];
        [[TKAlertCenter defaultCenter] postAlertWithMessage:success ? @"成功" : @"失败"];
        if (success) {
            [self sendMsg];
            [self.navigationController popViewControllerAnimated:YES];
            if ([self.order.orderState integerValue] == OrderStateShenhetongguo || [self.order.orderState integerValue] == OrderStateKehuqueren || [self.order.orderState integerValue] == OrderStatePaichezhongliao || [self.order.orderState integerValue] == OrderStateSijijieshu || [self.order.orderState integerValue] == OrderStateSijikaishi) {
                if (_tongguoBlock) {
                    _tongguoBlock();
                }
            }
        }
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

- (void)didClickPublicButton:(id)sender
{
    UIButton *publicButton = (UIButton *)sender;
    BOOL isPublic = ([self.order.isPublic integerValue] == 0);
    isPublic = !isPublic;
    self.order.isPublic = isPublic ? @"0" : @"1";
    [publicButton setImage:[UIImage imageNamed:isPublic ? @"icon_selected.png" : @"icon_unselected.png"] forState:UIControlStateNormal];
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

- (void)didClickCarButton:(id)sender
{
    CarListViewController *carListViewController = [[CarListViewController alloc] init];
    carListViewController.selectBlock = ^(Car *car) {
        self.car = car;
        self.carNameLabel.text = [NSString stringWithFormat:@"%@ %@", car.carName, car.carColor];
    };
    carListViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:carListViewController animated:YES];
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
    [controller dismissViewControllerAnimated:NO completion:nil];//关键的一句   不能为YES
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
    _contentOffset = self.scrollView.contentOffset;
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
    self.scrollView.contentOffset = _contentOffset;
    
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

- (UIToolbar *)textFieldToobar
{
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.view.width, 44);
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(didClickCancelItem:)];
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(didClickDoneItem:)];
    
    toolbar.items = @[cancelItem, flexibleItem, doneItem];
    return toolbar;
}

- (void)setupStartTimeTextField
{
    self.startTimeTextField.inputView = self.datePicker;
    self.startTimeTextField.inputAccessoryView = [self textFieldToobar];
}

- (void)setupEndTimeTextField
{
    self.endTimeTextField.inputView = self.datePicker;
    self.endTimeTextField.inputAccessoryView = [self textFieldToobar];
}

- (void)setupRealStartTimeTextField
{
    self.realStartTimeTextField.inputView = self.datePicker;
    self.realStartTimeTextField.inputAccessoryView = [self textFieldToobar];
}

- (void)setupRealEndTimeTextField
{
    self.realEndTimeTextField.inputView = self.datePicker;
    self.realEndTimeTextField.inputAccessoryView = [self textFieldToobar];
}

- (void)setupCarTypeTextField
{
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    self.carTypeTextField.inputView = pickerView;
    self.carTypeTextField.inputAccessoryView = [self textFieldToobar];
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

- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
    
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
        if ([self.navigationController.viewControllers count] >= 2) {
            _scrollView.height += 49;
        }
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
        [_startPosition addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _startPosition;
}

- (YLYTipsTextField *)passPosition
{
    if (!_passPosition) {
        _passPosition = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, self.startPosition.bottom, self.startPosition.width, _cellHeight)];
        [_passPosition tipsTextFieldWithTips:@"经过地点" placeholder:@"请输入经过地点！" isPassword:NO];
        [self.scrollView addSubview:_passPosition];
        [_passPosition addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _passPosition;
}

- (YLYTipsTextField *)realPassPosition
{
    if (!_realPassPosition) {
        _realPassPosition = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, self.startPosition.bottom, self.startPosition.width, _cellHeight)];
        [_realPassPosition tipsTextFieldWithTips:@"实际经过地点" placeholder:@"请输入实际经过地点！" isPassword:NO];
        [self.scrollView addSubview:_realPassPosition];
        [_realPassPosition addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _realPassPosition;
}

- (YLYTipsTextField *)orderTime
{
    if (!_orderTime) {
        _orderTime = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [_orderTime tipsTextFieldWithTips:@"预约时间" placeholder:[NSDate convertStringFromDate:[NSDate date]] isPassword:NO];
        _orderTime.text = [NSDate convertStringFromDate:[NSDate date]];
        _orderTime.editEnable = NO;
        [self.scrollView addSubview:_orderTime];
        [_orderTime addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
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
        [_timeView addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _timeView;
}

- (UIView *)realTimeView
{
    if (!_realTimeView) {
        _realTimeView = [[UIView alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [self.scrollView addSubview:_realTimeView];
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, _cellHeight)];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.font = Font(12.0);
        timeLabel.text = @"实际使用时间";
        [_realTimeView addSubview:timeLabel];
        _realStartTimeButton = [ImageButton buttonWithType:UIButtonTypeCustom];
        _realStartTimeButton.frame = CGRectMake(timeLabel.right + 10, 0, (self.startPosition.width - timeLabel.width - 10 - 16)/2.0, _cellHeight);
        [_realStartTimeButton addTarget:self action:@selector(didClickStartButton:) forControlEvents:UIControlEventTouchUpInside];
        [_realStartTimeButton setWithText:nil imageName:@"downArrow.png"];
        _realStartTimeButton.text = [NSDate convertStringFromDate:[NSDate date]];
        [_realTimeView addSubview:_realStartTimeButton];
        _realStartTimeButton.fontSize = 12;
        _realStartTimeTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _realStartTimeTextField.delegate = self;
        [_realTimeView addSubview:_realStartTimeTextField];
        [self setupRealStartTimeTextField];
        UILabel *zhiLabel = [[UILabel alloc] initWithFrame:CGRectMake(_startTimeButton.right, 0, 16, _cellHeight)];
        zhiLabel.textAlignment = NSTextAlignmentCenter;
        zhiLabel.font = Font(12.0);
        zhiLabel.text = @"至";
        [_realTimeView addSubview:zhiLabel];
        _realEndTimeButton = [ImageButton buttonWithType:UIButtonTypeCustom];
        _realEndTimeButton.frame = CGRectMake(_startTimeButton.right + 16, 0, _startTimeButton.width, _cellHeight);
        [_realEndTimeButton addTarget:self action:@selector(didClickEndButton:) forControlEvents:UIControlEventTouchUpInside];
        [_realEndTimeButton setWithText:nil imageName:@"downArrow.png"];
        [_realTimeView addSubview:_realEndTimeButton];
        _realEndTimeButton.fontSize = _startTimeButton.fontSize;
        _realEndTimeTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _realEndTimeTextField.delegate = self;
        [_realTimeView addSubview:_realEndTimeTextField];
        [self setupRealEndTimeTextField];
        [_realTimeView addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _realTimeView;
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
        [_typeView addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _typeView;
}

- (YLYTipsTextField *)carNotes
{
    if (!_carNotes) {
        _carNotes = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [_carNotes tipsTextFieldWithTips:@"用车事宜" placeholder:@"" isPassword:NO];
        [self.scrollView addSubview:_carNotes];
        [_carNotes addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _carNotes;
}

- (UIView *)isPublicView
{
    if (!_isPublicView) {
        _isPublicView = [[UIView alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [self.scrollView addSubview:_isPublicView];
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, _cellHeight)];
        tipLabel.textAlignment = NSTextAlignmentRight;
        tipLabel.text = @"是否私用";
        tipLabel.font = Font(12);
        [_isPublicView addSubview:tipLabel];
        
        UIButton *publicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        publicButton.frame = CGRectMake(tipLabel.right + 10, 0, self.view.width - tipLabel.right - 10, _cellHeight);
        [publicButton setTitleColor:RGB(0x000000) forState:UIControlStateNormal];
        publicButton.titleLabel.font = Font(12);
        [publicButton setTitle:@"公用" forState:UIControlStateNormal];
        [publicButton setImage:[UIImage imageNamed:@"icon_unselected.png"] forState:UIControlStateNormal];
        [publicButton addTarget:self action:@selector(didClickPublicButton:) forControlEvents:UIControlEventTouchUpInside];
        [_isPublicView addSubview:publicButton];
        _publicButton = publicButton;
        [_isPublicView addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _isPublicView;
}

- (YLYTipsTextField *)passengerNumberTextField
{
    if (!_passengerNumberTextField) {
        _passengerNumberTextField = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [_passengerNumberTextField tipsTextFieldWithTips:@"乘车人数" placeholder:@"" isPassword:NO];
        _passengerNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self.scrollView addSubview:_passengerNumberTextField];
        [_passengerNumberTextField addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _passengerNumberTextField;
}

- (UIView *)carView
{
    if (!_carView) {
        _carView = [[UIView alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [self.scrollView addSubview:_carView];
        UILabel *driverLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, _cellHeight)];
        driverLabel.textAlignment = NSTextAlignmentRight;
        driverLabel.font = Font(12.0);
        driverLabel.text = @"选择车辆";
        [_carView addSubview:driverLabel];
        _carNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(driverLabel.right + 10, 0, 100, _cellHeight)];
        _carNameLabel.textAlignment = NSTextAlignmentLeft;
        _carNameLabel.textColor = [UIColor blackColor];
        _carNameLabel.font = Font(12);
        [_carView addSubview:_carNameLabel];
        UIButton *carButton = [UIButton buttonWithType:UIButtonTypeCustom];
        carButton.frame = CGRectMake(self.view.width - 60, (_carView.height - 40)/2.0, 40, 40);
        [carButton setBackgroundImage:[UIImage imageNamed:@"addDriver.jpg"] forState:UIControlStateNormal];
        [carButton addTarget:self action:@selector(didClickCarButton:) forControlEvents:UIControlEventTouchUpInside];
        [_carView addSubview:carButton];
        _carButton = carButton;
        [_carView addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _carView;
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
        [driverButton setBackgroundImage:[UIImage imageNamed:@"addDriver.jpg"] forState:UIControlStateNormal];
        [driverButton addTarget:self action:@selector(didClickDriverButton:) forControlEvents:UIControlEventTouchUpInside];
        [_driverView addSubview:driverButton];
        _driverButton = driverButton;
        [_driverView addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
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
        _passengerPhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _passengerPhoneTextField.placeholder = @"请输入乘车人电话！（如是本人可免）";
        [_passengerView addSubview:_passengerPhoneTextField];
        [_passengerView addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
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
        _orderDepNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(orderPersonLabel.right + 10, 0, 100, _cellHeight/3.0)];
        _orderDepNameLabel.textAlignment = NSTextAlignmentLeft;
        _orderDepNameLabel.textColor = [UIColor blackColor];
        _orderDepNameLabel.font = Font(12);
        _orderDepNameLabel.text = self.user.depName;
        [_orderPersonView addSubview:_orderDepNameLabel];
        _orderPersonNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(orderPersonLabel.right + 10, _orderDepNameLabel.bottom, 100, _cellHeight/3.0)];
        _orderPersonNameLabel.textAlignment = NSTextAlignmentLeft;
        _orderPersonNameLabel.textColor = [UIColor blackColor];
        _orderPersonNameLabel.font = Font(12);
        _orderPersonNameLabel.text = self.user.username;
        [_orderPersonView addSubview:_orderPersonNameLabel];
        _orderPersonPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(_orderPersonNameLabel.left, _orderPersonNameLabel.bottom, 100, _cellHeight/3.0)];
        _orderPersonPhoneLabel.textAlignment = NSTextAlignmentLeft;
        _orderPersonPhoneLabel.textColor = [UIColor blackColor];
        _orderPersonPhoneLabel.font = Font(12);
        _orderPersonPhoneLabel.text = self.user.phone;
        [_orderPersonView addSubview:_orderPersonPhoneLabel];
        [_orderPersonView addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _orderPersonView;
}

- (YLYTipsTextField *)tripDistanceTextField
{
    if (!_tripDistanceTextField) {
        _tripDistanceTextField = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [_tripDistanceTextField tipsTextFieldWithTips:@"行驶公里数" placeholder:@"" isPassword:NO];
        _tripDistanceTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self.scrollView addSubview:_tripDistanceTextField];
        [_tripDistanceTextField addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _tripDistanceTextField;
}

- (YLYTipsTextField *)pricePerKilometerTextField
{
    if (!_pricePerKilometerTextField) {
        _pricePerKilometerTextField = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [_pricePerKilometerTextField tipsTextFieldWithTips:@"公里单价/台班费" placeholder:@"" isPassword:NO];
        _pricePerKilometerTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self.scrollView addSubview:_pricePerKilometerTextField];
        [_pricePerKilometerTextField addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _pricePerKilometerTextField;
}

- (YLYTipsTextField *)roadChargeTextField
{
    if (!_roadChargeTextField) {
        _roadChargeTextField = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [_roadChargeTextField tipsTextFieldWithTips:@"停车过路费" placeholder:@"" isPassword:NO];
        _roadChargeTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self.scrollView addSubview:_roadChargeTextField];
        [_roadChargeTextField addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _roadChargeTextField;
}

- (YLYTipsTextField *)bridgeChargeTextField
{
    if (!_bridgeChargeTextField) {
        _bridgeChargeTextField = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [_bridgeChargeTextField tipsTextFieldWithTips:@"过桥费" placeholder:@"" isPassword:NO];
        _bridgeChargeTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self.scrollView addSubview:_bridgeChargeTextField];
        [_bridgeChargeTextField addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _bridgeChargeTextField;
}

- (YLYTipsTextField *)shenherenTextField
{
    if (!_shenherenTextField) {
        _shenherenTextField = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [_shenherenTextField tipsTextFieldWithTips:@"审核人" placeholder:@"" isPassword:NO];
        [self.scrollView addSubview:_shenherenTextField];
        [_shenherenTextField addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _shenherenTextField;
}

- (YLYTipsTextField *)shenheyijianTextField
{
    if (!_shenheyijianTextField) {
        _shenheyijianTextField = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [_shenheyijianTextField tipsTextFieldWithTips:@"审核意见" placeholder:@"" isPassword:NO];
        [self.scrollView addSubview:_shenheyijianTextField];
        [_shenheyijianTextField addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _shenheyijianTextField;
}

- (YLYTipsTextField *)bohuiyijianTextField
{
    if (!_bohuiyijianTextField) {
        _bohuiyijianTextField = [[YLYTipsTextField alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight)];
        [_bohuiyijianTextField tipsTextFieldWithTips:@"驳回意见" placeholder:@"" isPassword:NO];
        [self.scrollView addSubview:_bohuiyijianTextField];
        [_bohuiyijianTextField addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _bohuiyijianTextField;
}

- (CWStarRateView *)starRateView
{
    if (!_starRateView) {
        _starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(_gap, 0, self.startPosition.width, _cellHeight) numberOfStars:5];
        _starRateView.hasAnimation = NO;
        _starRateView.allowIncompleteStar = YES;
        _starRateView.delegate = self;
        [self.scrollView addSubview:_starRateView];
        [_starRateView addSubview:[UIView lineViewWithFrame:CGRectMake(_gap, _cellHeight - 0.5, _startPosition.width, 0.5)]];
    }
    return _starRateView;
}

- (UIButton *)orderButton
{
    if (!_orderButton) {
        _orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _orderButton.frame = CGRectMake((self.view.width - 250)/2.0, 0, 250, 44);
        _orderButton.backgroundColor = RGB(kMainColor);
        [_orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _orderButton.layer.cornerRadius = 2.5;
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
        _checkButton.frame = CGRectMake(buttonGap, 0, buttonWidth, 44);
        _checkButton.backgroundColor = RGB(kMainColor);
        [_checkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _checkButton.layer.cornerRadius = 2.5;
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
        _rejectButton.frame = CGRectMake(self.checkButton.right + buttonGap, 0, buttonWidth, 44);
        _rejectButton.backgroundColor = RGB(kMainColor);
        [_rejectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rejectButton.layer.cornerRadius = 2.5;
        [_rejectButton setTitle:@"驳 回" forState:UIControlStateNormal];
        [_rejectButton addTarget:self action:@selector(didClickRejectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:_rejectButton];
    }
    return _rejectButton;
}

@end
