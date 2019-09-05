//
//  BLVerticalSegmentControl.m
//  CommonClass
//
//  Created by luowailin on 2019/9/4.
//  Copyright © 2019 blazer. All rights reserved.
//

#import "BLVerticalSegmentControl.h"

static NSString * const kPositionCALayerAction = @"position";
static NSString * const kBoundsCALayerAction   = @"bounds";

static CFTimeInterval const kDefaultAnimationDuration    = 0.15f;

int const BLVerticalSegmentedControlNoSegment = -1;

@interface BLVerticalSegmentControl ()

@property(nonatomic, assign) NSInteger visibleSelectedSegmentIndex;
@property(nonatomic, assign) CGFloat segmentHeight;
@property(nonatomic, assign) UIEdgeInsets segmentEdgeInset;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat roundWidth;

@property(nonatomic, strong) UIColor *selectionBoxBorderColor;
@property(nonatomic, assign) CGFloat selectionBoxBorderWidth;

@property(nonatomic, strong) CALayer *selectionIndicatorStripLayer;
@property(nonatomic, strong) CALayer *selectionIndicatorBoxLayer;



@end

@implementation BLVerticalSegmentControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configDefaultSettings];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configDefaultSettings];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                sectionTitles:(NSArray<NSString *> *)sectionTitles{
    self = [self initWithFrame:frame];
    if (self) {
        self.sectionTitles = sectionTitles;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        return;
    }
    [self updateSegmentsRects:self.frame.size];
}

- (void)configDefaultSettings{
    
    self.selectSegmentIndex = 0;
    self.visibleSelectedSegmentIndex = 0;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.textColor = [UIColor blackColor];
    self.selectTextColor = [UIColor blackColor];
    self.textFont = [UIFont systemFontOfSize:14.0f];
    
    self.itemSelectColor = [UIColor colorWithRed:52.0f/255.0f green:181.0f/255.0f blue:229.0f/255.0f alpha:1.0f];
    self.roundSelectColor = [UIColor colorWithRed:43/255.0 green:156/255.0 blue: 236/255.0 alpha:1.0];
    
    self.selectionIndicatorStripLayer = [CALayer layer];
    self.selectionIndicatorBoxLayer = [CALayer layer];
    
    self.selectionBoxBorderColor = [UIColor clearColor];
    self.selectionBoxBorderWidth = 0.0;
    
    self.segmentEdgeInset = UIEdgeInsetsZero;
    self.width = 100;
    self.roundWidth = 8;
}

- (void)drawRect:(CGRect)rect{
    [self.backgroundColor setFill];
    UIRectFill([self bounds]);
    
    self.selectionIndicatorStripLayer.backgroundColor = self.itemSelectColor.CGColor;
    self.selectionIndicatorBoxLayer.backgroundColor = self.itemSelectColor.CGColor;
    self.selectionIndicatorBoxLayer.borderColor = self.selectionBoxBorderColor.CGColor;
    self.selectionIndicatorBoxLayer.borderWidth = self.selectionBoxBorderWidth;
    
    self.layer.sublayers = nil;
    
    CGFloat leftSpace = 8 * 2 + self.roundWidth;
    for (NSInteger i = 0; i < self.sectionTitles.count; i ++) {
        NSString *str = self.sectionTitles[i];
        CGFloat y = i * self.segmentHeight;
        CGRect rect = CGRectMake(round(leftSpace),
                                 round(y),
                                 round(self.width - leftSpace - self.segmentEdgeInset.right),
                                 self.segmentHeight);
        
        
        CATextLayer *label = [[CATextLayer alloc] init];
        switch (self.textAlignment) {
            case BLVerticalSegmentedControlTextAlignmentLeft:
                label.alignmentMode = kCAAlignmentLeft;
                break;
                case BLVerticalSegmentedControlTextAlignmentRight:
                label.alignmentMode = kCAAlignmentRight;
                break;
            default:
                label.alignmentMode = kCAAlignmentCenter;
                break;
        }
        
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str
                                                                                          attributes:@{NSForegroundColorAttributeName:self.visibleSelectedSegmentIndex == i ? self.selectTextColor : self.textColor,
                                                                                                       NSParagraphStyleAttributeName:paragraph,
                                                                                                       NSBaselineOffsetAttributeName:@(-(self.segmentHeight/2.0-8.0)),
                                                                                                       NSFontAttributeName:self.textFont
                                                                                                       }];
        label.frame = rect;
        label.contentsScale = [UIScreen mainScreen].scale;
        label.contentsScale = [UIScreen mainScreen].scale;
        label.string = attributedStr;
        [self.layer addSublayer:label];
        
        if ([self.selectContentIndex containsObject:@(i)]) {
            CAShapeLayer *roundLayer = [[CAShapeLayer alloc] init];
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(8.0, y + (CGRectGetHeight(rect) / 2.0 - 4.0), 8.0, 8.0)
                                                            cornerRadius:4.0];
            roundLayer.path = path.CGPath;

            roundLayer.fillColor = self.roundSelectColor.CGColor;
            [self.layer addSublayer:roundLayer];
        }
    }
    
    if (!self.selectionIndicatorStripLayer.superlayer) {
        self.selectionIndicatorStripLayer.frame = [self frameForSelectionIndicator];
        [self.layer addSublayer:self.selectionIndicatorStripLayer];
        
        if (!self.selectionIndicatorBoxLayer.superlayer) {
            self.selectionIndicatorBoxLayer.frame = [self frameForFillerSelectionIndicator];
            [self.layer insertSublayer:self.selectionIndicatorBoxLayer atIndex:0];
        }
    }
    
}

