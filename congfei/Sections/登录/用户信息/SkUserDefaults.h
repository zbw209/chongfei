//
//  SkUserDefaults.h
//  App
//
//  Created by 罗耀生 on 15/10/29.
//  Copyright © 2015年 罗耀生. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SkSet.h"
#import "SkUser.h"
#import "SkPublicConfig.h"

@interface SkUserDefaults : NSObject<UIAlertViewDelegate>

+ (void)writeIsLogin:(BOOL)pIsLogin;
+ (BOOL)readIsLogin;

//是否开启审核
+ (void)writeIsCheck:(BOOL)pIsCheck;
+ (BOOL)readIsCheck;

+ (void)writeObject:(SkObject *)pObject;

+ (SkSet *)readSet;
+ (SkUser *)readUser;
+ (SkPublicConfig *)readPublicConfig;

@end
