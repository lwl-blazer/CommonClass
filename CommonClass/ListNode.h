//
//  ListNode.h
//  CommonClass
//
//  Created by luowailin on 2019/10/12.
//  Copyright © 2019 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListNode : NSObject

@property(nonatomic, strong)  id element;
@property(nonatomic, strong, nullable) ListNode *preNode;
@property(nonatomic, strong, nullable) ListNode *nextNode;

- (instancetype)initWithElement:(nonnull id)element
                        preNode:(nullable ListNode *)preNode
                       nextNode:(nullable ListNode *)nextNode;

@end

NS_ASSUME_NONNULL_END
