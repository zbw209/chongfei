//
//  SkPublicConfig.h
//  App
//
//  Created by 罗耀生 on 15/10/29.
//  Copyright © 2015年 罗耀生. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SkObject.h"

@interface SkPublicConfig : SkObject<NSCoding>

@property (nonatomic, strong) NSArray       *downloads;
@property (nonatomic, strong) NSString      *file_domain;
@property (nonatomic, strong) NSString      *name;
@property (nonatomic, strong) NSString      *note;
@property (nonatomic, strong) NSDictionary  *start_image;
@property (nonatomic, strong) NSString      *url;
@property (nonatomic, strong) NSString      *ver;

@end
