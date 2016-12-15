//
//  SkSet.m
//  App
//
//  Created by 罗耀生 on 15/10/29.
//  Copyright © 2015年 罗耀生. All rights reserved.
//

#import "SkSet.h"

@implementation SkSet

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

- (id)init
{
    self = [super init];
    if (self) {
        
        //默认所有都开启
        _isWarn_new = [NSNumber numberWithBool:YES];
        _isWarn_ring = [NSNumber numberWithBool:YES];
        _isWarn_vibration = [NSNumber numberWithBool:YES];
        _isAutoLogin = [NSNumber numberWithBool:YES];
    }
    return self;
}

@end