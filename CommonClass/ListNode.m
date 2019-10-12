//
//  ListNode.m
//  CommonClass
//
//  Created by luowailin on 2019/10/12.
//  Copyright © 2019 blazer. All rights reserved.
//

#import "ListNode.h"

@implementation ListNode

- (instancetype)initWithElement:(id)element
                        preNode:(ListNode *)preNode
                       nextNode:(ListNode *)nextNode
{
    self = [super init];
    if (self) {
        self.element = element;
        self.preNode = preNode;
        self.nextNode = nextNode;
    }
    return self;
}

@end
