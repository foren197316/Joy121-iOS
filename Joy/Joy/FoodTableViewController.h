//
//  FoodTableViewController.h
//  Joy
//
//  Created by zhangbin on 7/27/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FoodType) {
    FoodTypeVegetable,
	FoodTypeFruit,
	FoodTypeMeat,
	FoodTypeSpecial,
	FoodTypeNuts,
	FoodTypeOversea
};

@interface FoodTableViewController : UITableViewController

@property (nonatomic, assign) FoodType type;

@end
