//
//  Queue_OC.h
//  CommonClass
//
//  Created by luowailin on 2019/12/9.
//  Copyright © 2019 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>
//险
NS_ASSUME_NONNULL_BEGIN

@interface Queue_OC : NSObject

@property(nonatomic, assign, readonly) NSUInteger count;

- (BOOL)isEmpty;
- (void)enqueue:(id)element;
- (id)dequeue;
- (id)front;

@end

NS_ASSUME_NONNULL_END
