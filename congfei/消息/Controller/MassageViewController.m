//
//  MassageViewController.m
//  chongfeigong
//
//  Created by 陈高磊 on 2016/10/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MassageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageDetailViewController.h"
#import "MessageListModel.h"

@interface MassageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataAry;


@end
static NSString *identifier = @"MessageTableViewCell";
@implementation MassageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [HeXColor colorWithHexString:@"#f2f6f9"];
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
    [self.view addSubview:self.tableView];
    [self getData];
}

- (NSMutableArray *)dataAry {
    if (!_dataAry) {
        self.dataAry = [NSMutableArray array];
    }
    return _dataAry;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataAry.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MessageListModel *model = self.dataAry[indexPath.row];
    cell.model = model;
    
    return cell;
}


- (void)getData {
    NSString *str = [NSString stringWithFormat:@"%@%@",kMainURL,kMessageList ];
   
    NSDictionary *dic = @{@"token":[SkUser sharedInstance].userToken};
    
    [[HttpRequest sharedInstance] postWithURLString:str parameters:dic success:^(id responseObject) {
        NSLog(@"%@", responseObject);
        self.dataAry = [MessageListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSLog(@"消息%@", self.dataAry);
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageDetailViewController *detailVC = [[MessageDetailViewController alloc] init];
    MessageListModel *model = self.dataAry[indexPath.row];
    
    detailVC.messageID = model.cUserId;
    
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
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
