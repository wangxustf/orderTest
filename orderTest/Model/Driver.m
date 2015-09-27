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
    driver.driverID     = [dictionary strValue:@"driverId"];
    driver.driverName   = [dictionary strValue:@"driverName"];
    driver.driverSexType    = [dictionary intValue:@"driverSex"];
//    driver.driverSex    = @[@"男", @"女"][driver.driverSexType];
    driver.driverOld    = [dictionary strValue:@"driverOld"];
    driver.driverPhone  = [dictionary strValue:@"driverPhone"];
    driver.workTime     = [dictionary strValue:@"workTime"];
    driver.driveImage   = [dictionary strValue:@"driveImage"];
    driver.idNumber     = [dictionary strValue:@"idNumber"];
    driver.stateType        = [dictionary intValue:@"state"];
    driver.state    = @[@"空闲", @"已预约", @"使用中"][driver.stateType];
    return driver;
}

@end
