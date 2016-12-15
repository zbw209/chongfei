//
//  SkUser.h
//  App
//
//  Created by 罗耀生 on 15/10/29.
//  Copyright © 2015年 罗耀生. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SkObject.h"


@interface SkUser : SkObject<NSCoding>

/**
 *  用户名
 */
@property (nonatomic, strong) NSString *userToken;




@end
