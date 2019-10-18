//
//  AbstractList.m
//  CommonClass
//
//  Created by luowailin on 2019/10/12.
//  Copyright © 2019 blazer. All rights reserved.
//

#import "AbstractList.h"
#import "ListNode.h"

@implementation AbstractList

@synthesize size = _size;
#pragma mark -- ListDelegate
- (void)addObject:(nonnull id)element {
    [self insertObject:element index:self.size];
}

- (BOOL)isEmpty {
    return self.size == 0;
}

- (void)clear {
    ListNode *node = self.headNode;
    ListNode *tmp = node.nextNode;
    for (NSUInteger i = 0; i < self.size; i ++) {
        node.preNode = nil;
        node.nextNode = nil;
        node = tmp;
        tmp = tmp.nextNode;
    }
    self.size = 0;
    self.headNode = NULL;
    self.lastNode = NULL;
}

- (BOOL)contains:(nonnull id)element {
    return NO;
}

- (NSUInteger)indexOfObject:(nonnull id)element {
    return ELEMENT_NOT_FOUND;
}

- (void)insertObject:(nonnull id)element index:(NSUInteger)index {
    
}

- (nullable id)objectAtIndex:(NSUInteger)index {
    return nil;
}

- (void)removeObject:(nonnull id)element {
    
}

- (void)removeObjectAtIndex:(NSUInteger)index{
    
}

#pragma mark -- public method
- (void)rangeCheck:(NSUInteger)index{
    if (index >= self.size) { //这里是unsign所以不需要做小于0的判断
        [self outOfBounds:index];
    }
}

- (void)rangeCheckForAdd:(NSUInteger)index{
    if (index > self.size) { //这里是unsign所以不需要做小于0的判断
        [self outOfBounds:index];
    }
}

#pragma mark -- private method
- (void)outOfBounds:(NSUInteger)index{
    @throw [[NSException alloc] initWithName:@"NSRangeException" reason:[NSString stringWithFormat:@"index %ld beyond bounds %ld", index, self.size - 1] userInfo:nil];
}

@end
