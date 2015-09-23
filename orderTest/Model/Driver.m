//
//  Driver.m
//  orderTest
//
//  Created by wangxu on 15/9/23.
//  Copyright © 2015年 wangxu. All rights reserved.
//

#import "Driver.h"
#import "NSDictionary+NSDictionary_Addition.h"

@implementation Driver

+ (Driver *)driverWithDictionary:(NSDictionary *)dictionary
{
    Driver *driver = [[Driver alloc] init];
    return driver;
}

@end
