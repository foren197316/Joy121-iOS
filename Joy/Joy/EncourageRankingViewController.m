//
//  EncourageRankingViewController.m
//  Joy
//
//  Created by zhangbin on 2/17/15.
//  Copyright (c) 2015 颜超. All rights reserved.
//

#import "EncourageRankingViewController.h"
#import "PerformanceTableViewCell.h"
#import "UITableViewCell+ZBUtilities.h"
#import "PerformanceRankingTableViewCell.h"

@interface EncourageRankingViewController () <UITableViewDataSource, UITableViewDelegate>

@property (readwrite) UITableView *tableView;
@property (readwrite) NSArray *sectionClasses;
@property (readwrite) NSArray *performances;

@end

@implementation EncourageRankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"激励排行榜";
	_sectionClasses	= @[[PerformanceTableViewCell class], [PerformanceRankingTableViewCell class]];
	
	_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	[self.view addSubview:_tableView];
	
	[[JAFHTTPClient shared] encourageDetailsWithReportCaseID:_performance.reportCaseID withblock:^(NSArray *multiAttributes, NSError *error) {
		if (!error) {
			_performances = [Performance multiWithAttributesArray:multiAttributes];
			[_tableView reloadData];
		}
	}];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	Class class = _sectionClasses[indexPath.section];
	if (class == [PerformanceTableViewCell class]) {
		return [class biggerHeight];
	}
	return [class height];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		return 1;
	}
	return _performances.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	Class class = _sectionClasses[indexPath.section];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[class identifier]];
	if (!cell) {
		cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[class identifier]];
	}
	if (class == [PerformanceTableViewCell class]) {
		PerformanceTableViewCell *performanceCell = (PerformanceTableViewCell *)cell;
		performanceCell.isEncourage = YES;
		performanceCell.performance = _performance;
	} else {
		PerformanceRankingTableViewCell *rankingCell = (PerformanceRankingTableViewCell *)cell;
		rankingCell.indexPath = indexPath;
		rankingCell.performance = _performances[indexPath.row];
	}
	return cell;
}

@end
