//
//  SkUser.m
//  App
//
//  Created by 罗耀生 on 15/10/29.
//  Copyright © 2015年 罗耀生. All rights reserved.
//

#import "SkUser.h"

@implementation SkUser

+ (instancetype)sharedInstance
{
    NSString *className = [NSString stringWithFormat:@"%@", [self class] ];
    Class class = NSClassFromString( className );
    static dispatch_once_t once;
    static id singleton;
    dispatch_once(&once, ^ {
        singleton = [[class alloc] init];
    });
    return singleton;
}




@end
