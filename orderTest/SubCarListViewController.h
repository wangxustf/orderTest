//
//  SubCarListViewController.h
//  orderTest
//
//  Created by wangxu on 15/9/27.
//  Copyright © 2015年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"

typedef NS_ENUM(NSInteger, CarType) {
    CarTypeZero,
    CarTypeJingji,
    CarTypeShushi,
    CarTypeHaohua,
    CarTypeShangwu,
    CarType16zuo,
    CarType32zuo
};

@interface SubCarListViewController : UITableViewController

@property (nonatomic, assign) CarType carType;
@property (nonatomic, copy) void(^selectBlock)(Car *car);
@property (nonatomic, strong) NSArray *carList;

- (id)initWithCarType:(CarType)carType;

@end
