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
        _page = 0;
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
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
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

- (void)loadCarListWithDriverID:(NSString *)driverID carType:(NSString *)carType completion:(void(^)(BOOL success, NSArray *carsArray, NSString *msg))completion
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
                  if ([responseObject isKindOfClass:[NSArray class]]) {
                      NSMutableArray *carsArray = [NSMutableArray array];
                      for (NSDictionary *dictionary in responseObject) {
                          [carsArray addObject:[Car carWithDictionary:dictionary]];
                      }
                      completion(YES, carsArray, nil);
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

- (void)DingCheWithOrder:(Order *)order completion:(void(^)(BOOL success, NSString *msg))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (order.orderID.length > 0) {
        [parameters setObject:order.orderID forKey:@"orderId"];
    }
    if (order.jiecheAddress.length > 0) {
        [parameters setObject:order.jiecheAddress forKey:@"jiecheAddress"];
    }
    if (order.jingguoAddress.length > 0) {
        [parameters setObject:order.jingguoAddress forKey:@"jingguoAddress"];
    }
    if (order.realJingguoAddress.length > 0) {
        [parameters setObject:order.realJingguoAddress forKey:@"realJingguoAddress"];
    }
    if (order.yuyueTime.length > 0) {
        [parameters setObject:order.yuyueTime forKey:@"yuyueTime"];
    }
    if (order.endTime.length > 0) {
        [parameters setObject:order.endTime forKey:@"endTime"];
    }
    if (order.realStartTime.length > 0) {
        [parameters setObject:order.realStartTime forKey:@"realStartTime"];
    }
    if (order.realEndTime.length > 0) {
        [parameters setObject:order.realEndTime forKey:@"realEndTime"];
    }
    if (order.isPublic.length > 0) {
        [parameters setObject:order.isPublic forKey:@"isPublic"];
    }
    if (order.carType.length > 0) {
        [parameters setObject:order.carType forKey:@"carType"];
    }
    if (order.userName.length > 0) {
        [parameters setObject:order.userName forKey:@"userName"];
    }
    if (order.userPhone.length > 0) {
        [parameters setObject:order.userPhone forKey:@"userPhone"];
    }
    if (order.carID.length > 0) {
        [parameters setObject:order.carID forKey:@"carId"];
    }
    if (order.dingcherenID.length > 0) {
        [parameters setObject:order.dingcherenID forKey:@"dingcherenId"];
    }
    if (order.dingcherenName.length > 0) {
        [parameters setObject:order.dingcherenName forKey:@"dingcherenName"];
    }
    if (order.dingcherenPhone.length > 0) {
        [parameters setObject:order.dingcherenPhone forKey:@"dingcherenPhone"];
    }
    if (order.dingcherenDep.length > 0) {
        [parameters setObject:order.dingcherenDep forKey:@"dingcherenDep"];
    }
    if (order.dingcherenDepID.length > 0) {
        [parameters setObject:order.dingcherenDepID forKey:@"dingcherenDepId"];
    }
    if (order.orderState.length > 0) {
        [parameters setObject:order.orderState forKey:@"orderState"];
    }
    if (order.shenpirenName.length > 0) {
        [parameters setObject:order.shenpirenName forKey:@"shenpirenName"];
    }
    if (order.shenpirenID.length > 0) {
        [parameters setObject:order.shenpirenID forKey:@"shenpirenId"];
    }
    if (order.paicherenID.length > 0) {
        [parameters setObject:order.paicherenID forKey:@"paicherenId"];
    }
    if (order.driverID.length > 0) {
        [parameters setObject:order.driverID forKey:@"driverId"];
    }
    if (order.driverName.length > 0) {
        [parameters setObject:order.driverName forKey:@"driverName"];
    }
    if (order.driverPhone.length > 0) {
        [parameters setObject:order.driverPhone forKey:@"driverPhone"];
    }
    if (order.startMetre.length > 0) {
        [parameters setObject:order.startMetre forKey:@"startMetre"];
    }
    if (order.endMetre.length > 0) {
        [parameters setObject:order.endMetre forKey:@"endMetre"];
    }
    if (order.shenheYiJian.length > 0) {
        [parameters setObject:order.shenheYiJian forKey:@"shenheYiJian"];
    }
    if (order.facheYijian.length > 0) {
        [parameters setObject:order.facheYijian forKey:@"facheYijian"];
    }
    if (order.bohuiYuanYin.length > 0) {
        [parameters setObject:order.bohuiYuanYin forKey:@"bohuiYuanYin"];
    }
    if (order.countMetre.length > 0) {
        [parameters setObject:order.countMetre forKey:@"countMetre"];
    }
    if (order.pingjia.length > 0) {
        [parameters setObject:order.pingjia forKey:@"pingjia"];
    }
    if (order.yongcheyijian.length > 0) {
        [parameters setObject:order.yongcheyijian forKey:@"yongcheyijian"];
    }
    if (order.gonglidanjia.length > 0) {
        [parameters setObject:order.gonglidanjia forKey:@"gonglidanjia"];
    }
    if (order.guoqiaofei.length > 0) {
        [parameters setObject:order.guoqiaofei forKey:@"guoqiaofei"];
    }
    if (order.tingcheguolufei.length > 0) {
        [parameters setObject:order.tingcheguolufei forKey:@"tingcheguolufei"];
    }
    [manager POST:[NSString stringWithFormat:@"%@/mobileDingche.html", YLYBaseURL]
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (completion != nil) {
                  if ([responseObject isKindOfClass:[NSDictionary class]]) {
                      completion(([responseObject[@"result"] integerValue] == 0), nil);
                  } else {
                      completion(NO, nil);
                  }
              }
              //NSLog(@"JSON: %@", responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (completion) {
                  completion(NO, nil);
              }
              //NSLog(@"Error: %@", error);
          }];
}

