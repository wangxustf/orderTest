//
//  DriverTableViewCell.h
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Car.h"

@interface CarTableViewCell : UITableViewCell

@property (nonatomic, strong) Car *car;
@property (nonatomic, assign) NSInteger carType;

@end
