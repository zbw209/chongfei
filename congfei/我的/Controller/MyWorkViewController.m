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

#import "WorkPlaceModel.h"

@interface MyWorkViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sourceArray;
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

    self.sourceArray = [NSArray new];
    [self getData];
}

#pragma mark - Actions 
- (void)getData {
    NSString *allWorkPlaceUrlStr = [NSString stringWithFormat:@"%@%@",kMainURL,kAllWorkPlace];
    NSDictionary *dict = @{@"token" : [SkUser sharedInstance].userToken};
    
    [[HttpRequest sharedInstance] getWithURLString:allWorkPlaceUrlStr
                                        parameters:dict
                                           success:^(id responseObject)
     {
         NSLog(@"%s,%d responseObject = %@",__FUNCTION__,__LINE__,responseObject);
         self.sourceArray = [WorkPlaceModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
         
     } failure:^(NSError *error) {
         NSLog(@"%s,%d error = %@",__FUNCTION__,__LINE__,error);
     }];
}

- (void)handleAddWork {
    AddNewWorkViewController *addVC = [[AddNewWorkViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 81;
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
  
    
    return cell;
}

@end
