//
//  AddNewWorkViewController.m
//  congfei
//
//  Created by 陈高磊 on 2016/11/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AddNewWorkViewController.h"
#import "NewWorkHeaderView.h"

#define kTanview_Height   260
#define kBtn_Width      80
#define kBtn_Height     40
@interface AddNewWorkViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIView *backView;
    UIView *tanView;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *companyAry;

@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *serviceIncome;
@property (nonatomic, strong) NSString *supperName;
@property (nonatomic, strong) NSString *supperTel;
@property (nonatomic, strong) NSString *workNum;

@end

@implementation AddNewWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [HeXColor colorWithHexString:@"#f2f6f9"];
    self.title = @"新增工作场所";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonPressed:)];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight - 10) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    NewWorkHeaderView *newWorkHeader = [[NSBundle mainBundle]loadNibNamed:@"NewWorkHeaderView" owner:nil options:nil].lastObject;
    newWorkHeader.tag = 101;
    [newWorkHeader.companyBtn addTarget:self action:@selector(handleChoseCompany) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = newWorkHeader;
    
     self.companyAry = @[@"金碧辉煌1111",@"金碧辉煌2222",@"金碧辉煌3333",@"金碧辉煌4444",@"金碧辉煌5555",@"金碧辉煌6666"];
    [self getData];
}




// 78946
/*
 {
 "id": 0,
 "auserId": 0,
 "workplaceId": 0,
 "workNum": "string",
 "serviceFee": 0,
 "supperName": "string",
 "supperTel": "string",
 "creator": "string",
 "gmtCreate": "2016-12-15T03:01:36.857Z",
 "modifier": "string",
 "gmtModified": "2016-12-15T03:01:36.857Z",
 "default": true
 }
 */
- (void)saveButtonPressed:(UIBarButtonItem *)barItem {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kMainURL,kAddWorkPlace];
    
    NSDictionary *dict = @{@"token" : [SkUser sharedInstance].userToken,
                           @"body" : @{}};
    [[HttpRequest sharedInstance]postWithURLString:urlStr parameters:dict success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)handleChoseCompany {
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    [self.tabBarController.view addSubview:backView];
    
    tanView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kTanview_Height)];
    tanView.backgroundColor = [UIColor whiteColor];
    [self.tabBarController.view addSubview:tanView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, kBtn_Width, kBtn_Height);
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(handleCancal) forControlEvents:UIControlEventTouchUpInside];
     leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tanView addSubview:leftBtn];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kBtn_Width, 0, kScreenWidth - 2 * kBtn_Width, kBtn_Height)];
    nameLabel.text = @"公司名称";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [tanView addSubview:nameLabel];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame), 0, kBtn_Width, kBtn_Height);
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(handleSure) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [tanView addSubview:rightBtn];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame), kScreenWidth, 1)];
    lineView.backgroundColor = [HeXColor colorWithHexString:@"#e8e9ea"];
    [tanView addSubview:lineView];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kBtn_Height, kScreenWidth, kTanview_Height - kBtn_Height)];
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [tanView addSubview:self.pickerView];
    
    UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(0, kTanview_Height/ 2, kScreenWidth, 1)];
    firstView.backgroundColor = [HeXColor colorWithHexString:@"#e8e9ea"];
    [tanView addSubview:firstView];
   
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(0, kTanview_Height/ 2 + kBtn_Height, kScreenWidth, 1)];
    secondView.backgroundColor = [HeXColor colorWithHexString:@"#e8e9ea"];
    [tanView addSubview:secondView];
    
    [UIView animateWithDuration:0.5 animations:^{
        tanView.frame = CGRectMake(0, kScreenHeight - kTanview_Height, kScreenWidth, kTanview_Height);
    } completion:^(BOOL finished) {
        
    }];

}
- (void)handleCancal {
   
    [UIView animateWithDuration:0.5 animations:^{
        tanView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kTanview_Height);
    } completion:^(BOOL finished) {
         backView.alpha = 0;
        [tanView removeFromSuperview];
        [backView removeFromSuperview];
        
    }];
    
}
- (void)handleSure {
    NSInteger result = [self.pickerView selectedRowInComponent:0];
    //赋值
    NewWorkHeaderView *newWorkHeader = [self.view viewWithTag:101];
    newWorkHeader.companyNameLabel.text = self.companyAry[result];
    
    [self handleCancal];
   
    
}
#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.companyAry.count;
}
#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return kScreenWidth;
}
//设置组件中每行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}
//设置组件中每行的标题row:行
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _companyAry[row];

}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
  
        NSString  *_proNameStr = [_companyAry objectAtIndex:row];
        NSLog(@"nameStr=%@",_proNameStr);
    
    
}


- (void)getData {
    NSString *allWorkPlaceUrlStr = [NSString stringWithFormat:@"%@%@",kMainURL,kDefaulWorkPlace];
    NSDictionary *dict = @{@"token" : [SkUser sharedInstance].userToken};
    
    [[HttpRequest sharedInstance]postWithURLString:allWorkPlaceUrlStr parameters:dict success:^(id responseObject) {
       NSLog(@"%s,%d responseObject = %@",__FUNCTION__,__LINE__,responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%s,%d error = %@",__FUNCTION__,__LINE__,error);
    }];
}

@end
