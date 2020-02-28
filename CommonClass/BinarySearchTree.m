//
//  BinaryTree.m
//  CommonClass
//
//  Created by luowailin on 2019/11/26.
//  Copyright © 2019 blazer. All rights reserved.
//

#import "BinarySearchTree.h"
#import "TreeNode.h"

@interface BinarySearchTree ()

@property(nonatomic, copy) NSComparisonResult (^compareBlock)(id _Nonnull e1, id _Nonnull e2);

@end

@implementation BinarySearchTree

- (instancetype)initWithCompareBlock:(NSComparisonResult (^)(id _Nonnull, id _Nonnull))compareBlock{
    self = [super init];
    if (self) {
        self.compareBlock = compareBlock;
    }
    return self;
}

- (BOOL)isEmpty{
    return self.size == 0;
}
 
- (void)clear{
    
}

- (void)add:(id)element{
    if (element == nil) {
        return;
    }
    
    if (self.root == nil) {
        self.root = [[TreeNode alloc] initWithEelement:element parent:nil];
        self.size ++;
        return;
    }
    
    TreeNode *node = self.root;
    TreeNode *parent = self.root;
    NSComparisonResult result = NSOrderedAscending;
    
    while (node != nil) {
        parent = node;
        result = [self compare:element to:node.element];
        switch (result) {
            case NSOrderedDescending:
                node = node.right;
                break;
            case NSOrderedAscending:
                node = node.left;
                break;
            default:
                return;
        }
    }
    
    TreeNode *newNode = [[TreeNode alloc] initWithEelement:element
                                            parent:parent];
    if (result == NSOrderedDescending) {
        parent.right = newNode;
    } else {
        parent.left = newNode;
    }
    self.size ++;
    
    NSArray *arr;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
}

/*
 NSOrderedAscending = -1L, e1小于e2
 NSOrderedSame = 0, 相等
 NSOrderedDescending = 1 e1大于e2
 */
- (NSComparisonResult)compare:(id)e1 to:(id)e2{
    
    if (self.compareBlock) {
        return self.compareBlock(e1, e2);
    }
    
    return [e1 compare:e2];
}

@end
