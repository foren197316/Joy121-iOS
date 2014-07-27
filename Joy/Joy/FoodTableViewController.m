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
	
	NSString *imageURLString = @"http://dushuhu.me/themes/1hdshop/images/qrcode_for_gh_463031496f6f_258.jpg";
    _multiFood = @[ [[Food alloc] initWithAttributes:@{@"image" : imageURLString, @"name" : @"mingzi", @"descirbe" : @"zheshimiaoshu", @"price" : @(1.0)}],
					[[Food alloc] initWithAttributes:@{@"image" : imageURLString, @"name" : @"mingzi"}]
				   ];
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
	[cell.imageView setImageWithURL:[NSURL URLWithString:food.imageURLString] placeholderImage:[UIImage imageNamed:@"GoodsPlaceholder"]];
	cell.textLabel.text = food.name;
	cell.detailTextLabel.text = food.describe;
    return cell;
}

@end
