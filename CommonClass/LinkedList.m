//
//  LinkedList.m
//  CommonClass
//
//  Created by luowailin on 2019/10/12.
//  Copyright © 2019 blazer. All rights reserved.
//

#import "LinkedList.h"
#import "ListNode.h"

@implementation LinkedList

#pragma mark -- ListDelegate
- (void)clear {
    
}

- (BOOL)contains:(nonnull id)element {
    return NO;
}

- (NSUInteger)indexOfObject:(nonnull id)element {
    return ELEMENT_NOT_FOUND;
}

- (void)insertObject:(nonnull id)element index:(NSUInteger)index {
    [self rangeCheckForAdd:index];
    
    if (self.headNode == NULL) { //空链表
        ListNode *newNode = [[ListNode alloc] initWithElement:element
                                                      preNode:NULL
                                                     nextNode:NULL];
        self.headNode = newNode;
        self.lastNode = newNode;
    } else {
        ListNode *node = [self nodeWithIndex:index];
        ListNode *newNode = [[ListNode alloc] initWithElement:element
                                                      preNode:node.preNode
                                                     nextNode:node];
        if (node.preNode == NULL) { //头节点
            self.headNode = newNode;
        } else {
            node.preNode.nextNode = newNode;
        }
        node.preNode = newNode;
    }
    self.size ++;
}

- (nullable id)objectAtIndex:(NSUInteger)index {
    return nil;
}

- (void)removeObject:(nonnull id)element {
    
}

- (ListNode *)nodeWithIndex:(NSUInteger)index{
    ListNode *node = NULL;
    if (index < self.size / 2.0) { //从头部开始查找
        node = self.headNode;
        for (NSUInteger i = 0; i < self.size; i ++) {
            if (i == index) {
                break;
            }
            node = node.nextNode;
        }
    } else { //从尾部开始查找
        node = self.lastNode;
        for (NSUInteger i = self.size - 1; i > 0; i --) {
            if (i == index) {
                break;
            }
            node = node.preNode;
        }
    }
    return node;
}


@end
