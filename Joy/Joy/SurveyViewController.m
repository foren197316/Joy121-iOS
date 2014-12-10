//
//  SurveyViewController.m
//  Joy
//
//  Created by 颜超 on 14-5-8.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "SurveyViewController.h"

@interface SurveyViewController () <SurveyCellDelegate>

@property (readwrite) UISegmentedControl *segmentedControl;
@property (readwrite) NSArray *surveys;

@end

@implementation SurveyViewController

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
	_segmentedControl.backgroundColor = [UIColor whiteColor];
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
            } else {
				_surveys = nil;
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
	Survey *survey = _surveys[indexPath.row];
	return [SurveyCell heightWithSurvey:survey];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *noreuseIdentifier = [NSString stringWithFormat:@"cell%@", @(indexPath.row)];
    SurveyCell *cell = [[SurveyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noreuseIdentifier];
	[cell setDelegate:self];
	Survey *survey = _surveys[indexPath.row];
	survey.bExpired = [self expiredSelected];
	[cell setSurvey:survey];
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
#pragma mark - SurveyCellDelegate

- (void)willSubmitSurvey:(Survey *)survey withVotes:(NSArray *)votes
{
	NSInteger selected = 0;
	for (int i = 0; i < votes.count; i++) {
		NSString *v = votes[i];
		if ([v isEqualToString:@"1"]) {
			selected++;
		}
	}
	
	if (![survey isRadio]) {
		if (survey.min) {
			if (selected < [survey.min integerValue]) {
				[self displayHUDTitle:nil message:[NSString stringWithFormat:@"最少选%@个", survey.min] duration:1];
				return;
			}
		}
		
		if (survey.max) {
			if (selected > [survey.max integerValue]) {
				[self displayHUDTitle:nil message:[NSString stringWithFormat:@"最多选%@个", survey.max] duration:1];
				return;
			}
		}
	} else {
		if (selected != 1) {
			[self displayHUDTitle:nil message:@"只能选择一个" duration:1];
			return;
		}
	}
	
    [[JAFHTTPClient shared] voteSubmit:survey.sid answers:[survey votesStringWithVotes:votes] withBlock:^(NSDictionary *result, NSError *error) {
		if (!error) {
			[self loadData];
		}
    }];
}

@end
