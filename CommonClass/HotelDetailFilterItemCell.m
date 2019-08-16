//
//  HotelDetailFilterItemCell.m
//  bee2clos
//
//  Created by luowailin on 2019/8/16.
//

#import "HotelDetailFilterItemCell.h"
#import <Masonry/Masonry.h>

@interface HotelDetailFilterItemCell ()

@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) UIImageView *selectImageView;
@property(nonatomic, strong) UILabel *label;

@property(nonatomic, strong) UIImage *selectImage;
@property(nonatomic, assign) CGColorRef borderSelectColor;
@property(nonatomic, assign) CGColorRef borderNoSelectColor;

@end

@implementation HotelDetailFilterItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectImage = [UIImage imageNamed:@"blue_triangle"];
        self.borderNoSelectColor = SMARTAlphaGrayColor(170, 209, 255, 1).CGColor;
        self.borderSelectColor = UICOLOR_1fa5ff.CGColor;
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    self.contentView.backgroundColor = SMARTAlphaGrayColor(237, 243, 251, 1.0);
    
    self.backView = [[UIView alloc] initWithFrame:CGRectZero];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = RATENUM(5);
    self.backView.layer.borderColor = self.borderNoSelectColor;
    self.backView.layer.borderWidth = 0.5;
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(RATENUM(8), RATENUM(1), RATENUM(8), RATENUM(1)));
        make.height.mas_offset(RATENUM(24));
    }];
    
    self.label = [UILabel createLabelWithFontSize:[UIFont creatPingFangSCRegularWithSize:RATENUM(14)]
                                        textColor:UICOLOR_1fa5ff
                                             text:@""
                                            align:NSTextAlignmentCenter];
    
    [self.backView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, RATENUM(8), 0, RATENUM(8)));
        make.width.mas_lessThanOrEqualTo(RATENUM(50));
    }];
    
    self.selectImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.selectImageView.image = self.selectImage;
    [self.backView addSubview:self.selectImageView];
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
}

- (void)setModel:(id)model{
    if ([model isKindOfClass:[NSDictionary class]]) {
        self.label.text = [model objectForKey:@"name"];
        BOOL select = [[model objectForKey:@"select"] boolValue];
        if (select && self.selectImageView.hidden) {
            self.selectImageView.hidden = NO;
        } else if (!select && !self.selectImageView.hidden) {
            self.selectImageView.hidden = YES;
        }
    }
}

@end
