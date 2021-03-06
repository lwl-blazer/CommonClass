//
//  UIImage+Extension.h
//  CommonClass
//
//  Created by blazer on 2017/8/25.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CommonExtension)

//切圆角
- (UIImage *)circleImage;

//根据颜色返回图片
+ (instancetype)bl_imageWithColor:(UIColor *)color;

@end
