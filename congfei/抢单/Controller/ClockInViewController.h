//
//  ClockInViewController.h
//  congfei
//
//  Created by 陈高磊 on 2016/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClockInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *customView;
@property (nonatomic, copy) NSString *lonlatStr;
@property (nonatomic, copy) NSString *workPlaceID;
@end
