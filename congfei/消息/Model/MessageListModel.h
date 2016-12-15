//
//  MessageListModel.h
//  congfei
//
//  Created by 陈高磊 on 2016/12/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageListModel : NSObject

@property (nonatomic, copy) NSString *cUserId;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *dateFormat;
@property (nonatomic, copy) NSString *gmtCreate;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *unReadCount;//可读个数
@end
