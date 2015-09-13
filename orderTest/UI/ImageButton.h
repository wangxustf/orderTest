//
//  ImageButton.h
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageButton : UIButton

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) CGFloat fontSize;

- (void)setWithText:(NSString *)text imageName:(NSString *)imageName;

@end
