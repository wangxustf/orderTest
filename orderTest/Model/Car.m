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
    car.carID = [dictionary strValue:@"carId"];
    car.carName     = [dictionary strValue:@"carName"];
    car.carCode     = [dictionary strValue:@"carCode"];
    car.carImage    = [dictionary strValue:@"carImage"];
    car.carColor    = [dictionary strValue:@"carColor"];
    car.carType     = [dictionary strValue:@"carType"];
    car.carState    = [dictionary strValue:@"carState"];
    car.carPaiLiang = [dictionary strValue:@"carPaiLiang"];
    car.startTime   = [dictionary strValue:@"startTime"];
    car.endTime     = [dictionary strValue:@"endTime"];
    car.workTime    = [dictionary strValue:@"workTime"];
    return car;
}

@end
