//
//  NSObject+Sum.h
//  CommonClass
//
//  Created by blazer on 2017/9/13.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SumManager.h"


@interface NSObject (Sum)

//将所有计算的代码放block里面
- (int)bl_makeSum:(void(^)(SumManager *manager))block;

@end
