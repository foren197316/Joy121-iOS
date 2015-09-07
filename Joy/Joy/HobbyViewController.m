//
//  HobbyViewController.m
//  Joy
//
//  Created by gejw on 15/8/18.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import "HobbyViewController.h"

@interface HobbyViewController () {
    NSMutableDictionary *_viewDict;
    NSMutableArray *_selectDatas;
    NSArray *allDatas;
}

@end

@implementation HobbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    allDatas = @[@"打篮球", @"踢足球", @"打羽毛球",
                 @"打乒乓球", @"爬山", @"唱歌",
                 @"看书", @"烹饪", @"画画",
                 @"舞蹈", @"旅游", @"摄影", ];
    JPersonInfo *persinInfo = [JPersonInfo person];
    _viewDict = [NSMutableDictionary dictionary];
    if (![JPersonInfo person].Interesting) {
        [JPersonInfo person].Interesting = @"";
    }
    if ([NSJSONSerialization isValidJSONObject:persinInfo.Interesting]) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:[persinInfo.Interesting dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        _selectDatas = [NSMutableArray arrayWithArray:arr];
    } else {
        _selectDatas = [NSMutableArray arrayWithArray:@[]];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, winSize.width - 40, 20)];
    label.textColor = [UIColor colorWithRed:0.35 green:0.47 blue:0.58 alpha:1];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"选择您的兴趣爱好并画上爱心:";
    [self.view addSubview:label];
    
    int width = (winSize.width - 15 * 4) / 3;
    for (int i = 0; i < allDatas.count; i++) {
        int x = i % 3;
        int y = i / 3;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15 * (x + 1) + width * x, y * 40 + 15 * (y + 1) + label.bottom + 20, width, 40)];
        [button setTitle:[allDatas objectAtIndex:i] forState:UIControlStateNormal];
        [button setTintColor:[UIColor whiteColor]];
        [button setBackgroundColor:[UIColor grayColor]];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [_viewDict setObject:button forKey:[allDatas objectAtIndex:i]];
    }
    [self refreshState];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickButton:(UIButton *)button {
    NSString *title = button.titleLabel.text;
    if ([_selectDatas containsObject:title]) {
        [_selectDatas removeObject:title];
    } else {
        [_selectDatas addObject:title];
    }
    [self refreshState];
}

- (void)refreshState {
    for (NSString *title in allDatas) {
        [[_viewDict objectForKey:title] setBackgroundColor:[_selectDatas containsObject:title] ? [UIColor redColor] : [UIColor grayColor]];
    }
    [JPersonInfo person].Interesting = [_selectDatas JSONString];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
