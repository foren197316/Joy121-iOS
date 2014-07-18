//
//  GoodsPropertyView.m
//  Joy
//
//  Created by zhangbin on 7/18/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "GoodsPropertyView.h"
#import "UIColor+Random.h"

@interface GoodsPropertyView ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation GoodsPropertyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		_button = [UIButton buttonWithType:UIButtonTypeCustom];
		CGSize size = [[self class] size];
		_button.frame = CGRectMake(5, 5, size.width - 2 * 5, size.height - 2 * 5);
		[_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
		_button.layer.borderWidth = 1;
		_button.layer.borderColor = [[UIColor grayColor] CGColor];
		_button.layer.cornerRadius = 2;
		[_button addTarget:self action:@selector(tapped) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:_button];
    }
    return self;
}

+ (CGSize)size
{
	return CGSizeMake(60, 40);
}

- (void)setProperty:(GoodsProperty *)property
{
	_property = property;
	if (_property) {
		[_button setTitle:property.value forState:UIControlStateNormal];
	}
}

- (void)setSelected:(BOOL)selected
{
	_selected = selected;
	_button.backgroundColor = _selected ? [UIColor grayColor] : [UIColor clearColor];
	[_delegate goodsPropertyView:self selected:_button.selected];
}

- (void)tapped
{
	_button.selected = !_button.selected;
	[self setSelected:_button.selected];
}

@end
