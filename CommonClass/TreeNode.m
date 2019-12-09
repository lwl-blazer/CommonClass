//
//  TreeNode.m
//  CommonClass
//
//  Created by luowailin on 2019/12/6.
//  Copyright © 2019 blazer. All rights reserved.
//

#import "TreeNode.h"

@implementation TreeNode

- (instancetype)initWithEelement:(id)element parent:(TreeNode *)parent{
    self = [super init];
    if (self) {
        self.element = element;
        self.parent = parent;
    }
    return self;
}

@end
