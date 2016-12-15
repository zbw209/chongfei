//
//  GrabViewController.m
//  chongfeigong
//
//  Created by 陈高磊 on 2016/10/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GrabViewController.h"
#import "MyTaskViewController.h"
#import "TaskRecordViewController.h"
#import "ClockInViewController.h"

#import <CoreLocation/CoreLocation.h>


#define kHight_TopView   65
#define kTop_Space 10
#define kLeft_Space  10
#define kLabel_Height  30
#define kBtn_Width  90
#define kBtn_Height 45
@interface GrabViewController ()<UIScrollViewDelegate,CLLocationManagerDelegate>{
    CLLocationManager *locationManager;//定位服务
    NSString *currentCity;//当前城市
    NSString *strLatitude;//经度
    NSString *strLongitude;//纬度
    
}
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *placeLabel;//场所
@property (nonatomic, strong) UILabel *typeLabel;//状态
@property (nonatomic, strong) UIButton *publishBtn;//重新上台
@property (nonatomic, strong) UIView *secondView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) MyTaskViewController *taskView;
@property (nonatomic, strong) TaskRecordViewController *recordView;
@property (nonatomic, copy) NSString *workPlaceID;
@property (nonatomic, copy) NSString *lonlatStr;

@end

@implementation GrabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBackgroundColor;
    self.navigationController.navigationBar.barTintColor = kMainColor;
    //配置视图
    [self configTopView];
    [self configSecondView];
    [self locateMap];
    [self getDefaulWorkPlaceData];
    // Do any additional setup after loading the view.
}

