
//
//  NSString+BLCommonExtention.m
//  CommonClass
//
//  Created by blazer on 2017/11/5.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import "NSString+BLCommonExtention.h"
#import "sys/utsname.h"


@implementation NSString (BLCommonExtention)

- (CGSize)bl_sizeWithSystemFont:(UIFont *)font constrainedToSize:(CGSize)size {
    return [self bl_sizeWithSystemFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
}

#pragma mark - 文本计算方法
- (CGSize)bl_sizeWithSystemFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = mode;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary *attributes = @{NSFontAttributeName : font,
                                 NSParagraphStyleAttributeName : paragraphStyle};
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return CGSizeMake(ceil(rect.size.width), ceil(rect.size.height));
}


//设备
NSString *const iPhone6_6s_7 = @"iPhone6_6s_7";
NSString *const iPhone6_6s_7Plus = @"iPhone6_6s_7Plus";

+ (instancetype)bl_deviceType {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    // iPhone
    if ([deviceString isEqualToString:@"iPhone7,1"])    return iPhone6_6s_7Plus;
    if ([deviceString isEqualToString:@"iPhone7,2"])    return iPhone6_6s_7;
    if ([deviceString isEqualToString:@"iPhone8,1"])    return iPhone6_6s_7;
    if ([deviceString isEqualToString:@"iPhone8,2"])    return iPhone6_6s_7Plus;
    if ([deviceString isEqualToString:@"iPhone9,1"])    return iPhone6_6s_7;
    if ([deviceString isEqualToString:@"iPhone9,2"])    return iPhone6_6s_7Plus;
    if ([deviceString isEqualToString:@"iPhone9,3"])    return iPhone6_6s_7;
    if ([deviceString isEqualToString:@"iPhone9,4"])    return iPhone6_6s_7Plus;
    
    return deviceString;
}
@end
