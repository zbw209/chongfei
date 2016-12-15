//
//  ClockInViewController.m
//  congfei
//
//  Created by 陈高磊 on 2016/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ClockInViewController.h"
#import "YXRadarView.h"
#import "YXRadarIndictorView.h"
@interface ClockInViewController ()<YXRadarViewDelegate, YXRadarViewDateSource>
@property (nonatomic, strong) UIButton *clockInBtn;
@property (nonatomic, weak) YXRadarView *radarView;
@end

@implementation ClockInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"定位打卡";
    self.navigationController.navigationBar.barTintColor = kMainColor;
    self.clockInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _clockInBtn.frame = CGRectMake(0, 0, 190, 190);
    _clockInBtn.backgroundColor = kThemeColor;
    _clockInBtn.layer.cornerRadius = 95;
    _clockInBtn.layer.masksToBounds = YES;
    [_clockInBtn setTitle:@"点击打卡" forState:UIControlStateNormal];
    [_clockInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _clockInBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    [_clockInBtn addTarget:self action:@selector(handleTap) forControlEvents:UIControlEventTouchUpInside];
    [self.customView addSubview:self.clockInBtn];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)handleTap {
    self.clockInBtn.alpha = 0;
    YXRadarView *radarView = [[YXRadarView alloc] initWithFrame:CGRectMake(0, 0, 190, 190)];
    radarView.dataSource = self;
    radarView.delegate = self;
    radarView.radius = 95;
    radarView.backgroundColor = kThemeColor;
    [self.view addSubview:radarView];
    radarView.layer.cornerRadius = 95;
    radarView.layer.masksToBounds = YES;
    radarView.layer.borderWidth = 10;
    radarView.layer.borderColor = [HeXColor colorWithHexString:@"#dde1fe"].CGColor;
    self.radarView = radarView;
    [self.customView addSubview:self.radarView];
    [self.radarView scan];
    
    UIView *yuanView = [[UIView alloc] initWithFrame:CGRectMake(85, 85, 20, 20)];
    yuanView.backgroundColor = kThemeColor;
    yuanView.layer.cornerRadius = 10;
    yuanView.layer.masksToBounds = YES;
    yuanView.layer.borderColor = [HeXColor colorWithHexString:@"#dde1fe"].CGColor;
    yuanView.layer.borderWidth = 5;
    [self.radarView addSubview:yuanView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(yuanView.frame) + 10, 190, 20)];
    titleLabel.text = @"扫描打卡中";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.radarView addSubview:titleLabel];
    
    
    [self clockIn];
    
    
}
#pragma mark  -  上台打卡接口
- (void)clockIn {
    NSString *url = [NSString stringWithFormat:@"%@%@", kMainURL, kClockin];
    NSLog(@"%@aa%@", self.workPlaceID,self.lonlatStr);
    NSDictionary *dic = @{@"token":token,@"workplaceId":self.workPlaceID,@"lonlat":self.lonlatStr};
    [[HttpRequest sharedInstance] postWithURLString:url parameters:dic success:^(id responseObject) {
        NSLog(@"%@", responseObject);
        [self.radarView stop];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - BYXRadarViewDataSource
- (NSInteger)numberOfSectionsInRadarView:(YXRadarView *)radarView
{
    return 0;
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