- (void)configTopView {
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, kTop_Space + 64, kScreenWidth, kHight_TopView)];
    _topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    
    self.placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeft_Space, 5, kScreenWidth - 100, kLabel_Height)];
    _placeLabel.text = @"场所：金碧辉煌";
    _placeLabel.font = [UIFont systemFontOfSize:14];
    [self.topView addSubview:self.placeLabel];
    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeft_Space, CGRectGetMaxY(self.placeLabel.frame), CGRectGetWidth(self.placeLabel.frame), kLabel_Height)];
    _typeLabel.text = @"状态：空闲中";
    _typeLabel.font = [UIFont systemFontOfSize:14];
    [self.topView addSubview:self.typeLabel];
    
    self.publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _publishBtn.frame = CGRectMake(kScreenWidth - 100, kTop_Space, 90, 45);
    _publishBtn.backgroundColor = kThemeColor;
    [_publishBtn setTitle:@"定位打卡" forState:UIControlStateNormal];
    [_publishBtn addTarget:self action:@selector(handleClockIn) forControlEvents:UIControlEventTouchUpInside];
    _publishBtn.layer.cornerRadius = 5;
    _publishBtn.layer.masksToBounds = YES;
    _publishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.topView addSubview:self.publishBtn];
    
}
- (void)handleClockIn {
    ClockInViewController *clockVC = [[ClockInViewController alloc] initWithNibName:@"ClockInViewController" bundle:nil];
    clockVC.hidesBottomBarWhenPushed = YES;
    clockVC.workPlaceID = self.workPlaceID;
    clockVC.lonlatStr = self.lonlatStr;
    
    [self.navigationController pushViewController:clockVC animated:YES];
}
- (void)configSecondView {
    self.secondView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame) + kTop_Space, kScreenWidth, kScreenHeight - kHight_TopView - 2 * kTop_Space - 64 - 49)];
    _secondView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.secondView];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(0, 0, kScreenWidth / 2, kBtn_Height);
    [_leftBtn setTitle:@"我的点单" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_leftBtn addTarget:self action:@selector(handleLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.secondView addSubview:self.leftBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(kScreenWidth / 2, 0, kScreenWidth / 2, kBtn_Height);
    [_rightBtn setTitle:@"点单记录" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[HeXColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_rightBtn addTarget:self action:@selector(handleRight) forControlEvents:UIControlEventTouchUpInside];
    [self.secondView addSubview:self.rightBtn];
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.leftBtn.frame) - 1, kScreenWidth, 1)];
    aView.backgroundColor = [HeXColor colorWithHexString:@"#f5f6f7"];
    [self.secondView addSubview:aView];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth / 8, CGRectGetMaxY(self.leftBtn.frame) - 2, kScreenWidth / 4, 2)];
    _lineView.backgroundColor = kThemeColor;
    [self.secondView addSubview:self.lineView];
    
    self.myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.leftBtn.frame), kScreenWidth, CGRectGetHeight(self.secondView.frame) - kBtn_Height)];
    _myScrollView.backgroundColor = kBackgroundColor;
    _myScrollView.contentSize = CGSizeMake(2 * kScreenWidth, CGRectGetHeight(self.secondView.frame) - kBtn_Height);
    _myScrollView.showsVerticalScrollIndicator = NO;
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.bounces = NO;
    _myScrollView.pagingEnabled = YES;
    _myScrollView.delegate = self;
    [self.secondView addSubview:self.myScrollView];
    
    self.taskView = [[MyTaskViewController alloc] init];
    _taskView.view.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.secondView.frame) - kBtn_Height);
    [self addChildViewController:self.taskView];
    [self.myScrollView addSubview:self.taskView.view];
    
    self.recordView = [[TaskRecordViewController alloc] init];
    _recordView.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, CGRectGetHeight(self.secondView.frame) - kBtn_Height);
    [self addChildViewController:self.recordView];
    [self.myScrollView addSubview:self.recordView.view];

    
}
- (void)handleLeft {
    [self.myScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [_leftBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[HeXColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    self.lineView.frame = CGRectMake(kScreenWidth / 8, CGRectGetMaxY(self.leftBtn.frame) - 2, kScreenWidth / 4, 2);
}
- (void)handleRight {
    [self.myScrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
    [_rightBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[HeXColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    self.lineView.frame = CGRectMake(kScreenWidth / 8 + kScreenWidth / 2, CGRectGetMaxY(self.leftBtn.frame) - 2, kScreenWidth / 4, 2);
}
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int a = scrollView.contentOffset.x / kScreenWidth;
    if (a == 0) {
        [_leftBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[HeXColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        self.lineView.frame = CGRectMake(kScreenWidth / 8, CGRectGetMaxY(self.leftBtn.frame) - 2, kScreenWidth / 4, 2);
    }else {
        [_rightBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[HeXColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        self.lineView.frame = CGRectMake(kScreenWidth / 8 + kScreenWidth / 2, CGRectGetMaxY(self.leftBtn.frame) - 2, kScreenWidth / 4, 2);
    }

}
#pragma mark - 获取默认工作场所
- (void)getDefaulWorkPlaceData {
    NSString *url = [NSString stringWithFormat:@"%@%@", kMainURL, kDefaulWorkPlace];
    
   
    NSDictionary *dic = @{@"token":[SkUser sharedInstance].userToken};
    [[HttpRequest sharedInstance] postWithURLString:url parameters:dic success:^(id responseObject) {
        NSLog(@"工作场所%@", responseObject);
        self.workPlaceID = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"workplaceId"]];
        NSLog(@"ddd%@", self.workPlaceID);
        
    } failure:^(NSError *error) {
        
    }];
    
}


#pragma mark - 地理定位

- (void)locateMap {
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager requestAlwaysAuthorization];
        currentCity = [[NSString alloc] init];
        [locationManager requestWhenInUseAuthorization];
        //设置寻址经度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 5.0;
        [locationManager startUpdatingLocation];
    }

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    //提示用户打开定位
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许\"定位\"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       //打开定位设置
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
        
        
    }];
    UIAlertAction *cancal = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:cancal];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //打印当前的经纬度
    NSLog(@"%f, %f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    
    self.lonlatStr = [NSString stringWithFormat:@"%f,%f", currentLocation.coordinate.latitude,currentLocation.coordinate.longitude];
    //地理反编码
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            currentCity = placeMark.locality;
            if (!currentCity) {
                currentCity = @"无法定位当前城市";
            }
            
            
        }
    }];
    
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
