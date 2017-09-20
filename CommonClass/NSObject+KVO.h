//
//  NSObject+KVO.h
//  CommonClass
//
//  Created by blazer on 2017/9/13.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVO)

-(void)bl_addObserver:(NSObject *_Nullable)observer forKeyPath:(NSString *_Nullable)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end
