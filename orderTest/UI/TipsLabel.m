//
//  TipsLabel.m
//  orderTest
//
//  Created by wangxu on 15/9/27.
//  Copyright © 2015年 wangxu. All rights reserved.
//

#import "TipsLabel.h"

@interface TipsLabel ()

@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation TipsLabel

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, self.height)];
        _tipsLabel.textAlignment = NSTextAlignmentRight;
        _tipsLabel.font = Font(12);
        [self addSubview:_tipsLabel];
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(_tipsLabel.right + 10, 0, self.width - _tipsLabel.right - 10, self.height)];
        _valueLabel.font = Font(12);
        [self addSubview:_valueLabel];
    }
    return self;
}

- (void)setWithTip:(NSString *)tip value:(NSString *)value
{
    self.tipsLabel.text = tip;
    self.valueLabel.text = value;
}

@end
