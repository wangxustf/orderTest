//
//  Service.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "Service.h"
#import "AFHTTPRequestOperationManager.h"
#import "YLYUser.h"
#import "Order.h"
#import "Car.h"
#import "Driver.h"

@implementation Service
{
    NSInteger _page;
}

- (id)init
{
    if (self = [super init]) {
        _page = 1;
    }
    return self;
}

- (void)resetPage
{
    _page = 1;
}

- (void)loginWithLoginName:(NSString *)loginName password:(NSString *)password completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    NSDictionary *parameters = @{@"loginName":loginName,
                                 @"password":password};
    [manager GET:[NSString stringWithFormat:@"%@/mobileLoginForIphone.html", YLYBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (completion != nil) {
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     YLYUser *user = [YLYUser userWithDictionary:responseObject];
                     [NSUserDefaults saveUser:user];
                     completion(YES, user, nil);
                 } else {
                     completion(NO, nil, nil);
                 }
             }
             NSLog(@"JSON: %@", responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (completion) {
                 completion(NO, nil, nil);
             }
             NSLog(@"Error: %@", error);
         }];
}

- (void)loadCarInfoWithDriverID:(NSString *)driverID carType:(NSString *)carType completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"driverId":driverID,
                                 @"index":carType};
    [manager POST:[NSString stringWithFormat:@"%@/mobileCarInfo.html", YLYBaseURL]
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (completion != nil) {
                  if ([responseObject isKindOfClass:[NSDictionary class]]) {
                      YLYUser *user = [YLYUser userWithDictionary:responseObject];
                      completion(YES, user, nil);
                  } else {
                      completion(NO, nil, nil);
                  }
              }
              //NSLog(@"JSON: %@", responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (completion) {
                  completion(NO, nil, nil);
              }
              //NSLog(@"Error: %@", error);
          }];
}

- (void)loadDingCheWithOrder:(Order *)order completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"orderId":order.orderID,
                                 @"jiecheAddress":order.jiecheAddress,
                                 @"jingguoAddress":order.jingguoAddress,
                                 @"realJingguoAddress":order.realJingguoAddress,
                                 @"yuyueTime":order.yuyueTime,
                                 @"startTime":order.startTime,
                                 @"endTime":order.endTime,
                                 @"realStartTime":order.realStartTime,
                                 @"realEndTime":order.realEndTime,
                                 @"isPublic":order.isPublic,
                                 @"carType":order.carType,
                                 @"userName":order.userName,
                                 @"userPhone":order.userPhone,
                                 @"carId":order.carID,
                                 @"dingcherenId":order.dingcherenID,
                                 @"dingcherenName":order.dingcherenName,
                                 @"dingcherenPhone":order.dingcherenPhone,
                                 @"dingcherenDep":order.dingcherenDep,
                                 @"dingcherenDepId":order.dingcherenDepID,
                                 @"orderState":order.orderState,
                                 @"shenpirenName":order.shenpirenName,
                                 @"shenpirenId":order.shenpirenID,
                                 @"paicherenId":order.paicherenID,
                                 @"driverId":order.driverID,
                                 @"driverName":order.driverName,
                                 @"startMetre":order.startMetre,
                                 @"endMetre":order.endMetre,
                                 @"shenheYiJian":order.shenheYiJian,
                                 @"facheYijian":order.facheYijian,
                                 @"bohuiYuanYin":order.bohuiYuanYin,
                                 @"countMetre":order.countMetre,
                                 @"pingjia":order.pingjia,
                                 };
    [manager POST:[NSString stringWithFormat:@"%@/mobileDingche.html", YLYBaseURL]
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (completion != nil) {
                  if ([responseObject isKindOfClass:[NSDictionary class]]) {
                      YLYUser *user = [YLYUser userWithDictionary:responseObject];
                      completion(YES, user, nil);
                  } else {
                      completion(NO, nil, nil);
                  }
              }
              //NSLog(@"JSON: %@", responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (completion) {
                  completion(NO, nil, nil);
              }
              //NSLog(@"Error: %@", error);
          }];
}

