//
//  Service.h
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLYUser.h"

@interface Service : NSObject

- (void)loginWithAccount:(NSString *)account password:(NSString *)password completion:(void(^)(BOOL success, YLYUser *user, NSString *msg))completion;

@end
