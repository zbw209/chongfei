//
//  MessageTableViewCell.h
//  congfei
//
//  Created by 陈高磊 on 2016/11/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageListModel.h"
@interface MessageTableViewCell : UITableViewCell
@property (nonatomic, strong) MessageListModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *tittleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end
