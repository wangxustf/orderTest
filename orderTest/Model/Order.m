//
//  Order.m
//  orderTest
//
//  Created by wangxu on 15/9/12.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "Order.h"
#import "NSDictionary+NSDictionary_Addition.h"

@implementation Order

+ (Order *)orderWithDictionary:(NSDictionary *)dictionary
{
    Order *order = [[Order alloc] init];
    return order;
}

@end
