//
//  WorkPlaceModel.h
//  congfei
//
//  Created by 周必稳 on 2016/12/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkPlaceModel : NSObject
@property (nonatomic, strong) NSString *auserId;
@property (nonatomic, strong) NSString *workplaceId;
@property (nonatomic, strong) NSString *workNum;
@property (nonatomic, strong) NSString *serviceFee;
@property (nonatomic, strong) NSString *supperName;
@property (nonatomic, strong) NSString *supperTel;
@property (nonatomic, strong) NSString *creator;
@property (nonatomic, strong) NSString *gmtCreate;
@property (nonatomic, strong) NSString *modifier;
@property (nonatomic, strong) NSString *gmtModified;
@property (nonatomic, strong) NSString *_default;

@end
