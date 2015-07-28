//
//  PerformanceTableViewCell.m
//  Joy
//
//  Created by zhangbin on 2/17/15.
//  Copyright (c) 2015 颜超. All rights reserved.
//

#import "PerformanceTableViewCell.h"

@interface PerformanceTableViewCell ()

@property (readwrite) UIView *bannerView;
@property (readwrite) UIView *coloredFlagView;
@property (readwrite) UILabel *nameLabel;
@property (readwrite) UILabel *valueLabel;
@property (readwrite) UILabel *describeLabel;

@end

@implementation PerformanceTableViewCell

+ (CGFloat)height {
	return 60;
}

+ (CGFloat)biggerHeight {
	return 90;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.backgroundColor = [UIColor clearColor];
		_bannerView = [[UIView alloc] init];
		_coloredFlagView = [[UIView alloc] init];
		_nameLabel = [[UILabel alloc] init];
		_valueLabel = [[UILabel alloc] init];
		_describeLabel = [[UILabel alloc] init];
		self.accessoryType = UITableViewCellAccessoryNone;
		self.isEncourage = NO;
	}
	return self;
}

- (void)setIsEncourage:(BOOL)isEncourage {
	_isEncourage = isEncourage;
	CGFloat fullWidth = [UIScreen mainScreen].bounds.size.width;
	UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
	CGRect rect = CGRectZero;
	rect.origin.x = edgeInsets.left;
	rect.origin.y = edgeInsets.top;
	rect.size.width = fullWidth - edgeInsets.left - edgeInsets.right;
	rect.size.height = _isEncourage ? [[self class] biggerHeight] : [[self class] height];
	
	_bannerView.frame = rect;
	_bannerView.layer.cornerRadius = 6;
	_bannerView.backgroundColor = [UIColor whiteColor];
	_bannerView.clipsToBounds = YES;
	[self.contentView addSubview:_bannerView];
	
	rect.origin.x = 0;
	rect.size.width = 6;
	_coloredFlagView.frame = rect;
	[_bannerView addSubview:_coloredFlagView];
	
	if (_isEncourage) {
		//self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		rect.origin.x = CGRectGetMaxX(_coloredFlagView.frame) + 5;
		rect.size.width = CGRectGetWidth(_bannerView.frame) - rect.origin.x;
		rect.size.height = 20;
		_nameLabel.frame = rect;
		_nameLabel.font = [UIFont boldSystemFontOfSize:13];
		[_bannerView addSubview:_nameLabel];
		
		rect.origin.y = CGRectGetMaxY(_nameLabel.frame);
		rect.size.height = 40;
		_valueLabel.frame = rect;
		_valueLabel.font = [UIFont systemFontOfSize:13];
		_valueLabel.textColor = [UIColor lightGrayColor];
		_valueLabel.textAlignment = NSTextAlignmentCenter;
		[_bannerView addSubview:_valueLabel];
		
		rect.origin.x = CGRectGetMinX(_nameLabel.frame) + 10;
		rect.origin.y = CGRectGetMaxY(_valueLabel.frame) - 10;
		_describeLabel.frame = rect;
		_describeLabel.font = [UIFont systemFontOfSize:12];
		_describeLabel.textColor = [UIColor lightGrayColor];
		[_bannerView addSubview:_describeLabel];
		
	} else {
		rect.origin.x = CGRectGetMaxX(_coloredFlagView.frame) + 5;
		rect.size.width = CGRectGetWidth(_bannerView.frame) - rect.origin.x;
		rect.size.height = 20;
		_nameLabel.frame = rect;
		_nameLabel.font = [UIFont boldSystemFontOfSize:13];
		[_bannerView addSubview:_nameLabel];
		
		rect.origin.y = CGRectGetMaxY(_nameLabel.frame);
		rect.size.height = 40;
		_valueLabel.frame = rect;
		_valueLabel.font = [UIFont systemFontOfSize:13];
		_valueLabel.textColor = [UIColor lightGrayColor];
		_valueLabel.textAlignment = NSTextAlignmentCenter;
		[_bannerView addSubview:_valueLabel];
	}
	
}

- (void)setPerformance:(Performance *)performance {
	_performance = performance;
	if (_performance) {
		_coloredFlagView.backgroundColor = [_performance flagColor];
		_nameLabel.text = _performance.name;
		if (_isEncourage) {
			NSString *text = @"奖励 ";
			NSString *value = [NSString stringWithFormat:@"%@", _performance.points];
			NSString *string = [NSString stringWithFormat:@"%@%@ 积分", text, value];
			NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
			[attributedString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20], NSForegroundColorAttributeName : [UIColor redColor]} range:NSMakeRange(text.length, value.length)];
			_valueLabel.attributedText = attributedString;
			
			NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
			[numberFormatter setPositiveFormat:@"0"];
			NSString *points = [NSString stringWithFormat:@"%@", _performance.score];
			NSString *ranking = [NSString stringWithFormat:@"%@", _performance.ranking];
			NSNumber *top = @(_performance.ranking.floatValue / _performance.total.floatValue * 100);
			NSString *topString = [NSString stringWithFormat:@"%@%%", [numberFormatter stringFromNumber:top]];
			NSString *describe = [NSString stringWithFormat:@"你的得分%@，排名第%@", points, ranking];
			NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:describe];
			NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:13], NSForegroundColorAttributeName : [UIColor blackColor]};
			NSArray *array = @[points, ranking, topString];
			for (NSString *s in array) {
				NSRange range = [describe rangeOfString:s];
				[attributedString2 addAttributes:attributes range:range];
			}
			_describeLabel.attributedText = attributedString2;

		} else {
			NSString *text = @"得分";
			//NSString *value = [NSString stringWithFormat:@"%.2f", _performance.score.doubleValue];
            NSString *value = [NSString stringWithFormat:@"%.2f", _performance.score.doubleValue];
			NSString *string = [NSString stringWithFormat:@"%@%@", text, value];
			NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
			[attributedString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20], NSForegroundColorAttributeName : [UIColor redColor]} range:NSMakeRange(text.length, value.length)];
			_valueLabel.attributedText = attributedString;
		}
	}
}

- (void)prepareForReuse {
	[super prepareForReuse];
	_coloredFlagView.backgroundColor = [UIColor whiteColor];
	_nameLabel.text = nil;
	_valueLabel.text = nil;
	_valueLabel.attributedText = nil;
}

@end
