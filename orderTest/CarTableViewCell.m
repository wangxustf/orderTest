//
//  DriverTableViewCell.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "CarTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface CarTableViewCell ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *colorLabel;
@property (nonatomic, strong) UILabel *plateNumberLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation CarTableViewCell
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

- (void)setCar:(Car *)car
{
    NSArray *imageSelectedArray = @[@"icon_jingji_selected.png", @"icon_shushi_selected.png", @"icon_haohua_selected.png", @"icon_shangwu_selected.png", @"icon_16zuo_selected.png", @"icon_32zuo_selected.png"];
    [self.portraitImageView setImageWithURL:[NSURL URLWithString:car.carImage] placeholderImage:[UIImage imageNamed:imageSelectedArray[self.carType - 1]]];
    self.nameLabel.text = car.carName;
    self.nameLabel.width = [self.nameLabel.text sizeWithFont:self.nameLabel.font].width;
    self.colorLabel.left = self.nameLabel.right;
    self.colorLabel.text = car.carColor;
    self.colorLabel.width = [self.colorLabel.text sizeWithFont:self.colorLabel.font].width;
    self.typeLabel.text = car.carType;
    self.typeLabel.width = [self.typeLabel.text sizeWithFont:self.typeLabel.font].width;
    self.plateNumberLabel.text = car.carCode;
    self.plateNumberLabel.width = [self.plateNumberLabel.text sizeWithFont:self.plateNumberLabel.font].width;
    self.statusLabel.text = car.carState;
    self.lineView.top = 44.5;
}

- (UIImageView *)portraitImageView
{
    if (!_portraitImageView) {
        _portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        [self.contentView addSubview:_portraitImageView];
    }
    return _portraitImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.portraitImageView.right, 0, 60, _subHeight)];
        _nameLabel.font = Font(15);
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)colorLabel
{
    if (!_colorLabel) {
        _colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.right, self.nameLabel.top, 60, _subHeight)];
        _colorLabel.font = Font(15);
        [self.contentView addSubview:_colorLabel];
    }
    return _colorLabel;
}

- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom, 60, _subHeight)];
        _typeLabel.font = Font(15);
        [self.contentView addSubview:_typeLabel];
    }
    return _typeLabel;
}

- (UILabel *)plateNumberLabel
{
    if (!_plateNumberLabel) {
        _plateNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.typeLabel.bottom, 60, _subHeight)];
        _plateNumberLabel.font = Font(15);
        [self.contentView addSubview:_plateNumberLabel];
    }
    return _plateNumberLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 70, self.nameLabel.bottom, 60, _subHeight)];
        _statusLabel.font = Font(15);
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
