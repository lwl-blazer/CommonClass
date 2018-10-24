//
//  TableViewCell.m
//  CommonClass
//
//  Created by blazer on 2018/10/20.
//  Copyright © 2018 blazer. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell()

@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) UIView *subView;
@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)drawRect:(CGRect)rect{
    
    CGSize size = self.label.frame.size;
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = CGRectMake(0, 0, size.width, size.height);
//    borderLayer.strokeColor = [UIColor blueColor].CGColor;
//    borderLayer.fillColor = [UIColor whiteColor].CGColor;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:10.0];
    borderLayer.path = bezierPath.CGPath;
    
//    borderLayer.borderWidth = 3.0;
//    borderLayer.borderColor = [UIColor blueColor].CGColor;
  
    self.label.layer.borderWidth = 1.0;
    self.label.layer.borderColor = [UIColor blueColor].CGColor;
    self.label.layer.mask = borderLayer;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//100/
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.subView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, [UIScreen mainScreen].bounds.size.width - 16, 84)];
        self.subView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.subView];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 40)];
        self.label.backgroundColor = [UIColor whiteColor];
        self.label.textColor = [UIColor whiteColor];
//        self.label.layer.borderWidth = 1.0;
//        self.label.layer.borderColor = [UIColor blueColor].CGColor;
        
        [self.subView addSubview: self.label];
        
        
        
    }
    return self;
}

- (void)refreshData:(NSInteger)d{
    self.label.text = [NSString stringWithFormat:@"%ld", d];
}




@end
