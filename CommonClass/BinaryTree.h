//
//  BinaryTree.h
//  CommonClass
//
//  Created by luowailin on 2019/12/6.
//  Copyright © 2019 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class TreeNode;
@interface BinaryTree : NSObject

@property(nonatomic, assign) NSUInteger size;
@property(nonatomic, strong) TreeNode *root;

/**
 * 前序遍历 先根节点(再左子树再右子树)
 */
- (void)preorderTraversalUsingBlock:(void(^)(id object))block;

/**
 * 中序遍历 先左子树 再根节点 再右子树
 */
- (void)inorderTraversalUsingBlock:(void(^)(id object))block;

/**
 * 后序遍历 先左子树 再右子树 后根节点
 */
- (void)postorderTraversalUsingBlock:(void(^)(id object))block;

/**
 * 层序遍历
 */
- (void)levelOrderTraversalUsingBlock:(void(^)(id object))block;

@end

NS_ASSUME_NONNULL_END
