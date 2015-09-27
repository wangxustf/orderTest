//
//  DriverTableViewCell.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "RecordTableViewCell.h"

@interface RecordTableViewCell ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *plateNumberLabel;
@property (nonatomic, strong) UILabel *drvierLabel;
@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation RecordTableViewCell
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

- (void)setOrder:(Order *)order
{
    
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

- (UILabel *)plateNumberLabel
{
    if (!_plateNumberLabel) {
        _plateNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.right, self.nameLabel.bottom, 60, _subHeight)];
        [self.contentView addSubview:_plateNumberLabel];
    }
    return _plateNumberLabel;
}

- (UILabel *)drvierLabel
{
    if (!_drvierLabel) {
        _drvierLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom, 60, _subHeight)];
        [self.contentView addSubview:_drvierLabel];
    }
    return _drvierLabel;
}

- (UILabel *)userLabel
{
    if (!_userLabel) {
        _userLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.drvierLabel.right, self.nameLabel.top, 60, _subHeight)];
        [self.contentView addSubview:_userLabel];
    }
    return _userLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.plateNumberLabel.right, 0, 60, _subHeight)];
        [self.contentView addSubview:_statusLabel];
    }
    return _statusLabel;
}

@end
