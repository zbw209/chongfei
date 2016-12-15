//
//  MessageDetailViewController.m
//  congfei
//
//  Created by 陈高磊 on 2016/12/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "MessageListModel.h"
@interface MessageDetailViewController ()
@property (nonatomic, strong) NSMutableArray *dataAry;

@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

- (NSMutableArray *)dataAry {
    if (!_dataAry) {
        self.dataAry = [NSMutableArray array];
    }
    return _dataAry;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getData {
    NSString *url = [NSString stringWithFormat:@"%@%@", kMainURL,kMessageDetail];
   
    NSDictionary *dic = @{@"token": [SkUser sharedInstance].userToken,@"cUserId":self.messageID};
    
    [[HttpRequest sharedInstance] postWithURLString:url parameters:dic success:^(id responseObject) {
        NSLog(@"%@", responseObject);
        
        
        
    } failure:^(NSError *error) {
        
    }];

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
