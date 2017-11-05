//
//  UIImage+Extension.m
//  CommonClass
//
//  Created by blazer on 2017/8/25.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import "UIImage+CommonExtension.h"

@implementation UIImage (CommonExtension)

- (UIImage *)circleImage{
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //设置一个范围
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    //根据一个Rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, rect);
    //裁剪
    CGContextClip(ctx);
    //将原照片画到图形上下文
    [self drawInRect:rect];
    //获得新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (instancetype)bl_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
