//
//  MessageTableViewCell.m
//  congfei
//
//  Created by 陈高磊 on 2016/11/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(MessageListModel *)model {
    self.tittleLabel.text = model.title;
    self.contentLabel.text = model.content;
    self.timeLabel.text = model.dateFormat;
    self.countLabel.text = model.unReadCount;
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:model.icon]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
