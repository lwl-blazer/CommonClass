//
//  LabelLayer.m
//  TextKitDemo
//
//  Created by blazer on 2018/9/20.
//  Copyright © 2018年 blazer. All rights reserved.
//

#import "LabelLayer.h"

@interface LabelLayer() <CALayerDelegate>
@end

@implementation LabelLayer

+ (Class)layerClass{
    return [CATextLayer class];
}

- (CATextLayer *)textLayer{
    return (CATextLayer *)self.layer;
}


- (void)setUp{
    self.text = self.text;
    self.textColor = self.textColor;
    self.font = self.font;
    
    [self textLayer].wrapped = YES;
    [self.layer display];
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUp];
}

- (void)setText:(NSString *)text{
    super.text = text;
    
    [self textLayer].string = text;
}

- (void)setTextColor:(UIColor *)textColor{
    super.textColor = textColor;
    [self textLayer].foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font{
    super.font = font;
    
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    
    CGFontRelease(fontRef);
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    super.backgroundColor = backgroundColor;
    [self textLayer].backgroundColor = backgroundColor.CGColor;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    super.textAlignment = textAlignment;
    NSString *str = nil;
    switch (textAlignment) {
        case NSTextAlignmentLeft:
            str = kCAAlignmentLeft;
            break;
        case NSTextAlignmentRight:
            str = kCAAlignmentRight;
            break;
        case NSTextAlignmentCenter:
            str = kCAAlignmentCenter;
            break;
        case NSTextAlignmentNatural:
            str = kCAAlignmentNatural;
            break;
        case NSTextAlignmentJustified:
            str = kCAAlignmentJustified;
            break;
        default:
            break;
    }
    [self textLayer].alignmentMode = str;
}


- (void)layoutSublayersOfLayer:(CALayer *)layer{
    NSLog(@"%@", NSStringFromCGRect(layer.frame));
}

@end
