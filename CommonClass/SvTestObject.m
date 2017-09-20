


//
//  SvTestObject.m
//  CommonClass
//
//  Created by blazer on 2017/8/31.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import "SvTestObject.h"

@implementation SvTestObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"instance %@ has been created!", self);
    }
    return self;
}

- (void)timerAction:(NSTimer *)timer{
    NSLog(@"Hi, Timer Action for instance %@", self);
}

- (void)dealloc{
    NSLog(@"instance %@ has been dealloced" , self);
//    [super dealloc];
}

@end
