//
//  ImageButton.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "ImageButton.h"

@interface ImageButton ()

@property (nonatomic, strong) UILabel *telLabel;
@property (nonatomic, strong) UIImageView *telImageView;

@end

@implementation ImageButton

- (NSString *)text
{
    return self.telLabel.text;
}

- (void)setText:(NSString *)text
{
    self.telLabel.text = text;
}

- (void)setFontSize:(CGFloat)fontSize
{
    self.telLabel.font = Font(fontSize);
}

- (CGFloat)fontSize
{
    return self.telLabel.font.pointSize;
}

- (void)setWithText:(NSString *)text imageName:(NSString *)imageName
{
    self.telLabel.text = text;
    self.telImageView.image = [UIImage imageNamed:imageName];
}

- (UILabel *)telLabel
{
    if (!_telLabel) {
        _telLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, self.height)];
        _telLabel.textAlignment = NSTextAlignmentLeft;
        _telLabel.font = Font(18.0);
        _telLabel.textColor = RGB(0x000000);
        [self addSubview:_telLabel];
        
        _telImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 50, (self.height - 40)/2.0, 40, 40)];
        [self addSubview:_telImageView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - kLineHeight, self.width, kLineHeight)];
        lineView.backgroundColor = RGB(kLineColor);
        [self addSubview:lineView];
    }
    return _telLabel;
}

@end
