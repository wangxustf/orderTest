//
//  YLYTipsTextField.m
//  E6Business
//
//  Created by wangxu on 15/9/3.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "YLYTipsTextField.h"

@interface YLYTipsTextField ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation YLYTipsTextField

- (void)tipsTextFieldWithTips:(NSString *)tips
                  placeholder:(NSString *)placeholder
                   isPassword:(BOOL)isPassword
{
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, self.height)];
    tipsLabel.font = Font(14.0);
    tipsLabel.textAlignment = NSTextAlignmentLeft;
    tipsLabel.text = tips;
    [self addSubview:tipsLabel];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(tipsLabel.right, 0, self.width - tipsLabel.right, self.height)];
    _textField.font = Font(14.0);
    _textField.secureTextEntry = isPassword;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.placeholder = placeholder;
    _textField.layer.cornerRadius = 5.0;
    _textField.layer.borderWidth = 1.0;
    _textField.layer.borderColor = [UIColor grayColor].CGColor;
    _textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:_textField];
}

- (NSString *)text
{
    return self.textField.text;
}

- (void)setText:(NSString *)text
{
    self.textField.text = text;
}

@end
