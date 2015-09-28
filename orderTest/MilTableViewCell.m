//
//  MilTableViewCell.m
//  orderTest
//
//  Created by wangxu on 15/9/27.
//  Copyright © 2015年 wangxu. All rights reserved.
//

#import "MilTableViewCell.h"

@interface MilTableViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *milsLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation MilTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrder:(Order *)order
{
    self.nameLabel.text = order.dingcherenName;
    self.addressLabel.text = [NSString stringWithFormat:@"%@ %@", order.jiecheAddress, order.jingguoAddress];
    self.addressLabel.width = [self.addressLabel.text sizeWithFont:self.addressLabel.font].width;
    self.timeLabel.text = order.yuyueTime;
    self.timeLabel.width = [self.timeLabel.text sizeWithFont:self.timeLabel.font].width;
    self.milsLabel.text = @"里程：";
    self.lineView.top = 43.5;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        _nameLabel.font = Font(16);
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.right, 0, 100, 22)];
        _addressLabel.font = Font(16);
        [self.contentView addSubview:_addressLabel];
    }
    return _addressLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.addressLabel.left, self.addressLabel.bottom, 100, 22)];
        _timeLabel.font = Font(16);
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)milsLabel
{
    if (!_milsLabel) {
        _milsLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 70, 0, 60, 44)];
        _milsLabel.font = Font(16);
        _milsLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_milsLabel];
    }
    return _milsLabel;
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