- (void)updateSegmentsRects:(CGSize)size{
    if (CGRectIsEmpty(self.frame)) {
        self.segmentHeight = 0;
        
        for (NSString *titleString in self.sectionTitles) {
            CGFloat stringHeight = [self getTextHeight:titleString] + self.segmentEdgeInset.top + self.segmentEdgeInset.bottom;
            self.segmentHeight = MAX(stringHeight, self.segmentHeight);
        }
        self.frame = CGRectMake(0, 0, self.width, self.segmentHeight * self.sectionTitles.count);
    } else {
        self.segmentHeight = size.height / self.sectionTitles.count;
        self.width = size.width;
    }
}

- (CGFloat)getTextHeight:(NSString *)text{
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:self.textFont, NSFontAttributeName,nil];
    size = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    return size.height;
}

- (CGRect)frameForSelectionIndicator{
    CGFloat indicatorXOffset = 0;
    CGFloat sectionHeight = 0.0f;
    
    NSString *title = self.sectionTitles[self.selectSegmentIndex];
    CGFloat stringHeight = [self getTextHeight:title];
    sectionHeight = stringHeight;
    
    if (sectionHeight <= self.segmentHeight) {
        CGFloat heightToStartOfSelectedIndex = (self.segmentHeight * self.selectSegmentIndex);
        
        CGFloat y = heightToStartOfSelectedIndex + self.segmentHeight / 2 - (sectionHeight / 2);
        return CGRectMake(indicatorXOffset, y, 2.0, sectionHeight);
    } else {
        return CGRectMake(indicatorXOffset, self.segmentHeight * self.selectSegmentIndex, 2.0, self.segmentHeight);
    }
}

- (CGRect)frameForFillerSelectionIndicator{
    return CGRectMake(0, self.segmentHeight * self.selectSegmentIndex, self.width, self.segmentHeight);
}

- (void)notifyForSegmentChangeToIndex:(NSInteger)index{
    if (self.superview) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

#pragma mark -- touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if (CGRectContainsPoint(self.bounds, touchLocation)) {
        NSInteger segment = touchLocation.y / self.segmentHeight;
        if (segment != self.selectSegmentIndex) {
            [self setSelectedSegmentIndex:segment animated:YES notify:YES];
        }
    }
}

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated notify:(BOOL)notify{
    _selectSegmentIndex = index;
    self.visibleSelectedSegmentIndex = BLVerticalSegmentedControlNoSegment;
    if (index == BLVerticalSegmentedControlNoSegment) {
        [self.selectionIndicatorStripLayer removeFromSuperlayer];
        [self.selectionIndicatorBoxLayer removeFromSuperlayer];
    } else {
        if (animated) {
            if (![self.selectionIndicatorStripLayer superlayer]) {
                [self.layer addSublayer:self.selectionIndicatorStripLayer];
                
                if (![self.selectionIndicatorBoxLayer superlayer]){
                    [self.layer insertSublayer:self.selectionIndicatorBoxLayer atIndex:0];
                }
                [self setSelectedSegmentIndex:index animated:NO notify:YES];
                return;
            }
            
            if (notify) {
                [self notifyForSegmentChangeToIndex:index];
            }
            
            self.selectionIndicatorStripLayer.actions = nil;
            self.selectionIndicatorBoxLayer.actions = nil;
            
            [CATransaction begin];
            [CATransaction setCompletionBlock:^{
                self.visibleSelectedSegmentIndex = index;
                [self setNeedsDisplay];
            }];
            [CATransaction setAnimationDuration:kDefaultAnimationDuration];
            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
            self.selectionIndicatorStripLayer.frame = [self frameForSelectionIndicator];
            
            self.selectionIndicatorBoxLayer.frame = [self frameForFillerSelectionIndicator];
            [CATransaction commit];
        } else {
            self.visibleSelectedSegmentIndex = index;
            
            NSDictionary *newActions = @{kPositionCALayerAction : [NSNull null], kBoundsCALayerAction : [NSNull null]};
            self.selectionIndicatorStripLayer.actions = newActions;
            self.selectionIndicatorStripLayer.frame = [self frameForSelectionIndicator];
            
            self.selectionIndicatorBoxLayer.actions = newActions;
            self.selectionIndicatorBoxLayer.frame = [self frameForFillerSelectionIndicator];
            
            if (notify) {
                [self notifyForSegmentChangeToIndex:index];
            }
        }
    }
    [self setNeedsDisplay];
}

#pragma mark -- setter & getter

- (void)setSectionTitles:(NSArray<NSString *> *)sectionTitles{
    _sectionTitles = sectionTitles;
    [self updateSegmentsRects:CGSizeZero];
}

- (NSMutableArray<NSNumber *> *)selectContentIndex{
    if (!_selectContentIndex) {
        _selectContentIndex = [[NSMutableArray alloc] init];
    }
    return _selectContentIndex;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    if (self.sectionTitles) {
        [self updateSegmentsRects:frame.size];
    }
    
    [self setNeedsDisplay];
}

- (void)setSelectSegmentIndex:(NSInteger)selectSegmentIndex{
    [self setSelectedSegmentIndex:selectSegmentIndex animated:NO notify:NO];
}

@end
