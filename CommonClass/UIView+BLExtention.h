//
//  UIView+BLExtention.h
//  CommonClass
//
//  Created by blazer on 2017/11/4.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BLExtention)

#pragma mark - 快速设置控件的frame
@property (nonatomic, assign) CGFloat origin_x;
@property (nonatomic, assign) CGFloat origin_y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat size_width;
@property (nonatomic, assign) CGFloat size_height;
@property (nonatomic, assign) CGPoint frame_origin;
@property (nonatomic, assign) CGSize  frame_size;
@property (nonatomic, assign) CGFloat frame_right;
@property (nonatomic, assign) CGFloat frame_bottom;

@end