- (void)loadDincheWeiwanchengWithUserID:(NSString *)userID completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"userId":userID,
                                 @"page":[@(_page) stringValue]};
    [manager GET:[NSString stringWithFormat:@"%@/mobileDingCheHisWeiWanCheng.html", YLYBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (completion != nil) {
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     //                     if ([responseObject[@"status"] intValue] == Success) {
                     YLYUser *user = [YLYUser userWithDictionary:responseObject];
                     completion(YES, user, nil);
                     //                     } else {
                     //                         completion(NO, nil, nil);
                     //                     }
                 }
             }
             //NSLog(@"JSON: %@", responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (completion) {
                 completion(NO, nil, nil);
             }
             //NSLog(@"Error: %@", error);
         }];
}

- (void)loadDincheYiwanchengWithUserID:(NSString *)userID completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"userId":userID,
                                 @"page":@(_page)};
    [manager GET:[NSString stringWithFormat:@"%@/mobileDingCheHisYiWanCheng.html", YLYBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (completion != nil) {
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     //                     if ([responseObject[@"status"] intValue] == Success) {
                     YLYUser *user = [YLYUser userWithDictionary:responseObject];
                     completion(YES, user, nil);
                     //                     } else {
                     //                         completion(NO, nil, nil);
                     //                     }
                 }
             }
             //NSLog(@"JSON: %@", responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (completion) {
                 completion(NO, nil, nil);
             }
             //NSLog(@"Error: %@", error);
         }];
}

- (void)loadDriverWithCarID:(NSString *)carID completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"carId":carID};
    [manager GET:[NSString stringWithFormat:@"%@/mobileDriverInfo.html", YLYBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (completion != nil) {
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     //                     if ([responseObject[@"status"] intValue] == Success) {
                     YLYUser *user = [YLYUser userWithDictionary:responseObject];
                     completion(YES, user, nil);
                     //                     } else {
                     //                         completion(NO, nil, nil);
                     //                     }
                 }
             }
             //NSLog(@"JSON: %@", responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (completion) {
                 completion(NO, nil, nil);
             }
             //NSLog(@"Error: %@", error);
         }];
}

- (void)loadHistoryDriverJinxingzhongWithUserID:(NSString *)userID completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"userId":userID,
                                 @"page":@(_page)};
    [manager GET:[NSString stringWithFormat:@"%@/mobileDingCheHisSijiJinxingzhong.html", YLYBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (completion != nil) {
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     //                     if ([responseObject[@"status"] intValue] == Success) {
                     YLYUser *user = [YLYUser userWithDictionary:responseObject];
                     completion(YES, user, nil);
                     //                     } else {
                     //                         completion(NO, nil, nil);
                     //                     }
                 }
             }
             //NSLog(@"JSON: %@", responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (completion) {
                 completion(NO, nil, nil);
             }
             //NSLog(@"Error: %@", error);
         }];
}

- (void)loadHistoryDriverJijieshuWithUserID:(NSString *)userID completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"userId":userID,
                                 @"page":@(_page)};
    [manager GET:[NSString stringWithFormat:@"%@/mobileDingCheHisSijiYiJieShu.html", YLYBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (completion != nil) {
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     //                     if ([responseObject[@"status"] intValue] == Success) {
                     YLYUser *user = [YLYUser userWithDictionary:responseObject];
                     completion(YES, user, nil);
                     //                     } else {
                     //                         completion(NO, nil, nil);
                     //                     }
                 }
             }
             //NSLog(@"JSON: %@", responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (completion) {
                 completion(NO, nil, nil);
             }
             //NSLog(@"Error: %@", error);
         }];
}

- (void)loadMolleageWithUserID:(NSString *)userID completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"userId":userID,
                                 @"page":@(_page)};
    [manager GET:[NSString stringWithFormat:@"%@/mobileHis.html", YLYBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (completion != nil) {
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     //                     if ([responseObject[@"status"] intValue] == Success) {
                     YLYUser *user = [YLYUser userWithDictionary:responseObject];
                     completion(YES, user, nil);
                     //                     } else {
                     //                         completion(NO, nil, nil);
                     //                     }
                 }
             }
             //NSLog(@"JSON: %@", responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (completion) {
                 completion(NO, nil, nil);
             }
             //NSLog(@"Error: %@", error);
         }];
}

@end
