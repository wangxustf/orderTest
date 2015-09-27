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

@interface Service : NSObject

- (void)loginWithLoginName:(NSString *)loginName password:(NSString *)password completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion;
- (void)loadCarInfoWithDeviceID:(NSString *)deviceID carType:(NSString *)carType completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion;
- (void)loadDingCheWithOrder:(Order *)order completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion;
- (void)loadDincheWeiwanchengWithUserID:(NSString *)userID completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion;
- (void)loadDincheYiwanchengWithUserID:(NSString *)userID completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion;
- (void)loadDriverWithDeviceID:(NSString *)deviceID carID:(NSString *)carID completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion;
- (void)loadHistoryDriverJinxingzhongWithUserID:(NSString *)userID completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion;
- (void)loadHistoryDriverJijieshuWithUserID:(NSString *)userID completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion;
- (void)loadMolleageUserID:(NSString *)userID completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion;

@end
