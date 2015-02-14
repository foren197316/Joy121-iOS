//
//  ClockViewController.m
//
//
//  Created by 无非 on 14/12/9.
//
//

#import "ClockViewController.h"
#import <MAMapKit/MAMapKit.h>
#define MKMapKey @"89af3af42f2789e2528ed7da9df245c8"
#define NowViewScreenWidth [UIScreen mainScreen].bounds.size.width
#define NowViewScrrenHeight [UIScreen mainScreen].bounds.size.height
#define ARC4RANDOM_MAX      0x100000000

@interface ClockViewController ()<UITableViewDataSource,UITableViewDelegate,MAMapViewDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>
{
    MAMapView *mapViewCustom;
    UIButton *goToWorkBtn;
    UIButton *goOffWorkBtn;
    UITableView *reportTableView;
    UIButton *addBtn;
    UIButton *miunBtn;
    UIButton *nowCentreBtn;
    CLLocationManager *locationManager;
    NSString *longitudeStr;
    NSString *latitudeStr;
    NSMutableArray *timeArray;
    NSMutableArray *clockTypeArray;
}
@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"APP考勤";
    timeArray = [[NSMutableArray alloc]init];
    clockTypeArray = [[NSMutableArray alloc]init];
    [self updateListInformation];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MAMapServices sharedServices].apiKey = MKMapKey;
    mapViewCustom = [[MAMapView alloc]initWithFrame:CGRectMake( 0,  self.tabBarController.tabBar.frame.size.height + 8, NowViewScreenWidth, 200)];
    mapViewCustom.delegate = self;
    mapViewCustom.mapType = MAMapTypeStandard;
    mapViewCustom.delegate = self;
    mapViewCustom.showsCompass = NO;
    mapViewCustom.showsScale = NO;
    mapViewCustom.showsUserLocation = YES;
    mapViewCustom.zoomLevel = 15.2;
    [self.view addSubview:mapViewCustom];
    [mapViewCustom setUserInteractionEnabled:YES];
    [self creatClockView];
    [self getUserCurrLocation];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

