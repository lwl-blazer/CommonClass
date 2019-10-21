//
//  CircleLinkedList.h
//  CommonClass
//
//  Created by luowailin on 2019/10/17.
//  Copyright © 2019 blazer. All rights reserved.
//

#import "AbstractList.h"

NS_ASSUME_NONNULL_BEGIN

@interface CircleLinkedList : AbstractList

@property(nonatomic, weak, readonly) ListNode *currentNode;

- (void)currentNodeNext;
- (void)removeCurrentNodel;


@end

NS_ASSUME_NONNULL_END
