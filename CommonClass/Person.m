
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

- (instancetype)initWithAge:(NSInteger)age
{
    self = [super init];
    if (self) {
        self.age = age;
    }
    return self;
}

- (NSComparisonResult)compare:(Person *)other{
    if (self.age > other.age) {
        return NSOrderedDescending;
    }
    
    if (self.age < other.age) {
        return NSOrderedAscending;
    }
    
    return NSOrderedSame;
}


@end
