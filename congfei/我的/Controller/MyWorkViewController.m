//
//  MyWorkViewController.m
//  congfei
//
//  Created by 陈高磊 on 2016/11/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyWorkViewController.h"
#import "MyWorkTableViewCell.h"
#import "AddNewWorkViewController.h"
@interface MyWorkViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *identifier = @"MyWorkTableViewCell";
@implementation MyWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的工作";
    
    self.view.backgroundColor = [HeXColor colorWithHexString:@"#f2f6f9"];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight - 10) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [HeXColor colorWithHexString:@"#f2f6f9"];
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
    [self.view addSubview:self.tableView];
    
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.frame = CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44);
    footBtn.backgroundColor = kMainColor;
    [footBtn setTitle:@"新增工作场所" forState:UIControlStateNormal];
    [footBtn addTarget:self action:@selector(handleAddWork) forControlEvents:UIControlEventTouchUpInside];
    [footBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:footBtn];
    
    // Do any additional setup after loading the view.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 81;
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
  
    
    return cell;
}

- (void)handleAddWork {
    AddNewWorkViewController *addVC = [[AddNewWorkViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
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
