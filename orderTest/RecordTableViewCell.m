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
        NSString *status = @"";
        switch ([order.orderState integerValue]) {
            case 0:
                status = @"订车";
                break;
                
            case 1:
                status = @"审核通过";
                break;
                
            case 11:
                status = @"审核驳回";
                break;
                
            case 2:
                status = @"派车人派车";
                break;
                
            case 22:
                status = @"派车人驳回";
                break;
                
            case 3:
                status = @"司机确认";
                break;
                
            case 33:
                status = @"司机驳回";
                break;
                
            case 4:
                status = @"派车人确认发车";
                break;
                
            case 5:
                status = @"司机开始";
                break;
                
            case 6:
                status = @"司机结束";
                break;
                
            case 7:
                status = @"客户确认评价";
                break;
                
            case 8:
                status = @"流程终了";
                break;
                
            default:
                break;
        }
        self.statusLabel.text = status;
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
        _timeLabel = [[TipsLabel alloc] initWithFrame:CGRectMake(self.orderNameLabel.left, self.addressLabel.bottom, self.width, _subHeight)];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 110, 0, 100, 60)];
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
