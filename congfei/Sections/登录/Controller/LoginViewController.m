//
//  LoginViewController.m
//  congfei
//
//  Created by 陈高磊 on 2016/11/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "FindPassWordViewController.h"
#import "FindPassWordViewController.h"
#import "MainViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        self.fd_prefersNavigationBarHidden = YES;
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)goToLogin:(UIButton *)sender {
    
    NSDictionary *dic = @{@"mobile":self.phoneNumberTF.text,@"password":self.passWordTF.text};
    NSString *url = [NSString stringWithFormat:@"%@%@", kMainURL, kUserLogin];
    [[HttpRequest sharedInstance] postWithURLString:url parameters:dic success:^(id responseObject) {
        NSLog(@"登录%@",responseObject);
//        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//        [ud setObject:[responseObject objectForKey:@"data"] forKey:@"userToken"];
        [SkUser sharedInstance].userToken = [responseObject objectForKey:@"data"];
        [SkUserDefaults writeObject: [SkUser sharedInstance] ];
        
        [SkUserDefaults writeIsLogin: YES];
        [self gotoMainView];
    } failure:^(NSError *error) {
        
    }];
}
- (void)gotoMainView {
    MainViewController *mainView = [[MainViewController alloc] init];
    
    self.view.window.rootViewController = mainView;
}

- (IBAction)goToRegister:(UIButton *)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
    
    
}

- (IBAction)findMyPassWord:(UIButton *)sender {
    FindPassWordViewController *findVC = [[FindPassWordViewController alloc] initWithNibName:@"FindPassWordViewController" bundle:nil];
    [self.navigationController pushViewController:findVC animated:YES];
    
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
