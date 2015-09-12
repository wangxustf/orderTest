//
//  YLYTipsTextField.h
//  E6Business
//
//  Created by wangxu on 15/9/3.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLYTipsTextField : UIView

@property (nonatomic, strong) NSString *text;

- (void)tipsTextFieldWithTips:(NSString *)tips
                  placeholder:(NSString *)placeholder
                   isPassword:(BOOL)isPassword;

@end