- (void)loadOrderListWithUserID:(NSString *)userID isFinish:(BOOL)isFinish isDriver:(BOOL)isDriver completion:(void(^)(BOOL success, NSArray *ordersArray, NSString *msg))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"userId":userID,
                                 @"page":[@(_page) stringValue]};
    NSString *subURL = nil;
    if (!isDriver) {
        subURL = isFinish ? @"mobileDingCheHisYiWanCheng.html" : @"mobileDingCheHisWeiWanCheng.html";
    } else {
        subURL = isFinish ? @"mobileDingCheHisSijiYiJieShu.html" : @"mobileDingCheHisSijiJinxingzhong.html";
    }
    [manager POST:[NSString stringWithFormat:@"%@/%@", YLYBaseURL, subURL]
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (completion != nil) {
                  if ([responseObject isKindOfClass:[NSArray class]]) {
                      NSMutableArray *ordersArray = [NSMutableArray array];
                      for (NSDictionary *dictionary in responseObject) {
                          [ordersArray addObject:[Order orderWithDictionary:dictionary]];
                      }
                      if ([ordersArray count] > 0) {
                          _page++;
                      }
                      completion(YES, ordersArray, nil);
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

- (void)loadDriverListWithCarID:(NSString *)carID completion:(void(^)(BOOL success, NSArray *driversArray, NSString *msg))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"carId":carID};
    [manager GET:[NSString stringWithFormat:@"%@/mobileDriverInfo.html", YLYBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (completion != nil) {
                 if ([responseObject isKindOfClass:[NSArray class]]) {
                     NSMutableArray *driversArray = [NSMutableArray array];
                     for (NSDictionary *dictionary in responseObject) {
                         [driversArray addObject:[Driver driverWithDictionary:dictionary]];
                     }
                     completion(YES, driversArray, nil);
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

- (void)loadMolleageListWithUserID:(NSString *)userID completion:(void(^)(BOOL success, NSArray *ordersArray, NSString *msg))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"userId":userID,
                                 @"page":[@(_page) stringValue]};
    [manager POST:[NSString stringWithFormat:@"%@/mobileHis.html", YLYBaseURL]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (completion != nil) {
                 if ([responseObject isKindOfClass:[NSArray class]]) {
                     NSMutableArray *ordersArray = [NSMutableArray array];
                     for (NSDictionary *dictionary in responseObject) {
                         [ordersArray addObject:[Order orderWithDictionary:dictionary]];
                     }
                     if (ordersArray.count > 0) {
                         _page++;
                     }
                     completion(YES, ordersArray, nil);
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

@end
