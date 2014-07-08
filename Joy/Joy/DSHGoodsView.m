//
//  DSHGoodsView.m
//  dushuhu
//
//  Created by zhangbin on 3/27/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import "DSHGoodsView.h"

@interface DSHGoodsView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *shopPriceLabel;
@property (nonatomic, strong) UILabel *marketPriceLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *deleteLineView;

@end

@implementation DSHGoodsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		UIEdgeInsets edgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
		CGFloat width = frame.size.width - edgeInsets.left - edgeInsets.right;
		CGFloat height = frame.size.height - edgeInsets.top - edgeInsets.bottom;
		CGRect contentFrame = CGRectMake(edgeInsets.left, edgeInsets.top, width, height);
		
		UIView *contentView = [[UIView alloc] initWithFrame:contentFrame];
		contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
		contentView.layer.borderWidth = 0.5;
		[self addSubview:contentView];
		
		contentFrame.origin.x = 0;
		contentFrame.origin.y = 0;
		contentFrame.size.height = contentFrame.size.width;
		
		_imageView = [[UIImageView alloc] initWithFrame:contentFrame];
		_imageView.clipsToBounds = YES;
		_imageView.contentMode = UIViewContentModeCenter | UIViewContentModeScaleAspectFit;
		[contentView addSubview:_imageView];
		
		UIFont *font = [self _isBigSize] ? [UIFont systemFontOfSize:20] : [UIFont systemFontOfSize:13];
		contentFrame.origin.y = CGRectGetMaxY(_imageView.frame);
		contentFrame.size.width /= 2;
		contentFrame.size.height = font.lineHeight;
		
		_shopPriceLabel = [[UILabel alloc] initWithFrame:contentFrame];
		_shopPriceLabel.textAlignment = NSTextAlignmentCenter;
		_shopPriceLabel.backgroundColor = [UIColor clearColor];
		_shopPriceLabel.textColor = [UIColor themeColor];
		_shopPriceLabel.font = font;
		[contentView addSubview:_shopPriceLabel];
		
		font = [self _isBigSize] ? [UIFont systemFontOfSize:16] : [UIFont systemFontOfSize:11];
		contentFrame.origin.x = CGRectGetMaxX(_shopPriceLabel.frame);
		
		_marketPriceLabel = [[UILabel alloc] initWithFrame:contentFrame];
		_marketPriceLabel.textAlignment = NSTextAlignmentCenter;
		_marketPriceLabel.backgroundColor = [UIColor clearColor];
		_marketPriceLabel.textColor = [UIColor grayColor];
		_marketPriceLabel.font = font;
		[contentView addSubview:_marketPriceLabel];
		
		contentFrame.origin.y = CGRectGetMidY(_marketPriceLabel.frame);
		contentFrame.size.height = 0.5;
		
		_deleteLineView = [[UIView alloc] initWithFrame:contentFrame];
		_deleteLineView.backgroundColor = [UIColor lightGrayColor];
		[contentView addSubview:_deleteLineView];
		
		font = [self _isBigSize] ? [UIFont systemFontOfSize:15] : [UIFont systemFontOfSize:11];
		contentFrame.origin.x = CGRectGetMinX(_imageView.frame);
		contentFrame.origin.y = CGRectGetMaxY(_marketPriceLabel.frame);
		contentFrame.size.width *= 2;
		contentFrame.size.height = contentView.frame.size.height - contentFrame.origin.y;
		
		_nameLabel = [[UILabel alloc] initWithFrame:contentFrame];
		_nameLabel.textAlignment = NSTextAlignmentCenter;
		_nameLabel.backgroundColor = [UIColor clearColor];
		_nameLabel.font = font;
		_nameLabel.numberOfLines = 0;
		[contentView addSubview:_nameLabel];
		
		UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectGoods)];
		[self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

- (void)setGoods:(DSHGoods *)goods
{
	if (_goods == goods) return;
	_goods = goods;
	
	UIImage *placeholder = [UIImage imageNamed:@"GoodsPlaceholder"];
	if ([self _isBigSize]) {
		[_imageView setImageWithURL:[NSURL URLWithString:_goods.imagePath] placeholderImage:placeholder];
	} else {
		[_imageView setImageWithURL:[NSURL URLWithString:_goods.imageThumbPath] placeholderImage:placeholder];
	}
	_shopPriceLabel.text = [_goods creditsPrice];
	if (_shopPriceLabel.text) {
		CGRect frame = _shopPriceLabel.frame;
		frame.size.width = _nameLabel.frame.size.width;
		_shopPriceLabel.frame = frame;
		_deleteLineView.hidden = YES;
	} else {
		_deleteLineView.hidden = NO;
		_shopPriceLabel.text = [_goods shopPrice];
		_marketPriceLabel.text = [_goods marketPrice];
	}
	_nameLabel.text = _goods.name;
}

- (void)didSelectGoods
{
	[_delegate goodsView:self didSelectGoods:_goods];
}

+ (CGSize)size
{
	return CGSizeMake(96, 140);
}

+ (CGSize)bigSize
{
	return CGSizeMake(180, 260);
}

- (BOOL)_isBigSize
{
	return self.bounds.size.width == [[self class] bigSize].width;
}

@end
