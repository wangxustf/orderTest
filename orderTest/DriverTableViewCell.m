//
//  DriverTableViewCell.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "DriverTableViewCell.h"

@interface DriverTableViewCell ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *sexLabel;
@property (nonatomic, strong) UILabel *jialingLabel;
@property (nonatomic, strong) UILabel *plateNumberLabel;
@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation DriverTableViewCell
{
    CGFloat _subHeight;
}

- (void)awakeFromNib {
    // Initialization code
    _subHeight = 22;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)portraitImageView
{
    if (!_portraitImageView) {
        _portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
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

- (UILabel *)sexLabel
{
    if (!_sexLabel) {
        _sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.right, self.nameLabel.top, 60, _subHeight)];
        [self.contentView addSubview:_sexLabel];
    }
    return _sexLabel;
}

- (UILabel *)jialingLabel
{
    if (!_jialingLabel) {
        _jialingLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.sexLabel.right, self.nameLabel.top, 60, _subHeight)];
        [self.contentView addSubview:_jialingLabel];
    }
    return _jialingLabel;
}

- (UILabel *)plateNumberLabel
{
    if (!_plateNumberLabel) {
        _plateNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.portraitImageView.right, self.nameLabel.bottom, 60, _subHeight)];
        [self.contentView addSubview:_plateNumberLabel];
    }
    return _plateNumberLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.jialingLabel.right, 0, 60, _subHeight)];
        [self.contentView addSubview:_statusLabel];
    }
    return _statusLabel;
}

@end
