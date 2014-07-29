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

@end

@implementation ModuleCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		_iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[self class] size].width, [[self class] size].height)];
		_iconView.contentMode = UIViewContentModeCenter;
		[self.contentView addSubview:_iconView];
		
		_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[self class] size].width, 30)];
		_nameLabel.textAlignment = NSTextAlignmentCenter;
		_nameLabel.textColor = [UIColor whiteColor];
		_nameLabel.font = [UIFont boldSystemFontOfSize:13];
		_nameLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:_nameLabel];
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
	_iconView.image = icon;
}

+ (CGSize)size
{
	return CGSizeMake(90, 110);
}

@end
