//
//  ModelCollectionViewCell.m
//  Joy
//
//  Created by zhangbin on 7/5/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "ModuleCollectionViewCell.h"

@interface ModuleCollectionViewCell ()

@property (readwrite) UILabel *nameLabel;
@property (readwrite) UIImageView *imageView;

@end

@implementation ModuleCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[self class] size].width, 30)];
		_nameLabel.textAlignment = NSTextAlignmentCenter;
		_nameLabel.textColor = [UIColor whiteColor];
		_nameLabel.font = [UIFont boldSystemFontOfSize:13];
		[self addSubview:_nameLabel];
		
		_imageView = [[UIImageView alloc] initWithFrame:self.bounds];
		_imageView.contentMode = UIViewContentModeCenter;
		[self addSubview:_imageView];
    }
    return self;
}

- (void)setModule:(Module *)module
{
	_module = module;
	if (_module.name) {
		_nameLabel.text = _module.name;
	}
}

- (void)setIcon:(UIImage *)icon
{
	_imageView.image = icon;
}

+ (CGSize)size
{
	return CGSizeMake(90, 110);
}

@end
