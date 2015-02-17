//
//  PerformanceViewController.m
//  Joy
//
//  Created by zhangbin on 2/17/15.
//  Copyright (c) 2015 颜超. All rights reserved.
//

#import "PerformanceViewController.h"
#import "PerformanceTableViewCell.h"
#import "UITableViewCell+ZBUtilities.h"
#import "EncourageRankingViewController.h"


@interface PerformanceViewController () <UITableViewDataSource, UITableViewDelegate>

@property (readwrite) UITableView *tableView;
@property (readwrite) NSArray *performances;

@end

@implementation PerformanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"绩效考核";
	if (_isEncourage) {
		self.title = @"员工激励";
	}
	
	_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:_tableView];
	
	[[JAFHTTPClient shared] performanceIsEncourage:_isEncourage WithBlock:^(NSArray *multiAttributes, NSError *error) {
		if (!error) {
			_performances = [Performance multiWithAttributesArray:multiAttributes];
			[_tableView reloadData];
		}
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (_isEncourage) {
		return [PerformanceTableViewCell biggerHeight];
	}
	return [PerformanceTableViewCell height];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return _performances.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	PerformanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PerformanceTableViewCell identifier]];
	if (!cell) {
		cell = [[PerformanceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PerformanceTableViewCell identifier]];
	}
	Performance *performance = _performances[indexPath.section];
	cell.isEncourage = _isEncourage;
	cell.performance = performance;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (!_isEncourage) return;
	EncourageRankingViewController *encourageRankingViewController = [[EncourageRankingViewController alloc] initWithNibName:nil bundle:nil];
	encourageRankingViewController.performance = _performances[indexPath.section];
	[self.navigationController pushViewController:encourageRankingViewController animated:YES];
}



@end
