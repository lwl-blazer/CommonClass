
//
//  NSObject+Sum.m
//  CommonClass
//
//  Created by blazer on 2017/9/13.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import "NSObject+Sum.h"

@implementation NSObject (Sum)

- (int)bl_makeSum:(void (^)(SumManager *))block{
    SumManager *mgr = [[SumManager alloc] init];
    block(mgr);
    return mgr.result;
}

@end
