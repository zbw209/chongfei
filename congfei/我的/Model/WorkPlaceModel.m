//
//  WorkPlaceModel.m
//  congfei
//
//  Created by 周必稳 on 2016/12/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WorkPlaceModel.h"

@implementation WorkPlaceModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"default"]) {
        self._default = value;
    }
}
@end
