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
        self.borderNoSelectColor =  [UIColor colorWithRed:170/255.0
                                                    green:209/255.0
                                                     blue:255/255.0
                                                    alpha:1.0].CGColor;
        self.borderSelectColor = [UIColor blueColor].CGColor;
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    self.contentView.backgroundColor = [UIColor colorWithRed:237/255.0
                                                       green:243/255.0
                                                        blue:251/255.0
                                                       alpha:1.0];
    
    self.backView = [[UIView alloc] initWithFrame:CGRectZero];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.borderColor = self.borderNoSelectColor;
    self.backView.layer.borderWidth = 0.5;
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(8, 1, 8, 1));
        make.height.mas_offset(24);
    }];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label.font = [UIFont systemFontOfSize:14];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor blueColor];
    [self.backView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 8, 0, 8));
        make.width.mas_lessThanOrEqualTo(50);
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
