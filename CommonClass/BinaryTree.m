//
//  BinaryTree.m
//  CommonClass
//
//  Created by luowailin on 2019/12/6.
//  Copyright © 2019 blazer. All rights reserved.
//

#import "BinaryTree.h"
#import "TreeNode.h"

@interface BinaryTree ()

@property(nonatomic, copy) void (^usingBlock)(id object);

@end

@implementation BinaryTree

- (void)preorderTraversalUsingBlock:(void (^)(id _Nonnull))block{
    self.usingBlock = block;
    [self preorderTraversalNode:self.root];
    self.usingBlock = nil;
}

- (void)preorderTraversalNode:(TreeNode *)node{
    if (node == nil) {
        return;
    }
    if (self.usingBlock) {
        self.usingBlock(node.element);
    }
    [self preorderTraversalNode:node.left];
    [self preorderTraversalNode:node.right];
}

- (void)inorderTraversalUsingBlock:(void (^)(id _Nonnull))block{
    self.usingBlock = block;
    [self inorderTraversalNode:self.root];
    self.usingBlock = nil;
}

- (void)inorderTraversalNode:(TreeNode *)node{
    if (node == nil) {
        return;
    }
    
    [self inorderTraversalNode:node.left];
    if (self.usingBlock) {
        self.usingBlock(node.element);
    }
    [self inorderTraversalNode:node.right];
}

- (void)postorderTraversalUsingBlock:(void (^)(id _Nonnull))block{
    self.usingBlock = block;
    [self postorderTraversalNode:self.root];
    self.usingBlock = nil;
}

- (void)postorderTraversalNode:(TreeNode *)node{
    if (node == nil) {
        return;
    }
    
    [self postorderTraversalNode:node.left];
    [self postorderTraversalNode:node.right];
    if (self.usingBlock) {
        self.usingBlock(node.element);
    }
}


- (void)levelOrderTraversalUsingBlock:(void (^)(id _Nonnull))block{
    
}

@end
