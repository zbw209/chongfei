//
//  AppDelegate.m
//  congfei
//
//  Created by 陈高磊 on 2016/11/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.hidden = NO;
    [self DataRecovery];
//    self.window.rootViewController = [[MainViewController alloc] init];
        self.window.backgroundColor = [UIColor whiteColor];
    if ([SkUserDefaults readIsLogin]) {
        MainViewController *mainView = [[MainViewController alloc] init];
        
        self.window.rootViewController = mainView;
    }else{
        LoginViewController *loginView = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginView];
        self.window.rootViewController = nav;

    }
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor blackColor],
      NSForegroundColorAttributeName,
      [UIFont boldSystemFontOfSize:18],
      NSFontAttributeName,
      nil]];//导航条文字
    //状态栏颜色
    //自定义返回按钮  (全局设置)
    UIImage *backButtonImage = [[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;

    return YES;
}


- (void)initMainViewController {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]) {
        
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [self DataSave];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self DataRecovery];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)DataRecovery
{
    
    
    if ( [SkUserDefaults readSet] ) {
        [[SkSet sharedInstance] copyWithOtherObject: [SkUserDefaults readSet] ];
    }
    if ( [SkUserDefaults readUser] ) {
        [[SkUser sharedInstance] copyWithOtherObject: [SkUserDefaults readUser] ];
    }
    if ( [SkUserDefaults readPublicConfig] ) {
        [[SkPublicConfig sharedInstance] copyWithOtherObject: [SkUserDefaults readPublicConfig] ];
    }
}
- (void)DataSave
{
    
    
    [SkUserDefaults writeObject: [SkSet sharedInstance] ];
    [SkUserDefaults writeObject: [SkUser sharedInstance] ];
    [SkUserDefaults writeObject: [SkPublicConfig sharedInstance] ];
}

@end
