//
//  DSHGoodsQuantityView.m
//  Joy
//
//  Created by zhangbin on 8/28/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "DSHGoodsQuantityView.h"

@interface DSHGoodsQuantityView ()

@property (readwrite) UILabel *quantityLabel;

@end

@implementation DSHGoodsQuantityView

+ (CGSize)size
{
	return CGSizeMake(120, 35);
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		CGRect frame = CGRectMake(0, 0, 35, 35);
		UIButton *minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[minusButton setImage:[UIImage imageNamed:@"Minus"] forState:UIControlStateNormal];
		minusButton.frame = frame;
		[minusButton addTarget:self action:@selector(decrease) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:minusButton];
		
		frame.origin.x = CGRectGetMaxX(minusButton.frame) + 5;
		_quantityLabel = [[UILabel alloc] initWithFrame:frame];
		_quantityLabel.text = @"1";
		_quantityLabel.layer.borderColor = [[UIColor grayColor] CGColor];
		_quantityLabel.layer.borderWidth = 2;
		_quantityLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:_quantityLabel];
		
		frame.origin.x = CGRectGetMaxX(_quantityLabel.frame) + 5;
		UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[plusButton setImage:[UIImage imageNamed:@"Plus"] forState:UIControlStateNormal];
		plusButton.frame = frame;
		[plusButton addTarget:self action:@selector(increase) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:plusButton];
		
		_quantity = 1;
	}
	return self;
}

- (void)increase
{
	_quantity++;
	_quantityLabel.text = [NSString stringWithFormat:@"%ld", _quantity];
}

- (void)decrease
{
	_quantity--;
	if (_quantity <= 0) {
		_quantity = 1;
	}
	_quantityLabel.text = [NSString stringWithFormat:@"%ld", _quantity];
}

@end
