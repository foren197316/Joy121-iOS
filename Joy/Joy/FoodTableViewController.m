//
//  FoodTableViewController.m
//  Joy
//
//  Created by zhangbin on 7/27/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "FoodTableViewController.h"
#import "Food.h"

@interface FoodTableViewController ()

@property (readwrite) NSArray *multiFood;

@end

@implementation FoodTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	NSDictionary *allFood = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Food" ofType:@"plist"]];
	
	NSInteger start = 1;
	
	if (_type == FoodTypeVegetable) {
	} else if (_type == FoodTypeFruit) {
		start = 5;
	} else if (_type == FoodTypeMeat) {
		start = 9;
	} else if (_type == FoodTypeSpecial) {
		start = 13;
	} else if (_type == FoodTypeNuts) {
		start = 17;
	} else {
		start = 21;
	}
	NSString *key;
	key = [NSString stringWithFormat:@"%ld", start];
	Food *food1 = [[Food alloc] initWithAttributes:allFood[key]];
	start++;
	key = [NSString stringWithFormat:@"%ld", start];
	Food *food2 = [[Food alloc] initWithAttributes:allFood[key]];
	start++;
	key = [NSString stringWithFormat:@"%ld", start];
	Food *food3 = [[Food alloc] initWithAttributes:allFood[key]];
	start++;
	key = [NSString stringWithFormat:@"%ld", start];
	Food *food4 = [[Food alloc] initWithAttributes:allFood[key]];
	start++;
	key = [NSString stringWithFormat:@"%ld", start];
	_multiFood = @[food1, food2, food3, food4];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _multiFood.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
	}
	Food *food = _multiFood[indexPath.row];
	cell.imageView.image = [UIImage imageNamed:food.imageName];
	cell.textLabel.text = food.name;
	cell.textLabel.adjustsFontSizeToFitWidth = YES;
	cell.textLabel.textColor = [UIColor orangeColor];
	cell.detailTextLabel.numberOfLines = 0;
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@", food.price, food.describe];
    return cell;
}

@end
