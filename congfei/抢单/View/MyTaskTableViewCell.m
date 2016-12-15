//
//  MyTaskTableViewCell.m
//  congfei
//
//  Created by 陈高磊 on 2016/11/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyTaskTableViewCell.h"

@implementation MyTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.senderMessageBtn.layer.cornerRadius = 5;
    self.senderMessageBtn.layer.masksToBounds = YES;
    self.senderMessageBtn.layer.borderWidth = 1;
    self.senderMessageBtn.layer.borderColor = kThemeColor.CGColor;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
