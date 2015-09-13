//
//  NSDate+Addition.h
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)

+ (NSDate *)convertDateFromString:(NSString *)uiDate;
+ (NSString *)convertStringFromDate:(NSDate *)uiDate;

@end
