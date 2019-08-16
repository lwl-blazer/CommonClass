//
//  HotelDetailFilterItemLayout.m
//  CommonClass
//
//  Created by blazer on 2019/8/16.
//  Copyright © 2019 blazer. All rights reserved.
//

#import "HotelDetailFilterItemLayout.h"

@interface HotelDetailFilterItemLayout ()

@property(nonatomic, strong) NSMutableArray *indexPathsToAnimate;

@end

@implementation HotelDetailFilterItemLayout

- (void)prepareLayout{
    [super prepareLayout];
    NSLog(@"%s", __func__);
}

/***通知layout 哪些内容将会发生改变 */
- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems{
    [super prepareForCollectionViewUpdates:updateItems];
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (UICollectionViewUpdateItem *updateItem in updateItems) {
        switch (updateItem.updateAction) {
            case UICollectionUpdateActionInsert:
                [indexPaths addObject:updateItem.indexPathAfterUpdate];
                break;
                case UICollectionUpdateActionDelete:
                [indexPaths addObject:updateItem.indexPathBeforeUpdate];
                break;
                case UICollectionUpdateActionMove:
                [indexPaths addObject:updateItem.indexPathBeforeUpdate];
                [indexPaths addObject:updateItem.indexPathAfterUpdate];
                break;
                case UICollectionUpdateActionReload:
//                [indexPaths addObject:updateItem.indexPathBeforeUpdate];
//                [indexPaths addObject:updateItem.indexPathAfterUpdate];
                break;
            default:
                NSLog(@"unhandled case: %@", updateItem);
                break;
        }
    }
    
    self.indexPathsToAnimate = indexPaths;
    NSLog(@"%s----%@", __func__, indexPaths);
}

/**获取更新以后的布局信息*/
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    NSLog(@"%s", __func__);
    return attrs;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s", __func__);
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

/**刚出现时最初布局属性*/
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    
    if ([self.indexPathsToAnimate containsObject:itemIndexPath]) {
        attr.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), M_PI);
        attr.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMaxY(self.collectionView.bounds));
        [_indexPathsToAnimate removeObject:itemIndexPath];
    }
    
    NSLog(@"%s", __func__);
    return attr;
}

/**消失时最终布局属性*/
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    NSLog(@"%s", __func__);
    return attr;
}

/**最后，等这一系列动画执行完之后*/
- (void)finalizeCollectionViewUpdates{
    [super finalizeCollectionViewUpdates];
    NSLog(@"%s", __func__);
}

- (void)prepareForAnimatedBoundsChange:(CGRect)oldBounds{
    [super prepareForAnimatedBoundsChange:oldBounds];
    NSLog(@"%s", __func__);
}

- (void)finalizeAnimatedBoundsChange{
    [super finalizeAnimatedBoundsChange];
    NSLog(@"%s", __func__);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    NSLog(@"%s", __func__);
    return NO;
}


@end
