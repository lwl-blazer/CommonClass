//
//  BLVerticalSegmentControl.h
//  CommonClass
//
//  Created by luowailin on 2019/9/4.
//  Copyright © 2019 blazer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BLVerticalSegmentedControlTextAlignment){
    BLVerticalSegmentedControlTextAlignmentLeft,
    BLVerticalSegmentedControlTextAlignmentCenter,
    BLVerticalSegmentedControlTextAlignmentRight,
};

@interface BLVerticalSegmentControl : UIControl
@property(nonatomic, strong) UIColor *backgroundColor;
@property(nonatomic, strong) UIColor *itemSelectColor;
@property(nonatomic, strong) UIColor *roundSelectColor;
@property(nonatomic, strong) UIColor *textColor;
@property(nonatomic, strong) UIFont  *textFont;
@property(nonatomic, strong) UIColor *selectTextColor;

@property(nonatomic, assign) NSInteger selectSegmentIndex;

@property(nonatomic, copy) NSArray <NSString *>*sectionTitles;
@property(nonatomic, strong) NSMutableArray <NSNumber *>*selectContentIndex;
@property(nonatomic, assign) BLVerticalSegmentedControlTextAlignment textAlignment;

- (instancetype)initWithFrame:(CGRect)frame
                sectionTitles:(NSArray <NSString *>*)sectionTitles;

@end

NS_ASSUME_NONNULL_END
