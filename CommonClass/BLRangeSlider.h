//
//  BLRangeSlider.h
//  RangeSliderDemo
//
//  Created by luowailin on 2019/8/8.
//  Copyright © 2019 tomthorpe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BLRangeSlider;
@protocol BLRangeSliderDelegate <NSObject>

- (void)rangeSlider:(BLRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum;
@optional
- (void)rangeSlider:(BLRangeSlider *)sender updatebetweenCenterX:(float)centerX;

@end


@interface BLRangeSlider : UIControl

@property(nonatomic, assign) float minValue;
@property(nonatomic, assign) float maxValue;
@property(nonatomic, assign) float selectedMinimum;
@property(nonatomic, assign) float selectedMaximum;

@property(nonatomic, strong) UIColor *selectColor;

@property(nonatomic, weak) id<BLRangeSliderDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
