//
//  DriverListViewController.h
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Car.h"

@interface CarListViewController : BaseViewController

@property (nonatomic, copy) void(^selectBlock)(Car *car);

@end
