//
//  DriverTableViewCell.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "DriverTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface DriverTableViewCell ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *sexLabel;
@property (nonatomic, strong) UILabel *jialingLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation DriverTableViewCell
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

- (void)setDriver:(Driver *)driver
{
    [self.portraitImageView setImageWithURL:[NSURL URLWithString:driver.driveImage] placeholderImage:[UIImage imageNamed:@"mine.png"]];
    self.nameLabel.text = driver.driverName;
    self.sexLabel.text = driver.driverSex;
    self.jialingLabel.text = driver.driverOld;
    self.phoneLabel.text = driver.driverPhone;
    self.stateLabel.text = driver.state;
    self.lineView.top = 43.5;
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
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.portraitImageView.right, 0, 45, _subHeight)];
        _nameLabel.font = Font(12);
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)sexLabel
{
    if (!_sexLabel) {
        _sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.right, self.nameLabel.top, 20, _subHeight)];
        _sexLabel.font = Font(12);
        [self.contentView addSubview:_sexLabel];
    }
    return _sexLabel;
}

- (UILabel *)jialingLabel
{
    if (!_jialingLabel) {
        _jialingLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.sexLabel.right, self.nameLabel.top, 60, _subHeight)];
        _jialingLabel.font = Font(12);
        [self.contentView addSubview:_jialingLabel];
    }
    return _jialingLabel;
}

- (UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.portraitImageView.right, self.nameLabel.bottom, 150, _subHeight)];
        _phoneLabel.font = Font(12);
        [self.contentView addSubview:_phoneLabel];
    }
    return _phoneLabel;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 54, 0, 44, 44)];
        _stateLabel.textColor = [UIColor redColor];
        _stateLabel.textAlignment = NSTextAlignmentRight;
        _stateLabel.font = Font(14);
        [self.contentView addSubview:_stateLabel];
    }
    return _stateLabel;
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
