//
//  Queue_OC.m
//  CommonClass
//
//  Created by luowailin on 2019/12/9.
//  Copyright © 2019 blazer. All rights reserved.
//

#import "Queue_OC.h"

@interface Queue_OC ()

@property(nonatomic, strong) NSMutableArray *queues;
@property(nonatomic, assign) NSUInteger head;

@end

@implementation Queue_OC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.head = 0;
    }
    return self;
}

- (NSMutableArray *)queues{
    if (!_queues) {
        _queues = [NSMutableArray array];
    }
    return _queues;
}

- (NSUInteger)count{
    return self.queues.count;
}

- (BOOL)isEmpty{
    return self.queues.count == 0;
}

- (void)enqueue:(id)element{
    [self.queues addObject:element];
}

- (id)dequeue{
    if (self.head >= self.queues.count) {
        return nil;
    }
    
    id element = [self.queues objectAtIndex:self.head];
    if (element == nil) {
        return nil;
    }
    
    self.queues[self.head] = @"";
    self.head += 1;
    
    double percentage = (double)self.head / (double)self.queues.count;
    if (self.queues.count > 50 && percentage > 0.25) {
        [self.queues removeObjectsInRange:NSMakeRange(0, self.head)];
        self.head = 0;
    }
    return element;
}

- (id)front{
    if (self.queues.count == 0) {
        return nil;
    }
    return self.queues[self.head];
}

@end
