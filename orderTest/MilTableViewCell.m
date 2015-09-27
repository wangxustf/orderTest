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
    self.nameLabel.text = order.dingcherenPhone;
    self.nameLabel.width = [self.nameLabel.text sizeWithFont:self.nameLabel.font].width;
    self.milsLabel.text = @"里程：";
    self.lineView.top = 43.5;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)milsLabel
{
    if (!_milsLabel) {
        _milsLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.right, 0, self.width - self.nameLabel.right, 44)];
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
