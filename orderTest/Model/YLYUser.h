//
//  YLYUser.h
//  orderTest
//
//  Created by wangxu on 15/9/12.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UserType) {
    UserTypeDingche = 2,
    UserTypeShenhe,
    UserTypePaiche,
    UserTypeDriver
};

@interface YLYUser : NSObject <NSCoding>

@property (nonatomic, strong) NSString *deviceID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *depName;
@property (nonatomic, strong) NSString *depID;
@property (nonatomic, assign) UserType userType;
@property (nonatomic, strong) NSString *userTypeName;

+ (YLYUser *)userWithDictionary:(NSDictionary *)dictionary;

@end
