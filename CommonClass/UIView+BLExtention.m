//
//  UIView+BLExtention.m
//  CommonClass
//
//  Created by blazer on 2017/11/4.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import "UIView+BLExtention.h"

@implementation UIView (BLExtention)

#pragma mark ---- Setter and Getter ----

- (void)setOrigin_x:(CGFloat)origin_x{
    CGRect frame = self.frame;
    frame.origin.x = origin_x;
    self.frame = frame;
}

- (CGFloat)origin_x{
    return self.frame.origin.x;
}

- (void)setOrigin_y:(CGFloat)origin_y{
    CGRect frame = self.frame;
    frame.origin.y = origin_y;
    self.frame = frame;
}

- (CGFloat)origin_y{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setSize_width:(CGFloat)size_width{
    CGRect frame = self.frame;
    frame.size.width = size_width;
    self.frame = frame;
}

- (CGFloat)size_width{
    return self.frame.size.width;
}


- (void)setSize_height:(CGFloat)size_height{
    CGRect frame = self.frame;
    frame.size.height = size_height;
    self.frame = frame;
}

- (CGFloat)size_height{
    return self.frame.size.height;
}

- (void)setFrame_size:(CGSize)frame_size{
    CGRect frame = self.frame;
    frame.size = frame_size;
    self.frame = frame;
}

- (CGSize)frame_size{
    return self.frame.size;
}


- (void)setFrame_right:(CGFloat)frame_right{
    CGRect frame = self.frame;
    frame.origin.x = frame_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)frame_right{
     return self.frame.origin.x + self.frame.size.width;
}

- (void)setFrame_bottom:(CGFloat)frame_bottom {
    CGRect frame = self.frame;
    frame.origin.y = frame_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)frame_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

@end
