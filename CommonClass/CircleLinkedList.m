
//
//  CircleLinkedList.m
//  CommonClass
//
//  Created by luowailin on 2019/10/17.
//  Copyright © 2019 blazer. All rights reserved.
//

#import "CircleLinkedList.h"
#import "ListNode.h"

@implementation CircleLinkedList

#pragma mark -- ListDelegate
- (BOOL)contains:(nonnull id)element {
    return [self nodeWithElement:element] ? YES : NO;
}

- (NSUInteger)indexOfObject:(nonnull id)element {
    if (self.headNode == NULL) {
        return ELEMENT_NOT_FOUND;
    }
    
    NSUInteger index = 0;
    ListNode *node = self.headNode;
    while (node) {
        if ([node.element isEqual:element]) {
            return index;
        }
        node = node.nextNode;
        index ++;
    }
    return ELEMENT_NOT_FOUND;
}

- (void)insertObject:(nonnull id)element index:(NSUInteger)index {
    [self rangeCheckForAdd:index];
    if (self.size == index) {
        ListNode *newNode = [[ListNode alloc] initWithElement:element
                                                      preNode:self.lastNode
                                                     nextNode:self.headNode];
        if (self.lastNode == NULL) { //空链表
            self.headNode = newNode;
            self.lastNode = newNode;
        }
        self.lastNode.nextNode = newNode;
        self.headNode.preNode = newNode;
        self.lastNode = newNode;
    } else {
        ListNode *nextNode = [self nodeWithIndex:index];
        ListNode *preNode = nextNode.preNode;
        ListNode *newNode = [[ListNode alloc] initWithElement:element
                                                      preNode:preNode
                                                     nextNode:nextNode];
        if (preNode == NULL) {
            self.headNode = newNode;
        } else {
            preNode.nextNode = newNode;
        }
        nextNode.preNode = newNode;
    }
    self.size ++;
}

- (nullable id)objectAtIndex:(NSUInteger)index {
    [self rangeCheck:index];
    return [self nodeWithIndex:index].element;
}

- (void)removeObjectAtIndex:(NSUInteger)index{
    [self rangeCheck:index];
    
    ListNode *node = [self nodeWithIndex:index];
    if (node.preNode) {
        node.preNode.nextNode = node.nextNode;
    } else {
        self.headNode = node.nextNode;
    }
    
    if (node.nextNode) {
        node.nextNode.preNode = node.preNode;
    } else {
        self.lastNode = node.preNode;
    }
    self.size --;
}

- (void)removeObject:(nonnull id)element {
    ListNode *node = [self nodeWithElement:element];
    if (node == nil) {
        return;
    }
    
    if (node.preNode) {
        node.preNode.nextNode = node.nextNode;
    } else {
        self.headNode = node.nextNode;
    }
    
    if (node.nextNode) {
        node.nextNode.preNode = node.preNode;
    } else {
        self.lastNode = node.preNode;
    }
    self.size --;
}

- (ListNode *)nodeWithElement:(id)element{
    if (self.headNode == NULL) {
        return nil;
    }
    ListNode *node = self.headNode;
    while (node.nextNode) {
        if ([node.element isEqual:element]) {
            return node;
        }
        node = node.nextNode;
    }
    return node;
}

- (ListNode *)nodeWithIndex:(NSUInteger)index{
    ListNode *node = NULL;
    if (index < (self.size >> 1)) { //从头部开始查找
        node = self.headNode;
        for (NSUInteger i = 0; i < index; i ++) {
            node = node.nextNode;
        }
    } else { //从尾部开始查找
        node = self.lastNode;
        for (NSUInteger i = self.size - 1; i > index; i --) {
            node = node.preNode;
        }
    }
    return node;
}

#ifdef DEBUG
- (NSString *)description{
    NSMutableString *strM = [NSMutableString string];
    [strM appendFormat:@"[size=%ld,", self.size];
    ListNode *node = self.headNode;
    for (NSUInteger i = 0; i < self.size; i ++) {
        if (i == self.size - 1) {
            [strM appendFormat:@"%@_%@]", node.nextNode.element, node.element];
        } else {
            [strM appendFormat:@"%@_%@,", node.nextNode.element, node.element];
        }
        node = node.nextNode;
    }
    
    return strM.copy;
}



- (void)dealloc{
    NSLog(@"%s", __func__);
}
#endif


@end
