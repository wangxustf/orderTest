//
//  Service.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "Service.h"
#import "AFHTTPRequestOperationManager.h"

@implementation Service

- (void)loginWithAccount:(NSString *)account password:(NSString *)password completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"account":account,
                                                                                      @"password":password}];
    [manager GET:[NSString stringWithFormat:@"%@session/recommendSession", @"www"]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (completion != nil) {
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     if ([responseObject[@"status"] intValue] == Success) {
                         completion(YES, nil, nil);
                     } else {
                         completion(NO, nil, nil);
                     }
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
