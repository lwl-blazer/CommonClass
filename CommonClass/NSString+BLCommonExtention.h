//
//  NSString+BLCommonExtention.h
//  CommonClass
//
//  Created by blazer on 2017/11/5.
//  Copyright © 2017年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#ifdef __cplusplus
#define BL_EXTERN		extern "C" __attribute__((visibility ("default")))
#else
#define BL_EXTERN	        extern __attribute__((visibility ("default")))
#endif

@interface NSString (BLCommonExtention)

//计算文本的Size
- (CGSize)bl_sizeWithSystemFont:(UIFont *)font constrainedToSize:(CGSize)size;


//设备类型
BL_EXTERN NSString *const iPhone6_6s_7;
BL_EXTERN NSString *const iPhone6_6s_7Plus;
+ (instancetype)bl_deviceType;
@end
