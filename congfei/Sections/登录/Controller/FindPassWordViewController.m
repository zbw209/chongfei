//
//  FindPassWordViewController.m
//  congfei
//
//  Created by 陈高磊 on 2016/11/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FindPassWordViewController.h"
#import "NewPassWordViewController.h"
@interface FindPassWordViewController ()

@end

@implementation FindPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.getCodeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.title = @"找回密码";
    // Do any additional setup after loading the view from its nib.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)handleGetCode:(UIButton *)sender {
    NSString *url = [NSString stringWithFormat:@"%@%@", kMainURL, kFindPassWordCode];
    NSDictionary *dic = @{@"mobile":self.phoneNumberLabel.text};
    
    [[HttpRequest sharedInstance] postWithURLString:url parameters:dic success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
    } failure:^(NSError *error) {
        
    }];
    
}


- (IBAction)makeSure:(UIButton *)sender {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kMainURL,kFindCheckCode];
    NSDictionary *dic = @{@"mobile":self.phoneNumberLabel.text, @"code":self.codeTF.text};
    [[HttpRequest sharedInstance] postWithURLString:url parameters:dic success:^(id responseObject) {
        NSLog(@"%@", responseObject);
        NewPassWordViewController *newVC = [[NewPassWordViewController alloc] initWithNibName:@"NewPassWordViewController" bundle:nil];
        newVC.phoneNumber = self.phoneNumberLabel.text;
        [self.navigationController pushViewController:newVC animated:YES];
        
        
    } failure:^(NSError *error) {
        
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
