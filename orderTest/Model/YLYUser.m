//
//  YLYUser.m
//  orderTest
//
//  Created by wangxu on 15/9/12.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "YLYUser.h"
#import "NSDictionary+NSDictionary_Addition.h"

@implementation YLYUser

+ (YLYUser *)userWithDictionary:(NSDictionary *)dictionary
{
    YLYUser *user = [[YLYUser alloc] init];
    user.deviceID   = [dictionary strValue:@"deviceId"];
    user.userID     = [dictionary strValue:@"userId"];
    user.username   = [dictionary strValue:@"username"];
    user.phone      = [dictionary strValue:@"phone"];
    user.depName    = [dictionary strValue:@"depName"];
    user.depID      = [dictionary strValue:@"depId"];
    user.userType   = [dictionary intValue:@"roleId"];
    user.userTypeName = @[@"订车用户", @"审核用户", @"派车用户", @"司机用户"][user.userType - UserTypeDingche];
    return user;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.deviceID forKey:@"deviceID"];
    [coder encodeObject:self.userID   forKey:@"userID"];
    [coder encodeObject:self.username forKey:@"username"];
    [coder encodeObject:self.phone    forKey:@"phone"];
    [coder encodeObject:self.depName  forKey:@"depName"];
    [coder encodeObject:self.depID    forKey:@"depID"];
    [coder encodeInteger:self.userType forKey:@"userType"];
    [coder encodeObject:self.userTypeName forKey:@"userTypeName"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        self.deviceID   = [coder decodeObjectForKey:@"deviceID"];
        self.userID     = [coder decodeObjectForKey:@"userID"];
        self.username   = [coder decodeObjectForKey:@"username"];
        self.phone      = [coder decodeObjectForKey:@"phone"];
        self.depName    = [coder decodeObjectForKey:@"depName"];
        self.depID      = [coder decodeObjectForKey:@"depID"];
        self.userType   = [coder decodeIntegerForKey:@"userType"];
        self.userTypeName   = [coder decodeObjectForKey:@"userTypeName"];
    }
    return self;
}

@end
