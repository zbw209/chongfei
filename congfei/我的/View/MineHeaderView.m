//
//  MineHeaderView.m
//  congfei
//
//  Created by 陈高磊 on 2016/11/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MineHeaderView.h"
#import "MyWorkViewController.h"
#import "MyIndentViewController.h"

#define CUSTOMER_SERVICE_PHONE [NSURL URLWithString:@"tel://4008571222"]

@implementation MineHeaderView


- (IBAction)myWork:(UIButton *)sender {
    MyWorkViewController *workVC = [[MyWorkViewController alloc] init];
    workVC.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:workVC animated:YES];
}
- (IBAction)myIndentBtn:(UIButton *)sender {
    MyIndentViewController *indentVC = [[MyIndentViewController alloc] init];
    indentVC.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:indentVC animated:YES];
    
}
- (IBAction)callPhone:(UIButton *)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"0571-28276366"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self addSubview:callWebview];

//    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"是否拨打客服热线" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    [alertView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//        
//        
//    }]];
//    
//    
//    
//    [alertView addAction:[UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        
//    }]];
//    [self.viewController presentViewController:alertView animated:YES completion:nil];

    
}


@end
