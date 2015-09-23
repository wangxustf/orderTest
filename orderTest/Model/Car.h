//
//  Car.h
//  orderTest
//
//  Created by wangxu on 15/9/23.
//  Copyright © 2015年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

@property (nonatomic, strong) NSString *carID;
@property (nonatomic, strong) NSString *carName;
@property (nonatomic, strong) NSString *carCode;
@property (nonatomic, strong) NSString *carImage;
@property (nonatomic, strong) NSString *carColor;
@property (nonatomic, strong) NSString *carType;
@property (nonatomic, strong) NSString *carState;
@property (nonatomic, strong) NSString *carPaiLiang;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *workTime;

+ (Car *)carWithDictionary:(NSDictionary *)dictionary;

@end
