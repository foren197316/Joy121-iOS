//
//  PerformanceTableViewCell.m
//  Joy
//
//  Created by zhangbin on 2/17/15.
//  Copyright (c) 2015 颜超. All rights reserved.
//

#import "PerformanceTableViewCell.h"

@interface PerformanceTableViewCell ()

@property (nonatomic, strong) UIView *coloredFlagView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *scoreLabel;

@end

@implementation PerformanceTableViewCell

+ (CGFloat)height {
	return 60;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
		
		CGFloat fullWidth = [UIScreen mainScreen].bounds.size.width;
		UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
		CGRect rect = CGRectZero;
		rect.origin.x = edgeInsets.left;
		rect.origin.y = edgeInsets.top;
		rect.size.width = fullWidth - edgeInsets.left - edgeInsets.right;
		rect.size.height = [[self class] height];
		
		UIView *backgroundView = [[UIView alloc] initWithFrame:rect];
		backgroundView.layer.cornerRadius = 6;
		backgroundView.backgroundColor = [UIColor whiteColor];
		backgroundView.clipsToBounds = YES;
		[self.contentView addSubview:backgroundView];
		
		rect.origin.x = 0;
		rect.size.width = 6;
		_coloredFlagView = [[UIView alloc] initWithFrame:rect];
		[backgroundView addSubview:_coloredFlagView];
		
		rect.origin.x = CGRectGetMaxX(_coloredFlagView.frame) + 5;
		rect.size.width = CGRectGetWidth(backgroundView.frame) - rect.origin.x;
		rect.size.height = 20;
		_nameLabel = [[UILabel alloc] initWithFrame:rect];
		_nameLabel.font = [UIFont boldSystemFontOfSize:13];
		[backgroundView addSubview:_nameLabel];
		
		rect.origin.y = CGRectGetMaxY(_nameLabel.frame);
		rect.size.height = [[self class] height] - CGRectGetMaxY(_nameLabel.frame);
		_scoreLabel = [[UILabel alloc] initWithFrame:rect];
		_scoreLabel.font = [UIFont systemFontOfSize:13];
		_scoreLabel.textColor = [UIColor lightGrayColor];
		_scoreLabel.textAlignment = NSTextAlignmentCenter;
		[backgroundView addSubview:_scoreLabel];
	}
	return self;
}

- (void)setPerformance:(Performance *)performance {
	_performance = performance;
	if (_performance) {
		_coloredFlagView.backgroundColor = [_performance flagColor];
		_nameLabel.text = _performance.name;
		NSString *text = @"得分 ";
		NSString *string = [NSString stringWithFormat:@"%@%@", text, _performance.score];
		NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
		[attributedString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20], NSForegroundColorAttributeName : [UIColor redColor]} range:NSMakeRange(text.length, string.length - text.length)];
		_scoreLabel.attributedText = attributedString;
	}
}

- (void)prepareForReuse {
	_coloredFlagView.backgroundColor = [UIColor whiteColor];
	_nameLabel.text = nil;
	_scoreLabel.text = nil;
	_scoreLabel.attributedText = nil;
}

@end
