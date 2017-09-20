//
//  SumManager.h
//  CommonClass
//
//  Created by blazer on 2017/9/13.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SumManager : NSObject

@property(nonatomic, assign) int result;

- (SumManager *(^)(int))add;

@end
