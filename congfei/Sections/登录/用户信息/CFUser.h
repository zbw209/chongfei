//
//  CFUser.h
//  congfei
//
//  Created by 陈高磊 on 2016/12/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFUser : NSObject

#define userToken         @"userToken"

//创建单例
+(CFUser*)CFUser;
@end
