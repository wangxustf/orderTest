//
//  OrderViewController.h
//  orderTest
//
//  Created by wangxu on 15/9/12.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

typedef NS_ENUM(NSInteger, OrderState) {
    OrderStateDingche = 0,
    OrderStateShenhetongguo = 1,
    OrderStateShenhebohui = 11,
    OrderStatePaichequeren = 2,
    OrderStatePaichebohui = 22,
    OrderStateSijiqueren = 3,
    OrderStateSijibohui = 33,
    OrderStatePaichefache = 4,
    OrderStateSijikaishi = 5,
    OrderStateSijijieshu = 6,
    OrderStateKehuqueren = 7,
    OrderStatePaichezhongliao = 8
};

@interface OrderViewController : BaseViewController

@property (nonatomic, copy) Order *order;
@property (nonatomic, assign) BOOL finished;
@property (nonatomic, copy) void (^tongguoBlock)();

@end
