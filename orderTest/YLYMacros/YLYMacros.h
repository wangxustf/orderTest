//
//  YLYMacros.h
//  E6Business
//
//  Created by wangxu on 15/9/2.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#ifndef E6Business_YLYMacros_h
#define E6Business_YLYMacros_h

//#define YLYBaseURL @"http://192.168.1.5:8080/sys"
#define YLYBaseURL @"http://117.34.115.26:8080/sys"

#define RGB(color) [UIColor colorWithRed:(color >> 16)/255.0 green:((color >> 8) & 0x00ff)/255.0 blue:(color & 0x0000ff)/255.0 alpha:1]
#define Font(size) [UIFont systemFontOfSize:size]
#define BoldFont(size) [UIFont boldSystemFontOfSize:size]

#define kLineHeight 0.5
#define kLineColor 0xe5e5e5
#define kMainColor 0x00afcc

#define Success 1

#endif
