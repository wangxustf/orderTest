//
//  ArrowButton.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "ArrowButton.h"

@interface ArrowButton ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation ArrowButton

- (void)setText:(NSString *)text
{
    self.textLabel.text = text;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, self.height)];
        _textLabel.textAlignment = NSTextAlignmentLeft;
        _textLabel.font = Font(18.0);
        _textLabel.textColor = RGB(0x000000);
        [self addSubview:_textLabel];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 20, (self.height - 8)/2.0, 5, 8)];
        arrowImageView.image = [UIImage imageNamed:@"arrow.png"];
        [self addSubview:arrowImageView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - kLineHeight, self.width, kLineHeight)];
        lineView.backgroundColor = RGB(kLineColor);
        [self addSubview:lineView];
    }
    return _textLabel;
}

@end
