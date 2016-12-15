//
//  SkSet.h
//  App
//
//  Created by 罗耀生 on 15/10/29.
//  Copyright © 2015年 罗耀生. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SkObject.h"

@interface SkSet : SkObject<NSCoding>

@property (nonatomic, strong) NSNumber *isWarn_new;             //新消息提醒
@property (nonatomic, strong) NSNumber *isWarn_ring;            //铃声提醒
@property (nonatomic, strong) NSNumber *isWarn_vibration;       //震动提醒
@property (nonatomic, strong) NSNumber *isAutoLogin;            //自动密码登录

//登录后参数，待定……
@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *expires_in;
@property (nonatomic, strong) NSString *refresh_token;

@end
