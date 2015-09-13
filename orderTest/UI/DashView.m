//
//  DashView.m
//  orderTest
//
//  Created by wangxu on 15/9/13.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "DashView.h"

@implementation DashView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (DashView *)dashViewWithRect:(CGRect)rect
{
    DashView *dView = [[DashView alloc] initWithFrame:rect];
    dView.backgroundColor = [UIColor whiteColor];
    return dView;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat lengths[] = {10, 5};
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, RGB(kLineColor).CGColor);
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextMoveToPoint(context, 0.0, self.height);
    CGContextAddLineToPoint(context, self.width, self.height);
    CGContextStrokePath(context);
}

@end
