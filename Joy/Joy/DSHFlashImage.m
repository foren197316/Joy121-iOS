//
//  DSHFlashImage.m
//  dushuhu
//
//  Created by zhangbin on 3/21/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import "DSHFlashImage.h"

static CGSize _size = {640, 307};

@implementation DSHFlashImage

+ (CGSize)originSize
{
	return _size;
}

+ (CGFloat)scaledHeightFitWith:(CGFloat)width
{
	CGFloat ratio = [self originSize].width / width;
	return [self originSize].height / ratio;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<path: %@>", _path];
}

@end
