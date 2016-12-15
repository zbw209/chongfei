//
//  SkUserDefaults.m
//  App
//
//  Created by 罗耀生 on 15/10/29.
//  Copyright © 2015年 罗耀生. All rights reserved.
//

#import "SkUserDefaults.h"

@implementation SkUserDefaults

+ (void)writeIsLogin:(BOOL)pIsLogin
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSNumber numberWithInteger:pIsLogin] forKey:@"isLogin"];
    if (pIsLogin==false) {
              
        
      
        [SkUser sharedInstance].userToken = nil;
        [SkUserDefaults writeObject:[SkUser sharedInstance] ];

    }
    

    [userDefault synchronize];
}
+ (BOOL)readIsLogin
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [[userDefault objectForKey:@"isLogin"] boolValue];
}

//是否开启审核
+ (void)writeIsCheck:(BOOL)pIsCheck
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSNumber numberWithInteger:pIsCheck] forKey:@"isCheck"];
    [userDefault synchronize];
}
+ (BOOL)readIsCheck
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [[userDefault objectForKey:@"isCheck"] boolValue];
}

+ (void)writeObject:(SkObject *)pObject
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:pObject];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:data forKey: [[pObject class] description] ];
    
}

+ (SkObject *)readObject:(NSString *)pObjectName
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey: pObjectName ];
    return nil==data?nil:[NSKeyedUnarchiver unarchiveObjectWithData:data];
}
+ (SkSet *)readSet
{
    return (SkSet *)[SkUserDefaults readObject:@"SkSet"];
}

+ (SkUser *)readUser
{
    return (SkUser *)[SkUserDefaults readObject:@"SkUser"];
}

+ (SkPublicConfig *)readPublicConfig
{
    return (SkPublicConfig *)[SkUserDefaults readObject:@"SkPublicConfig"];
}
//+ (void)reloadLogin{
//    UIAlertView* lert = [[UIAlertView alloc]initWithTitle:nil message:@"账号已过期，请重新登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我知道了",nil];
//    [SkUserDefaults writeIsLogin:NO];
//    [lert show];
//}

@end
