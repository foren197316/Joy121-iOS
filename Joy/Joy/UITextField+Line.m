//
//  UITextField+Line.m
//  Joy
//
//  Created by gejw on 15/9/9.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import "UITextField+Line.h"

@implementation UITextField (Line)

- (void)loadLine {
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = [UIColor colorWithRed:0.84 green:0.91 blue:0.96 alpha:1].CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, self.height - 0.5, self.width, 0.5)].CGPath;
    border.lineWidth = .5f;
    border.lineCap = @"square";
    border.lineDashPattern = @[@6, @6];
    [self.layer addSublayer:border];
}

@end
