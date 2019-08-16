//
//  HotelDetailFilterItemView.h
//  bee2clos
//
//  Created by luowailin on 2019/8/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HotelDetailFilterItemView;
@protocol HotelDetailFilterItemViewDelegate <NSObject>

@optional
- (void)itemView:(HotelDetailFilterItemView *)itemView buttonIndex:(NSUInteger)index buttonSelect:(BOOL)select;

@end

@interface HotelDetailFilterItemView : UIView

- (instancetype)initWithFrame:(CGRect)frame buttons:(NSArray <NSString *>*)buttons;

- (void)insertSelectFilterItemWithIndex:(NSInteger)row itemName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
