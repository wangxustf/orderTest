//
//  Car.m
//  orderTest
//
//  Created by wangxu on 15/9/23.
//  Copyright © 2015年 wangxu. All rights reserved.
//

#import "Car.h"
#import "NSDictionary+NSDictionary_Addition.h"

@implementation Car

+ (Car *)carWithDictionary:(NSDictionary *)dictionary
{
    Car *car = [[Car alloc] init];
    return car;
}

@end
