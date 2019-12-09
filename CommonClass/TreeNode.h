//
//  TreeNode.h
//  CommonClass
//
//  Created by luowailin on 2019/12/6.
//  Copyright © 2019 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//树的节点
@interface TreeNode : NSObject

@property(nonatomic, strong) id element;
@property(nonatomic, strong) TreeNode *left;
@property(nonatomic, strong) TreeNode *right;
@property(nonatomic, strong) TreeNode *parent;

- (instancetype)initWithEelement:(id)element parent:(nullable TreeNode *)parent;

@end

NS_ASSUME_NONNULL_END
