//
//  Driver.h
//  orderTest
//
//  Created by wangxu on 15/9/23.
//  Copyright © 2015年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Driver : NSObject

@property (nonatomic, strong) NSString *driverID;
@property (nonatomic, strong) NSString *driverName;
@property (nonatomic, assign) NSInteger driverSexType;
@property (nonatomic, strong) NSString *driverSex;
@property (nonatomic, strong) NSString *driverOld;
@property (nonatomic, strong) NSString *driverPhone;
@property (nonatomic, strong) NSString *workTime;
@property (nonatomic, strong) NSString *driveImage;
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, assign) NSInteger stateType;
@property (nonatomic, strong) NSString *state;

+ (Driver *)driverWithDictionary:(NSDictionary *)dictionary;

@end
