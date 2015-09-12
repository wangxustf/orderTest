//
//  NSUserDefaults+Addition.h
//  E6Business
//
//  Created by wangxu on 15/9/1.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLYUser.h"

@interface NSUserDefaults (Addition)

+ (void)saveUser:(YLYUser *)user;
+ (YLYUser *)user;

+ (void)saveCarTreeArray:(NSArray *)carTreeArray;
+ (NSArray *)carTreeArray;

+ (void)saveVersion:(NSString *)version;
+ (NSString *)version;

@end
