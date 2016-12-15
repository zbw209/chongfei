//
//  MineViewController.m
//  chongfeigong
//
//  Created by 陈高磊 on 2016/10/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderView.h"
@interface MineViewController ()
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.fd_prefersNavigationBarHidden = YES;
    self.title = @"我的";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    MineHeaderView *mineView = [[NSBundle mainBundle]loadNibNamed:@"MineHeaderView" owner:nil options:nil].lastObject;
    self.tableView.tableHeaderView = mineView;

    // Do any additional setup after loading the view.
    
    
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
