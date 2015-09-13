//
//  NSDate+Addition.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "NSDate+Addition.h"

@implementation NSDate (Addition)

+ (NSDate *)convertDateFromString:(NSString *)uiDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy年MM月dd日hh时"];
    NSDate *date = [formatter dateFromString:uiDate];
    return date;
}

+ (NSString *)convertStringFromDate:(NSDate *)uiDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy年MM月dd日hh时"];
    NSString *date = [formatter stringFromDate:uiDate];
    return date;
}

@end
