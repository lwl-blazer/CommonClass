//
//  BLCustomActionSheet.h
//  MorSearchProject
//
//  Created by morsearch on 2017/9/28.
//  Copyright © 2017年 morsearch. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BLCustomActionSheetDelegate <NSObject>

@optional
//成功显示
- (void)successShowed;

//已隐藏
- (void)dismissed;

@end

typedef NS_ENUM(NSInteger, BLCustomeActionSheetType) {
    BLCustomeActionSheetTypeAlert,
    BLCustomeActionSheetTypeSheet,
};


@interface BLCustomActionSheet : UIView

@property(nonatomic, assign) id<BLCustomActionSheetDelegate>delegate;

//必须加contentView 必须明确高度;
@property(nonatomic, strong, readwrite) UIView *contentView;
@property(nonatomic, assign, readwrite) CGFloat contentViewHeight;


//添加一个父类，可选项 
@property(nonatomic, weak) UIView *supView;

//默认sheet
@property(nonatomic, assign) BLCustomeActionSheetType type;

//创建
+ (instancetype) createActionSheet;

//显示
- (void)showCustomActionSheet;

//隐藏
- (void)dismissCustomActionSheet;


@end
