//
//  DSHGoodsTableViewCell.m
//  dushuhu
//
//  Created by zhangbin on 3/6/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import "DSHGoodsTableViewCell.h"
#import "GoodsProperty.h"

@interface DSHGoodsTableViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *shopPriceLabel;
@property (nonatomic, strong) UILabel *marketPriceLabel;
@property (nonatomic, strong) UIView *deleteLineView;
@property (nonatomic, strong) UILabel *boughtCountLabel;
@property (nonatomic, strong) UIButton *addToCartButton;
@property (nonatomic, strong) UILabel *quanlityAndTotalPriceLabel;
@property (nonatomic, strong) UIButton *increaseButton;
@property (nonatomic, strong) UIButton *decreaseButton;
@property (nonatomic, strong) UILabel *propertiesLabel;

@end

@implementation DSHGoodsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		self.imageView.layer.cornerRadius = 6;
		self.imageView.clipsToBounds = YES;
		
		CGFloat leftIndentationWithImageView = self.indentationWidth * 2 + [[self class] height];
		UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, leftIndentationWithImageView, 0, 40);
		CGFloat width = self.bounds.size.width - edgeInsets.left - edgeInsets.right;
		CGFloat height = [[self class] height] - edgeInsets.top - edgeInsets.bottom;
		CGRect contentFrame = CGRectMake(edgeInsets.left, edgeInsets.top, width, height);
		
		contentFrame.size.height = contentFrame.size.height / 3 * 2;
		
		_nameLabel = [[UILabel alloc] initWithFrame:contentFrame];
		_nameLabel.font = [UIFont systemFontOfSize:13];
		_nameLabel.numberOfLines = 0;
		_nameLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:_nameLabel];
		
		contentFrame.origin.y = CGRectGetMaxY(_nameLabel.frame);
		contentFrame.size.width = 100;
		contentFrame.size.height = height - contentFrame.size.height;
		
		_shopPriceLabel = [[UILabel alloc] initWithFrame:contentFrame];
		_shopPriceLabel.textColor = [UIColor themeColor];
		_shopPriceLabel.font = [UIFont systemFontOfSize:15];
		_shopPriceLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:_shopPriceLabel];
		
		contentFrame.origin.x = CGRectGetMidX(_shopPriceLabel.frame);
		contentFrame.size.width = 50;
		
		_marketPriceLabel = [[UILabel alloc] initWithFrame:contentFrame];
		_marketPriceLabel.textColor = [UIColor grayColor];
		_marketPriceLabel.font = [UIFont systemFontOfSize:13];
		_marketPriceLabel.backgroundColor = [UIColor clearColor];
		//[self.contentView addSubview:_marketPriceLabel];
		
		_propertiesLabel = [[UILabel alloc] initWithFrame:contentFrame];
		_propertiesLabel.textColor = [UIColor blackColor];
		_propertiesLabel.font = [UIFont systemFontOfSize:13];
		_propertiesLabel.backgroundColor = [UIColor clearColor];
		_propertiesLabel.hidden = YES;
		[self.contentView addSubview:_propertiesLabel];
		
		contentFrame.size.width = 120;
		
		_quanlityAndTotalPriceLabel = [[UILabel alloc] initWithFrame:_shopPriceLabel.frame];
		_quanlityAndTotalPriceLabel.font = _shopPriceLabel.font;
		_quanlityAndTotalPriceLabel.hidden = YES;
		_quanlityAndTotalPriceLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:_quanlityAndTotalPriceLabel];
		
		contentFrame.origin.y = CGRectGetMidY(_marketPriceLabel.frame);
		contentFrame.size.width = CGRectGetWidth(_marketPriceLabel.frame);
		contentFrame.size.height = 0.5;
		
		_deleteLineView = [[UIView alloc] initWithFrame:contentFrame];
		_deleteLineView.backgroundColor = [UIColor grayColor];
		//[self.contentView addSubview:_deleteLineView];
		
		contentFrame.origin.x = CGRectGetMaxX(_nameLabel.frame) - 60;
		contentFrame.origin.y = CGRectGetMinY(_marketPriceLabel.frame);
		contentFrame.size.width = 60;
		contentFrame.size.height = CGRectGetHeight(_marketPriceLabel.frame);
		
		_boughtCountLabel = [[UILabel alloc] initWithFrame:contentFrame];
		_boughtCountLabel.font = [UIFont systemFontOfSize:9];
		_boughtCountLabel.textColor = [UIColor grayColor];
		_boughtCountLabel.textAlignment = NSTextAlignmentRight;
		_boughtCountLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:_boughtCountLabel];
		
		contentFrame.origin.x = self.bounds.size.width - 50;
		contentFrame.origin.y = height / 4;
		contentFrame.size.width = 50;
		contentFrame.size.height = 50;
		
		_addToCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
		_addToCartButton.frame = contentFrame;
		[_addToCartButton setImage:[UIImage imageNamed:@"mall_icon"] forState:UIControlStateNormal];
		[_addToCartButton setImage:[UIImage imageNamed:@"mall_icon_press"] forState:UIControlStateHighlighted];
		[_addToCartButton addTarget:self action:@selector(addToCart) forControlEvents:UIControlEventTouchUpInside];
		//[self.contentView addSubview:_addToCartButton];
		
		contentFrame.origin.x = self.bounds.size.width - 60 - edgeInsets.right;
		contentFrame.origin.y = height - 35;
		contentFrame.size.width = 40;
		contentFrame.size.height = 40;
		
		_decreaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
		_decreaseButton.frame = contentFrame;
		[_decreaseButton setImage:[UIImage imageNamed:@"Minus"] forState:UIControlStateNormal];
		_decreaseButton.titleLabel.font = _increaseButton.titleLabel.font;
		[_decreaseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		_decreaseButton.showsTouchWhenHighlighted = YES;
		_decreaseButton.hidden = YES;
		[_decreaseButton addTarget:self action:@selector(decrease) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:_decreaseButton];
		
		contentFrame.origin.x = CGRectGetMaxX(_decreaseButton.frame);
		
		_increaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
		_increaseButton.frame = contentFrame;
		[_increaseButton setImage:[UIImage imageNamed:@"Plus"] forState:UIControlStateNormal];
		_increaseButton.titleLabel.font = [UIFont systemFontOfSize:20];
		[_increaseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		_increaseButton.showsTouchWhenHighlighted = YES;
		_increaseButton.hidden = YES;
		[_increaseButton addTarget:self action:@selector(increase) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:_increaseButton];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setGoods:(DSHGoods *)goods
{
	_goods = goods;
	if (_goods.imageThumbPath) {
		[self.imageView setImageWithURL:[NSURL URLWithString:_goods.imageThumbPath] placeholderImage:[UIImage imageNamed:@"GoodsPlaceholder"]];
	}
	_nameLabel.text = _goods.name;
	_shopPriceLabel.text = [_goods creditsPrice];
	if (_shopPriceLabel.text) {
		_deleteLineView.hidden = YES;
		_shopPriceLabel.font = [UIFont systemFontOfSize:10];
	} else {
		_shopPriceLabel.text = [_goods shopPrice];
		_marketPriceLabel.text = [_goods marketPrice];
		_deleteLineView.hidden = NO;
		_shopPriceLabel.font = [UIFont systemFontOfSize:15];
	}
	
	_boughtCountLabel.text = _goods.boughtCount;
	if (!_boughtCountLabel.text) {
		_boughtCountLabel.hidden = YES;
	}
	_shopPriceLabel.hidden = YES;
}

- (void)setWel:(WelInfo *)wel
{
	_wel = wel;
	if (_wel.headPic) {
		[self.imageView setImageWithURL:[NSURL URLWithString:_wel.headPic] placeholderImage:[UIImage imageNamed:@"GoodsPlaceholder"]];
	}
	_nameLabel.text = _wel.welName;
	_shopPriceLabel.hidden = YES;
	_marketPriceLabel.hidden = YES;
	_deleteLineView.hidden = YES;
	_boughtCountLabel.hidden = YES;
}

- (void)setGoodsForCart:(DSHGoodsForCart *)goodsForCart
{
	_goodsForCart = goodsForCart;
	_propertiesLabel.text = [_goodsForCart propertyValues];
}

- (void)setIsCartSytle:(BOOL)isCartSytle
{
	_isCartSytle = isCartSytle;
	_deleteLineView.hidden = _isCartSytle;
	_marketPriceLabel.hidden = _isCartSytle;
	_boughtCountLabel.hidden = _isCartSytle;
	_addToCartButton.hidden = _isCartSytle;
	_deleteLineView.hidden = _isCartSytle;
	_propertiesLabel.hidden = !_isCartSytle;
}

- (void)setQuanlity:(NSNumber *)quanlity
{
	_quanlity = quanlity;
	if (_quanlity) {
		NSInteger iQuanlity = _quanlity.integerValue;
		_quanlityAndTotalPriceLabel.text = [NSString stringWithFormat:@"%ld", (long)iQuanlity];
//		_quanlityAndTotalPriceLabel.text = [NSString stringWithFormat:@" x %ld = ￥%.1f", (long)iQuanlity, [_goods price].floatValue * iQuanlity];
		_quanlityAndTotalPriceLabel.hidden = NO;
		_increaseButton.hidden = NO;
		_decreaseButton.hidden = NO;
	}
}

- (void)addToCart
{
	[_delegate willAddToCart:_goods];
}

- (void)increase
{
	if (_wel) {
		[_delegate willIncreaseWel:_wel];
		return;
	}
	[_delegate willIncreaseGoods:_goods];
}

- (void)decrease
{
	if (_wel) {
		[_delegate willDecreaseWel:_wel];
		return;
	}
	[_delegate willDecreaseGoods:_goods];
}

- (void)prepareForReuse
{
	[super prepareForReuse];
	self.imageView.image = nil;
	_nameLabel.text = nil;
	_shopPriceLabel.text = nil;
	_marketPriceLabel.text = nil;
	_boughtCountLabel.text = nil;
	_propertiesLabel.text = nil;
	_wel = nil;
	_goods = nil;
}

+ (CGFloat)height
{
	return 60;
}

@end
