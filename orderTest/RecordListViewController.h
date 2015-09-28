//
//  DriverListViewController.h
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FinishType) {
    FinishTypeUnfinished,
    FinishTypeFinished
};

@interface RecordListViewController : BaseViewController

@property (nonatomic, assign) FinishType finishType;

- (id)initWithFinishType:(FinishType)finishType;

@end
