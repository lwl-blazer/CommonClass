//
//  AbstractList.h
//  CommonClass
//
//  Created by luowailin on 2019/10/12.
//  Copyright © 2019 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListDelegate.h"

NS_ASSUME_NONNULL_BEGIN
@class ListNode;
@interface AbstractList : NSObject<ListDelegate>

@property(nonatomic, strong) ListNode *headNode;
@property(nonatomic, strong) ListNode *lastNode;

- (void)rangeCheck:(NSUInteger)index;
- (void)rangeCheckForAdd:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
