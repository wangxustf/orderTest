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
    order.orderID               = [dictionary strValue:@"orderId"];
    order.jiecheAddress         = [dictionary strValue:@"jiecheAddress"];
    order.jingguoAddress        = [dictionary strValue:@"jingguoAddress"];
    order.realJingguoAddress    = [dictionary strValue:@"realJingguoAddress"];
    order.yuyueTime             = [dictionary strValue:@"yuyueTime"];
    order.startTime             = [dictionary strValue:@"startTime"];
    order.endTime               = [dictionary strValue:@"endTime"];
    order.realStartTime         = [dictionary strValue:@"realStartTime"];
    order.realEndTime           = [dictionary strValue:@"realEndTime"];
    order.isPublic              = [dictionary strValue:@"isPublic"];
    order.carType               = [dictionary strValue:@"carType"];
    order.userName              = [dictionary strValue:@"userName"];
    order.userPhone             = [dictionary strValue:@"userPhone"];
    order.carID                 = [dictionary strValue:@"carID"];
    order.dingcherenID          = [dictionary strValue:@"dingcherenID"];
    order.dingcherenPhone       = [dictionary strValue:@"dingcherenPhone"];
    order.dingcherenDep         = [dictionary strValue:@"dingcherenDep"];
    order.dingcherenDepID       = [dictionary strValue:@"dingcherenDepID"];
    order.orderState            = [dictionary strValue:@"orderState"];
    order.shenpirenName         = [dictionary strValue:@"shenpirenName"];
    order.shenpirenID           = [dictionary strValue:@"shenpirenID"];
    order.driverID              = [dictionary strValue:@"driverID"];
    order.driverName            = [dictionary strValue:@"driverName"];
    order.driverPhone           = [dictionary strValue:@"driverPhone"];
    order.startMetre            = [dictionary strValue:@"startMetre"];
    order.endMetre              = [dictionary strValue:@"endMetre"];
    order.shenheYiJian          = [dictionary strValue:@"shenheYiJian"];
    order.facheYijian           = [dictionary strValue:@"facheYijian"];
    order.bohuiYuanYin          = [dictionary strValue:@"bohuiYuanYin"];
    order.countMetre            = [dictionary strValue:@"countMetre"];
    order.pingjia               = [dictionary strValue:@"pingjia"];
    return order;
}

@end
