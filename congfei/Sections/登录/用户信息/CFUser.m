//
//  CFUser.m
//  congfei
//
//  Created by 陈高磊 on 2016/12/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CFUser.h"
static CFUser *singleton = nil;
@implementation CFUser
+(CFUser*)CFUser {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[CFUser alloc] init];
    });
    return singleton;
}



@end
