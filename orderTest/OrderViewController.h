//
//  OrderViewController.h
//  orderTest
//
//  Created by wangxu on 15/9/12.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface OrderViewController : BaseViewController

@property (nonatomic, strong) Order *order;
@property (nonatomic, assign) BOOL finished;
@property (nonatomic, copy) void (^tongguoBlock)();

@end
