

//
//  UITableView+Placeholder.m
//  MorSearchProject
//
//  Created by morsearch on 2017/11/30.
//  Copyright © 2017年 morsearch. All rights reserved.
//

#import "UITableView+Placeholder.h"
#import <objc/runtime.h>

@implementation NSObject (swizzle)

+ (void)swizzleInstanceSelectector:(SEL)originalSel
              withSwizzledSelector:(SEL)swizzledSel{
    Method originMethod = class_getInstanceMethod(self, originalSel);
    Method swizzedMethod = class_getInstanceMethod(self, swizzledSel);
    
    BOOL methodAdded = class_addMethod(self, originalSel, method_getImplementation(swizzedMethod), method_getTypeEncoding(originMethod));
    
    if (methodAdded) {
        class_replaceMethod(self, swizzledSel, method_getImplementation(swizzedMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzedMethod);
    }
}

@end

@implementation UITableView (Placeholder)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceSelectector:@selector(reloadData) withSwizzledSelector:@selector(bl_reloadData)];
    });
}

- (void)setPlaceHolderView:(UIView *)placeHolderView{
    objc_setAssociatedObject(self, @selector(placeHolderView), placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)placeHolderView{
    return objc_getAssociatedObject(self, @selector(placeHolderView));
}

- (void)bl_reloadData{
    [self bl_checkEmpty];
    [self bl_reloadData];
}

- (void)bl_checkEmpty{
    BOOL isEmpty = YES;
    id<UITableViewDataSource>src = self.dataSource;
    NSInteger sections = 1;
    
    if ([src respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [src numberOfSectionsInTableView:self];
    }
    
    for (int i = 0; i < sections; i ++) {
        NSInteger rows = [src tableView:self numberOfRowsInSection:i];
        if (rows) {
            isEmpty = NO;
        }
    }
    
    if (isEmpty ) {
        [self.placeHolderView removeFromSuperview];
        [self addSubview:self.placeHolderView];
    }else{
        [self.placeHolderView removeFromSuperview];
    }
}



@end
