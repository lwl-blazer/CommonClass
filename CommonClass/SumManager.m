
//
//  SumManager.m
//  CommonClass
//
//  Created by blazer on 2017/9/13.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import "SumManager.h"

@implementation SumManager

- (SumManager * (^)(int))add{
    return ^SumManager *(int value){
        _result += value;
        return self;
    };
}



@end
