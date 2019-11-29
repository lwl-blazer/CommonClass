//
//  BinaryTree.h
//  CommonClass
//
//  Created by luowailin on 2019/11/26.
//  Copyright © 2019 blazer. All rights reserved.
//
// 二叉搜索树

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BinarySearchTree : NSObject

@property(nonatomic, assign, readonly) NSUInteger size;
/**
 * 关于element的约束
 * 1.实现block方法
 * 或者2.element实现compare方法 返回的类型为NSComparisonResult
 */
- (instancetype)initWithCompareBlock:(NSComparisonResult(^)(id element1, id element2))compareBlock;

- (BOOL)isEmpty;
- (void)clear;
- (void)add:(id)element;

@end

NS_ASSUME_NONNULL_END
