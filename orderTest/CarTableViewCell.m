//
//  DriverTableViewCell.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "CarTableViewCell.h"

@interface CarTableViewCell ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *plateNumberLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *colorLabel;
@property (nonatomic, strong) UILabel *driverLabel;
@property (nonatomic, strong) UILabel *sexLabel;
@property (nonatomic, strong) UILabel *jialingLabel;
@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation CarTableViewCell
{
    CGFloat _subHeight;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _subHeight = 22;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    _subHeight = 22;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCar
{
    self.portraitImageView.image = [UIImage imageNamed:@"phone.png"];
    self.nameLabel.text = @"xxx";
    self.plateNumberLabel.text = @"xxx";
    self.typeLabel.text = @"xxx";
    self.timeLabel.text = @"xxx";
    self.colorLabel.text = @"xxx";
    self.driverLabel.text = @"xxx";
    self.sexLabel.text = @"xxx";
    self.jialingLabel.text = @"xxx";
    self.statusLabel.text = @"xxx";
}

- (UIImageView *)portraitImageView
{
    if (!_portraitImageView) {
        _portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 66, 66)];
        [self.contentView addSubview:_portraitImageView];
    }
    return _portraitImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.portraitImageView.right, 0, 60, _subHeight)];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)plateNumberLabel
{
    if (!_plateNumberLabel) {
        _plateNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.right, self.nameLabel.top, 60, _subHeight)];
        [self.contentView addSubview:_plateNumberLabel];
    }
    return _plateNumberLabel;
}

- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.plateNumberLabel.right, self.nameLabel.top, 60, _subHeight)];
        [self.contentView addSubview:_typeLabel];
    }
    return _typeLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom, 60, _subHeight)];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)colorLabel
{
    if (!_colorLabel) {
        _colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeLabel.right, self.timeLabel.top, 60, _subHeight)];
        [self.contentView addSubview:_colorLabel];
    }
    return _colorLabel;
}

- (UILabel *)driverLabel
{
    if (!_driverLabel) {
        _driverLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.timeLabel.bottom, 60, _subHeight)];
        [self.contentView addSubview:_driverLabel];
    }
    return _driverLabel;
}

- (UILabel *)sexLabel
{
    if (!_sexLabel) {
        _sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.driverLabel.right, self.driverLabel.top, 60, _subHeight)];
        [self.contentView addSubview:_sexLabel];
    }
    return _sexLabel;
}

- (UILabel *)jialingLabel
{
    if (!_jialingLabel) {
        _jialingLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.sexLabel.right, self.driverLabel.top, 60, _subHeight)];
        [self.contentView addSubview:_jialingLabel];
    }
    return _jialingLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.colorLabel.right, self.nameLabel.bottom, 60, _subHeight)];
        [self.contentView addSubview:_statusLabel];
    }
    return _statusLabel;
}

@end
