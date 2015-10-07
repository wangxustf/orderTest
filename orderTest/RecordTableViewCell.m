//
//  DriverTableViewCell.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "RecordTableViewCell.h"
#import "TipsLabel.h"

@interface RecordTableViewCell ()

@property (nonatomic, strong) TipsLabel *orderNameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) TipsLabel *passengerLabel;
@property (nonatomic, strong) TipsLabel *addressLabel;
@property (nonatomic, strong) UILabel *plateNumberLabel;
@property (nonatomic, strong) TipsLabel *timeLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation RecordTableViewCell
{
    CGFloat _subHeight;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _subHeight = 15;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    _subHeight = 15;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrder:(Order *)order
{
    if (_order != order) {
        _order = order;
        [self.orderNameLabel setWithTip:@"订车人" value:order.dingcherenName];
        self.phoneLabel.text = order.dingcherenPhone;
        [self.passengerLabel setWithTip:@"乘车人" value:order.userName];
        [self.addressLabel setWithTip:@"接车地点" value:order.jiecheAddress];
        [self.timeLabel setWithTip:@"用车时间" value:[NSString stringWithFormat:@"%@ 至 %@", order.startTime, order.endTime]];
        self.statusLabel.text = self.finished ? @"已审批" : @"未审批";
        self.lineView.top = 59.5;
    }
}

- (TipsLabel *)orderNameLabel
{
    if (!_orderNameLabel) {
        _orderNameLabel = [[TipsLabel alloc] initWithFrame:CGRectMake(0, 0, 140, _subHeight)];
        [self.contentView addSubview:_orderNameLabel];
    }
    return _orderNameLabel;
}

- (UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.orderNameLabel.right, self.orderNameLabel.top, self.orderNameLabel.width, _subHeight)];
        _phoneLabel.font = Font(12);
        [self.contentView addSubview:_phoneLabel];
    }
    return _plateNumberLabel;
}

- (TipsLabel *)passengerLabel
{
    if (!_passengerLabel) {
        _passengerLabel = [[TipsLabel alloc] initWithFrame:CGRectMake(self.orderNameLabel.left, self.orderNameLabel.bottom, self.orderNameLabel.width, _subHeight)];
        [self.contentView addSubview:_passengerLabel];
    }
    return _passengerLabel;
}

- (TipsLabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[TipsLabel alloc] initWithFrame:CGRectMake(self.orderNameLabel.left, self.passengerLabel.bottom, self.width - 40, _subHeight)];
        [self.contentView addSubview:_addressLabel];
    }
    return _addressLabel;
}

- (TipsLabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[TipsLabel alloc] initWithFrame:CGRectMake(self.orderNameLabel.left, self.addressLabel.bottom, self.width - 40, _subHeight)];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 80, 0, 60, 60)];
        _statusLabel.font = Font(14);
        _statusLabel.textColor = [UIColor redColor];
        _statusLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_statusLabel];
    }
    return _statusLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        _lineView.backgroundColor = RGB(0xe5e5e5);
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

@end
