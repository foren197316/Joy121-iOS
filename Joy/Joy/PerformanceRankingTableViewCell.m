//
//  PerformanceRankingTableViewCell.m
//  Joy
//
//  Created by zhangbin on 2/17/15.
//  Copyright (c) 2015 颜超. All rights reserved.
//

#import "PerformanceRankingTableViewCell.h"

@interface PerformanceRankingTableViewCell ()

@property (readwrite) UILabel *indexLabel;
@property (readwrite) UILabel *usernameLabel;
@property (readwrite) UILabel *scoreLabel;
@property (readwrite) UILabel *pointsLabel;
@property (readwrite) UILabel *costCenterLabel;

@end

@implementation PerformanceRankingTableViewCell

+ (CGFloat)height {
	return 55;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		CGFloat fullWidth = [UIScreen mainScreen].bounds.size.width;
		CGRect rect = CGRectZero;
		rect.origin.x = 15;
		rect.origin.y = 10;
		rect.size.width = 30;
		rect.size.height = 20;
		_indexLabel = [[UILabel alloc] initWithFrame:rect];
		_indexLabel.font = [UIFont boldSystemFontOfSize:13];
		[self.contentView addSubview:_indexLabel];
		
		rect.origin.x = CGRectGetMaxX(_indexLabel.frame);
		rect.size.width = 60;
		_usernameLabel = [[UILabel alloc] initWithFrame:rect];
		_usernameLabel.font = _indexLabel.font;
		[self.contentView addSubview:_usernameLabel];
		
		rect.origin.x = CGRectGetMaxX(_usernameLabel.frame);
		rect.size.width = 100;
		_scoreLabel = [[UILabel alloc] initWithFrame:rect];
		_scoreLabel.font = _usernameLabel.font;
		[self.contentView addSubview:_scoreLabel];
		
		rect.origin.x = fullWidth - rect.size.width - 15;
		_pointsLabel = [[UILabel alloc] initWithFrame:rect];
		_pointsLabel.font = [UIFont systemFontOfSize:13];
		_pointsLabel.textAlignment = NSTextAlignmentRight;
		_pointsLabel.textColor = [UIColor redColor];
		[self.contentView addSubview:_pointsLabel];
		
		rect.origin.x = CGRectGetMinX(_usernameLabel.frame);
		rect.origin.y = CGRectGetMaxY(_usernameLabel.frame) + 5;
		rect.size.width = 200;
		rect.size.height = 15;
		_costCenterLabel = [[UILabel alloc] initWithFrame:rect];
		_costCenterLabel.font = [UIFont systemFontOfSize:11];
		_costCenterLabel.textColor = [UIColor lightGrayColor];
		[self.contentView addSubview:_costCenterLabel];
	}
	return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
	_indexPath = indexPath;
	if(_indexPath) {
		_indexLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row + 1)];
	}
}

- (void)setPerformance:(Performance *)performance {
	_performance = performance;
	if (_performance) {
		_usernameLabel.text = _performance.username;
		
		NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor lightGrayColor], NSFontAttributeName : [UIFont systemFontOfSize:11]};
		
		NSString *score = @"得分";
		NSString *scoreString = [NSString stringWithFormat:@"%@%@", score, _performance.score];
		NSMutableAttributedString *attributedScoreString = [[NSMutableAttributedString alloc] initWithString:scoreString];
		[attributedScoreString addAttributes:attributes range:NSMakeRange(0, score.length)];
		_scoreLabel.attributedText = attributedScoreString;
		
		NSString *points = @"积分";
		NSString *pointsString = [NSString stringWithFormat:@"%@%@", points, _performance.points];
		NSMutableAttributedString *attributedPointsString = [[NSMutableAttributedString alloc] initWithString:pointsString];
		[attributedPointsString addAttributes:attributes range:NSMakeRange(0, points.length)];
		_pointsLabel.attributedText = attributedPointsString;
		
		_costCenterLabel.text = _performance.costCenterNO;
	}
}


- (void)prepareForReuse {
	[super prepareForReuse];
	_indexLabel.text = nil;
	_usernameLabel.text = nil;
	_scoreLabel.text = nil;
	_scoreLabel.attributedText = nil;
	_pointsLabel.text = nil;
	_pointsLabel.attributedText = nil;
	_costCenterLabel.text = nil;
}


@end
