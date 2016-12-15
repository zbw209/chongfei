//
//  NewPassWordViewController.m
//  congfei
//
//  Created by 陈高磊 on 2016/12/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NewPassWordViewController.h"

@interface NewPassWordViewController ()

@end

@implementation NewPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)complete:(UIButton *)sender {
    NSString *url = [NSString stringWithFormat:@"%@%@", kMainURL, kChangePassWord];
    NSDictionary *dic = @{@"mobile":self.phoneNumber,@"password":self.newpwTF};
    
    [[HttpRequest sharedInstance] postWithURLString:url parameters:dic success:^(id responseObject) {
        NSLog(@"%@", responseObject);
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
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
