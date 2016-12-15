//
//  RegisterViewController.m
//  congfei
//
//  Created by 陈高磊 on 2016/11/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.getCodeBtn.layer.cornerRadius = 5;
    self.getCodeBtn.layer.masksToBounds = YES;
    self.getCodeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.getCodeBtn.layer.borderWidth = 1;
    // Do any additional setup after loading the view from its nib.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark 验证码
- (IBAction)handleGetCode:(UIButton *)sender {
     [self startTime];
    NSDictionary *dic = @{@"mobile":self.phoneTF.text};
    NSLog(@"%@", self.phoneTF.text);
    NSString *url = [NSString stringWithFormat:@"%@%@", kMainURL,kUserCode];
    

    [[HttpRequest sharedInstance] postWithURLString:url parameters:dic success:^(id responseObject) {
        NSDictionary *dic=responseObject;
        NSLog(@"ddddd%@",dic);
        
        
    } failure:^(NSError *error) {
        NSLog(@"aaaa%@", error);
        
    }];
    
}

#pragma mark 注册
- (IBAction)handleRegister:(UIButton *)sender {
//    [MBProgressHUD hudWithView:nil label:@"注册中..."];
    NSDictionary *dic = @{@"mobile":self.phoneTF.text, @"code":self.codeTF,@"password":self.passWordTF};
    NSString *url = [NSString stringWithFormat:@"%@%@", kMainURL, kUserRegister];
    [[HttpRequest sharedInstance] getWithURLString:url parameters:dic success:^(id responseObject) {
        [MBProgressHUD checkHudWithView:nil label:@"注册成功,请登录" hidesAfter:1];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
//    [[HttpRequest sharedInstance] postWithURLString:url parameters:dic success:^(id responseObject) {
//        NSLog(@"注册%@", responseObject);
//        [MBProgressHUD checkHudWithView:nil label:@"注册成功,请登录" hidesAfter:1];
//        [self.navigationController popViewControllerAnimated:YES];
//    } failure:^(NSError *error) {
//        
//    }];
}

-(void)startTime{
    
    __block int timeout= 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                
                self.getCodeBtn.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [UIView beginAnimations:nil context:nil];
                
                [UIView setAnimationDuration:1];
                
                [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                
                [UIView commitAnimations];
                
                self.getCodeBtn.userInteractionEnabled = NO;
                
            });
            
            timeout--;
        }
        
    });
    
    dispatch_resume(_timer);
    
    
    
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
