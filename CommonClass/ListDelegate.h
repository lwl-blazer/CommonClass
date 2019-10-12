//
//  ListDelegate.h
//  CommonClass
//
//  Created by luowailin on 2019/10/12.
//  Copyright © 2019 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static const NSUInteger ELEMENT_NOT_FOUND = -1;

@protocol ListDelegate <NSObject>

@property(nonatomic, assign) NSUInteger size;

- (void)clear;
- (void)addObject:(nonnull id)element;
- (void)insertObject:(nonnull id)element index:(NSUInteger)index;
- (void)removeObject:(id)element;

- (BOOL)isEmpty;
- (BOOL)contains:(nonnull id)element;
- (nullable id)objectAtIndex:(NSUInteger)index;

- (NSUInteger)indexOfObject:(nonnull id)element;

@end

NS_ASSUME_NONNULL_END
