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
		_iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, [[self class] size].width, [[self class] size].height-30)];
		_iconView.contentMode = UIViewContentModeCenter;
		[self.contentView addSubview:_iconView];
        
        //self.frame = rect;
        self.layer.cornerRadius = 2;
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;

		
		_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, [[self class] size].height-30, [[self class] size].width, 25)];
		_nameLabel.textAlignment = NSTextAlignmentCenter;
		_nameLabel.textColor = [UIColor whiteColor];
		_nameLabel.font = [UIFont boldSystemFontOfSize:11];
		_nameLabel.backgroundColor = [UIColor clearColor];
        //_nameLabel.backgroundColor = [UIColor hexRGB:0x00ff00];//设置背景颜色
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
	return CGSizeMake(85, 85);
}

@end