//添加控件
- (void)creatClockView
{
    nowCentreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nowCentreBtn.frame = CGRectMake(mapViewCustom.frame.size.width - 50, 10, 40, 40);
    [nowCentreBtn setTitle:@"now" forState:UIControlStateNormal];
    [nowCentreBtn addTarget:self action:@selector(twoBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
    [nowCentreBtn setBackgroundColor:[UIColor whiteColor]];
    nowCentreBtn.tag = 302;
    [nowCentreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nowCentreBtn.alpha = 0.8;
    nowCentreBtn.layer.borderColor = [UIColor grayColor].CGColor;
    nowCentreBtn.layer.borderWidth = 0.8f;
    nowCentreBtn.layer.cornerRadius = 3.0f;
    [mapViewCustom addSubview:nowCentreBtn];
    
    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(mapViewCustom.frame.size.width - 50, nowCentreBtn.frame.origin.y + 80, 40, 40);
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(twoBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setBackgroundColor:[UIColor whiteColor]];
    addBtn.tag = 303;
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addBtn.alpha = 0.8;
    addBtn.layer.borderColor = [UIColor grayColor].CGColor;
    addBtn.layer.borderWidth = 0.8f;
    addBtn.layer.cornerRadius = 3.0f;
    [mapViewCustom addSubview:addBtn];
    
    miunBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    miunBtn.frame = CGRectMake(mapViewCustom.frame.size.width - 50, addBtn.frame.origin.y + addBtn.frame.size.height, 40, 40);
    [miunBtn setTitle:@"-" forState:UIControlStateNormal];
    [miunBtn addTarget:self action:@selector(twoBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
    [miunBtn setBackgroundColor:[UIColor whiteColor]];
    [miunBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    miunBtn.alpha = 0.8;
    miunBtn.layer.borderColor = [UIColor grayColor].CGColor;
    miunBtn.layer.borderWidth = 0.8f;
    miunBtn.layer.cornerRadius = 3.0f;
    miunBtn.tag = 304;
    [mapViewCustom addSubview:miunBtn];
    
    
    goToWorkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goToWorkBtn.frame = CGRectMake(10, mapViewCustom.frame.origin.y + mapViewCustom.frame.size.height + 10, 140, 40);
    [goToWorkBtn setTitle:@"上班" forState:UIControlStateNormal];
    [goToWorkBtn addTarget:self action:@selector(twoBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
   // [goToWorkBtn setBackgroundColor:[UIColor colorWithRed:56.0f/255.0f green:167.0f/255.0f blue:227.0f/255.0f alpha:1.0]];
    //secondaryColor
   [goToWorkBtn setBackgroundColor:[UIColor secondaryColor]];
    goToWorkBtn.tag = 300;
    [self.view addSubview:goToWorkBtn];
    
    goOffWorkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goOffWorkBtn.frame = CGRectMake(NowViewScreenWidth - 150, mapViewCustom.frame.origin.y + mapViewCustom.frame.size.height + 10, 140, 40);
    [goOffWorkBtn setBackgroundColor:[UIColor secondaryColor]];
    [goOffWorkBtn setTitle:@"下班" forState:UIControlStateNormal];
    [goOffWorkBtn addTarget:self action:@selector(twoBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
    goOffWorkBtn.tag = 301;
    [self.view addSubview:goOffWorkBtn];
    
    reportTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, goToWorkBtn.frame.origin.y + goToWorkBtn.frame.size.height + 10, NowViewScreenWidth, NowViewScrrenHeight - (goToWorkBtn.frame.origin.y + goToWorkBtn.frame.size.height + 10))];
    reportTableView.delegate = self;
    reportTableView.dataSource = self;
    [self.view addSubview:reportTableView];
    
}

//定位显示当前位置
-(void)getUserCurrLocation
{
    locationManager =[[CLLocationManager alloc] init];
    
    // fix ios8 location issue
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
#ifdef __IPHONE_8_0
        if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [locationManager performSelector:@selector(requestAlwaysAuthorization)];//用这个方法，plist中需要NSLocationAlwaysUsageDescription
        }
        
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [locationManager performSelector:@selector(requestWhenInUseAuthorization)];//用这个方法，plist里要加字段NSLocationWhenInUseUsageDescription
        }
#endif
    }
    mapViewCustom.showsUserLocation = YES;//定位开启
    [mapViewCustom setUserTrackingMode:MAUserTrackingModeFollow animated:YES];//定位模式有三种，当前地图跟着位置移动
}
#pragma MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointGetReuseIndetifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

#pragma mark - 覆盖物 delegate
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAGroundOverlay class]])
    {
        MAGroundOverlayRenderer *groundOverlayRenderer = [[MAGroundOverlayRenderer alloc] initWithGroundOverlay:overlay];
        [groundOverlayRenderer setAlpha:0.8];
        return groundOverlayRenderer;
    }
    return nil;
}

//- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
//{
//    userLocation.title = @"我的位置";
//    userLocation.subtitle = @"123";
//}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    userLocation.title = @"我的位置";
    userLocation.subtitle = [NSString stringWithFormat:@"纬度:%0.5f经度:%0.5f",userLocation.coordinate.latitude,userLocation.coordinate.longitude];
    latitudeStr = [NSString stringWithFormat:@"%0.5f",userLocation.coordinate.latitude];
    longitudeStr = [NSString stringWithFormat:@"%0.5f",userLocation.coordinate.longitude];
    if (updatingLocation) {
        userLocation.subtitle = [NSString stringWithFormat:@"纬度:%0.5f经度:%0.5f",userLocation.coordinate.latitude,userLocation.coordinate.longitude];
        latitudeStr = [NSString stringWithFormat:@"%0.5f",userLocation.coordinate.latitude];
        longitudeStr = [NSString stringWithFormat:@"%0.5f",userLocation.coordinate.longitude];
    }
}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    [self displayHUDTitle:@"定位失败" message:nil duration:2.0];
    NSLog(@"dingwei shibai ");
}


