//
//  Service.h
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLYUser.h"
#import "Order.h"

extern NSString *YLYBaseURL;

@interface Service : NSObject

- (void)resetPage;
- (void)loginWithLoginName:(NSString *)loginName password:(NSString *)password completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion;
- (void)loadCarListWithDriverID:(NSString *)deviceID carType:(NSString *)carType completion:(void(^)(BOOL success, NSArray *carsArray, NSString *msg))completion;
- (void)DingCheWithOrder:(Order *)order completion:(void(^)(BOOL success, NSString *msg))completion;
- (void)loadOrderListWithUserID:(NSString *)userID finishType:(int)finishType isDriver:(BOOL)isDriver completion:(void(^)(BOOL success, NSArray *ordersArray, NSString *msg))completion;
- (void)loadDriverListWithCarID:(NSString *)carID completion:(void(^)(BOOL success, NSArray *driversArray, NSString *msg))completion;
- (void)loadMolleageListWithUserID:(NSString *)userID completion:(void(^)(BOOL success, NSArray *ordersArray, NSString *msg))completion;

@end
