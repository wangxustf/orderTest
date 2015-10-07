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
    order.jingguoAddress        = [dictionary strValue:@"jingguoAdress"];
    order.realJingguoAddress    = [dictionary strValue:@"realJingguoAdres"];
    order.yuyueTime             = [dictionary strValue:@"yuyueTime"];
    order.startTime             = [dictionary strValue:@"startTime"];
    order.endTime               = [dictionary strValue:@"endTime"];
    order.realStartTime         = [dictionary strValue:@"realStartTime"];
    order.realEndTime           = [dictionary strValue:@"realEndTime"];
    order.isPublic              = [dictionary strValue:@"isPublic"];
    order.carType               = [dictionary strValue:@"carType"];
    order.userName              = [dictionary strValue:@"userName"];
    order.userPhone             = [dictionary strValue:@"userPhone"];
    order.carID                 = [dictionary strValue:@"carId"];
    order.dingcherenID          = [dictionary strValue:@"dingcherenId"];
    order.dingcherenName        = [dictionary strValue:@"dingcherenName"];
    order.dingcherenPhone       = [dictionary strValue:@"dingcherenPhone"];
    order.dingcherenDep         = [dictionary strValue:@"dingcherenDep"];
    order.dingcherenDepID       = [dictionary strValue:@"dingcherenDepId"];
    order.orderState            = [dictionary strValue:@"orderState"];
    order.shenpirenName         = [dictionary strValue:@"shenpirenName"];
    order.shenpirenID           = [dictionary strValue:@"shenpirenId"];
    order.paicherenID           = [dictionary strValue:@"paicherenId"];
    order.driverID              = [dictionary strValue:@"driverId"];
    order.driverName            = [dictionary strValue:@"driverName"];
    order.driverPhone           = [dictionary strValue:@"driverPhone"];
    order.startMetre            = [dictionary strValue:@"startMetre"];
    order.endMetre              = [dictionary strValue:@"endMetre"];
    order.shenheYiJian          = [dictionary strValue:@"shenheYiJian"];
    order.facheYijian           = [dictionary strValue:@"facheYijian"];
    order.bohuiYuanYin          = [dictionary strValue:@"bohuiYuanYin"];
    order.countMetre            = [dictionary strValue:@"countMetre"];
    order.pingjia               = [dictionary strValue:@"pingjia"];
    order.yongcheyijian         = [dictionary strValue:@"yongcheyijian"];
    order.tingcheguolufei       = [dictionary strValue:@"tingcheguolufei"];
    order.gonglidanjia          = [dictionary strValue:@"gonglidanjia"];
    order.guoqiaofei            = [dictionary strValue:@"guoqiaofei"];
    return order;
}

- (id)copyWithZone:(NSZone *)zone
{
    Order *order = [[self class] allocWithZone:zone];
    order.orderID               = [self.orderID copy];
    order.jiecheAddress         = [self.jiecheAddress copy];
    order.jingguoAddress        = [self.jingguoAddress copy];
    order.realJingguoAddress    = self.realJingguoAddress;
    order.yuyueTime             = self.yuyueTime;
    order.startTime             = self.startTime;
    order.endTime               = self.endTime;
    order.realStartTime         = self.realStartTime;
    order.realEndTime           = self.realEndTime;
    order.isPublic              = self.isPublic;
    order.carType               = self.carType;
    order.userName              = self.userName;
    order.userPhone             = self.userPhone;
    order.carID                 = self.carID;
    order.dingcherenID          = self.dingcherenID;
    order.dingcherenName        = self.dingcherenName;
    order.dingcherenPhone       = self.dingcherenPhone;
    order.dingcherenDep         = self.dingcherenDep;
    order.dingcherenDepID       = self.dingcherenDepID;
    order.orderState            = self.orderState;
    order.shenpirenName         = self.shenpirenName;
    order.shenpirenID           = self.shenpirenID;
    order.driverID              = self.driverID;
    order.driverName            = self.driverName;
    order.driverPhone           = self.driverPhone;
    order.startMetre            = self.startMetre;
    order.endMetre              = self.endMetre;
    order.shenheYiJian          = self.shenheYiJian;
    order.facheYijian           = self.facheYijian;
    order.bohuiYuanYin          = self.bohuiYuanYin;
    order.countMetre            = self.countMetre;
    order.pingjia               = self.pingjia;
    order.yongcheyijian         = self.yongcheyijian;
    order.tingcheguolufei       = self.tingcheguolufei;
    order.gonglidanjia          = self.gonglidanjia;
    order.guoqiaofei            = self.guoqiaofei;
    return order;
}

@end