//两个按钮事件
- (void)twoBtnsAction:(UIButton *)tempBtn
{
    switch (tempBtn.tag) {
        case 300:
        {
            UIAlertView *alertGotoWork = [[UIAlertView alloc]initWithTitle:@"打卡提示" message:@"现在是上班打卡，是否确认打卡！" delegate:self cancelButtonTitle:@"不了" otherButtonTitles:@"立即", nil];
            alertGotoWork.tag = 500;
            [alertGotoWork show];
        }
            break;
        case 301:
        {
            UIAlertView *alertGotoWork = [[UIAlertView alloc]initWithTitle:@"打卡提示" message:@"现在是下班打卡，是否确认打卡！" delegate:self cancelButtonTitle:@"不了" otherButtonTitles:@"立即", nil];
            alertGotoWork.tag = 501;
            [alertGotoWork show];
        }
            break;
        case 302:
            [self getUserCurrLocation];
            break;
        case 303:
            mapViewCustom.zoomLevel += 0.5;
            break;
        case 304:
            mapViewCustom.zoomLevel -=0.5;
            break;
        default:
            break;
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (alertView.tag == 500) {
            [self pitchClockAction:@"0"];
        }
        if (alertView.tag == 501) {
            [self pitchClockAction:@"1"];
        }
    }
}

//打卡事件
- (void)pitchClockAction:(NSString *)type
{
    NSString *loginName = [[JAFHTTPClient shared]userName];
    NSLog(@"%@,%@,%@",longitudeStr,latitudeStr,loginName);
    if (![longitudeStr isEqualToString:@""] || ![latitudeStr isEqualToString:@""]) {
        [self displayHUD:@"提交中..."];
        NSData *received = [[JAFHTTPClient shared ] printCard:type longitude:longitudeStr latitude:latitudeStr];
        NSLog(@"%@",[[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding]);
        if (received != nil){
            NSError *error = nil;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
            if (error == nil) {
                if ([[dic objectForKey:@"retobj"] isKindOfClass:[NSNull class]]) {
                    [self displayHUDTitle:@"链接服务器异常，打卡失败" message:nil duration:2.0];
                }
                else{
                    [self displayHUDTitle:@"打卡成功 ！" message:nil duration:2.0];
                    double delayInSeconds = 1.5;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        NSLog(@"5s delay");
                        [self updateListInformation];
                    });
                }
            }
            else{
                [self displayHUDTitle:@"链接服务器异常，打卡失败" message:nil duration:2.0];
            }
        }
        else{
            [self displayHUDTitle:@"链接服务器异常，打卡失败" message:nil duration:2.0];
        }
    }
    else{
        [self displayHUDTitle:@"定位失败，不能打卡" message:nil duration:2.0];
    }
}


//更新列表数据
- (void)updateListInformation
{
    [self displayHUD:@"刷新列表"];
    NSData *received = [[JAFHTTPClient shared] loadWorkData];
    NSLog(@"%@",[[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding]);
    if (received != nil) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        if (error == nil) {
            [timeArray removeAllObjects];
            [clockTypeArray removeAllObjects];
            [self hideHUD:YES];
            NSDictionary *retobjDic = [dic objectForKey:@"retobj"];
            if ([retobjDic isKindOfClass:[NSNull class]]) {
                [self displayHUDTitle:@"链接服务器失败" message:nil duration:1.5];
            }else{
                for (NSDictionary *dicforValue in retobjDic) {
                    NSString *timeStr = [dicforValue objectForKey:@"PunchTime"];
                    timeStr = [timeStr substringWithRange:NSMakeRange(6, 10)];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateStyle:NSDateFormatterMediumStyle];
                    [formatter setTimeStyle:NSDateFormatterShortStyle];
                    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStr intValue]];
                    timeStr = [formatter stringFromDate:confromTimesp];
                    [timeArray addObject:timeStr];
                    NSString *typeClockValue = [dicforValue objectForKey:@"PunchType"];
                    switch ([typeClockValue intValue]) {
                        case 0:
                            typeClockValue = @"上班打卡";
                            break;
                        case 1:
                            typeClockValue = @"下班打卡";
                            break;
                        default:
                            break;
                    }
                    [clockTypeArray addObject:typeClockValue];
                }
                [reportTableView reloadData];
            }
        }
        else{
            [self displayHUDTitle:@"链接服务器失败" message:nil duration:1.5];
        }
    }
    else{
        [self displayHUDTitle:@"链接服务器失败" message:nil duration:1.5];
    }
}

#pragma mark - UITableViewDelegate DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return timeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellInderFier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellInderFier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellInderFier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [timeArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [clockTypeArray objectAtIndex:indexPath.row];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
