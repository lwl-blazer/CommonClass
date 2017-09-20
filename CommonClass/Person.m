
//
//  Person.m
//  CommonClass
//
//  Created by blazer on 2017/9/13.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)eat{
    NSLog(@"吃了");
    return self;
}

- (Person * (^)(int))run{
    return ^Person *(int m){
        NSLog(@"跑了%d米", m);
        return self;
    };
}

@end
