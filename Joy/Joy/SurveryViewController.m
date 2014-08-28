//
//  SurveryViewController.m
//  Joy
//
//  Created by 颜超 on 14-5-8.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "SurveryViewController.h"

@interface SurveryViewController () <SurveyCellDelegate>

@property (readwrite) UISegmentedControl *segmentedControl;
@property (readwrite) NSArray *surveys;

@end

@implementation SurveryViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
	self = [super initWithStyle:style];
	if (self) {
		self.title = NSLocalizedString(@"调查", nil);
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	_segmentedControl = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"最新发布", nil), NSLocalizedString(@"已过期", nil)]];
	_segmentedControl.selectedSegmentIndex = 0;
	[_segmentedControl addTarget:self action:@selector(segmentedControlChanged) forControlEvents:UIControlEventValueChanged];
	_segmentedControl.tintColor = [UIColor secondaryColor];
	
    [self loadData];
}

- (void)segmentedControlChanged
{
	[self loadData];
}

- (BOOL)expiredSelected
{
	return _segmentedControl.selectedSegmentIndex == 1;
}

- (void)loadData
{
    [self displayHUD:NSLocalizedString(@"加载中...", nil)];
    [[JAFHTTPClient shared] surveysIsExpired:[self expiredSelected] withBlock:^(NSDictionary *result, NSError *error) {
        [self hideHUD:YES];
        if ([result[@"retobj"] isKindOfClass:[NSArray class]]) {
            if ([result[@"retobj"] count] > 0) {
				_surveys = [Survey multiWithAttributesArray:result[@"retobj"]];
                [self.tableView reloadData];
            }
        }
    }];
}

#pragma mark - UITabelViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_surveys count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SurveyCell *cell = (SurveyCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    SurveyCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[SurveyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
	[cell setDelegate:self];
	Survey *survery = _surveys[indexPath.row];
	survery.bExpired = [self expiredSelected];
	[cell setSurvery:survery];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	return _segmentedControl;
}

#pragma mark - SurveryCellDelegate

- (void)voteButtonClicked:(NSString *)voteString andSurvery:(Survey *)survery
{
    [[JAFHTTPClient shared] voteSubmit:survery.sid answers:voteString withBlock:^(NSDictionary *result, NSError *error) {
		if (!error) {
			[self loadData];
		}
    }];
}

@end
