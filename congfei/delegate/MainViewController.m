//
//  MainViewController.m
//  chongfeigong
//
//  Created by 陈高磊 on 2016/10/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MainViewController.h"
#import "GrabViewController.h"
#import "MassageViewController.h"
#import "MineViewController.h"

#import "LoginViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getControllers];
//    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//    [self presentViewController:loginVC animated:YES completion:^{
//        
//    }];
    // Do any additional setup after loading the view.
}
- (void)getControllers {
    GrabViewController *VC1 = [[GrabViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:VC1];
    
    //    InfoViewController *VC2 = [[InfoViewController alloc] init];
//    DateViewController *VC2 = [[DateViewController alloc] init];
//    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:VC2];
    MassageViewController *VC3 = [[MassageViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:VC3];
    MineViewController *VC4 = [[MineViewController alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:VC4];
   
    VC1.title = @"订单";
//    VC2.title = @"约会";
    VC3.title = @"消息";
    VC4.title = @"我的";
        //2.
    NSArray *viewCtrs = @[nav1,nav3,nav4];
    self.viewControllers =viewCtrs;
    nav1.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_order_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav1.tabBarItem.image = [[UIImage imageNamed:@"tab_order_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    nav3.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_info_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav3.tabBarItem.image = [[UIImage imageNamed:@"tab_info_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    nav4.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_user_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav4.tabBarItem.image = [[UIImage imageNamed:@"tab_user_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //tabbar字体
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:12]} forState:UIControlStateNormal];
    
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kMainColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:12]} forState:UIControlStateSelected];
    [[UITabBar appearance] setTranslucent:NO];
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
