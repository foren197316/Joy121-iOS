//
//  DSHWelForCart.m
//  Joy
//
//  Created by zhangbin on 7/27/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "WelInfoForCart.h"

@implementation WelInfoForCart

- (NSString *)describe
{
	//TODO: hard code
	//第二个参数为空
	//第三个参数表示类型，logo store 和商品都是1，福利是2
	//第四个参数数量限制为1，默认一个用户只能提交一个福利
	return [NSString stringWithFormat:@"[%@][%@][%@][%@]", _wel.wid, @"", @"2", _quanlity];
}

- (NSInteger)totalCredits
{
	return [_wel.score integerValue] * _quanlity.integerValue;
}

@end
