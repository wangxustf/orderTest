//
//  NSUserDefaults+Addition.m
//  E6Business
//
//  Created by wangxu on 15/9/1.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "NSUserDefaults+Addition.h"

static NSString *kYLYUser = @"kYLYUser";
static NSString *kYLYCarTreeArray = @"kYLYCarTreeArray";
static NSString *kYLYVersion = @"kYLYVersion";

@implementation NSUserDefaults (Addition)

+ (void)saveUser:(YLYUser *)user
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kYLYUser];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (YLYUser *)user
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kYLYUser];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (void)saveCarTreeArray:(NSArray *)carTreeArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:carTreeArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kYLYCarTreeArray];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray *)carTreeArray
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kYLYCarTreeArray];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (void)saveVersion:(NSString *)version
{
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:kYLYVersion];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)version
{
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:kYLYVersion];
    if (!version) {
        [self saveVersion:@"1"];
        return @"1";
    }
    return version;
}

@end
