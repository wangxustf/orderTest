//
//  Order.h
//  orderTest
//
//  Created by wangxu on 15/9/12.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject

@property (nonatomic, strong) NSString *deviceID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *jiecheAddress;
@property (nonatomic, strong) NSString *jingguoAddress;
@property (nonatomic, strong) NSString *yuyueTime;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *realStartTime;
@property (nonatomic, strong) NSString *realEndTime;
@property (nonatomic, strong) NSString *carType;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userPhone;
@property (nonatomic, strong) NSString *dingcherenName;
@property (nonatomic, strong) NSString *dingcherenPhone;
@property (nonatomic, strong) NSString *dingcherenDep;
@property (nonatomic, strong) NSString *dingcherenDepID;
@property (nonatomic, strong) NSString *orderState;
@property (nonatomic, strong) NSString *shenpirenName;
@property (nonatomic, strong) NSString *shenpirenID;
@property (nonatomic, strong) NSString *carCode;
@property (nonatomic, strong) NSString *driverName;
@property (nonatomic, strong) NSString *driverPhone;
@property (nonatomic, strong) NSString *startMetre;
@property (nonatomic, strong) NSString *endMetre;
@property (nonatomic, strong) NSString *shenheYiJian;
@property (nonatomic, strong) NSString *facheYijian;
@property (nonatomic, strong) NSString *bohuiYuanYin;

@end
