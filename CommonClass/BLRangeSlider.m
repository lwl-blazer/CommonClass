//
//  BLRangeSlider.m
//  RangeSliderDemo
//
//  Created by luowailin on 2019/8/8.
//  Copyright © 2019 tomthorpe. All rights reserved.
//

#import "BLRangeSlider.h"

const float HANDLE_DIAMETER = 16;
const int HANDLE_TOUCH_AREA_EXPANSION = -30;

@interface BLRangeSlider ()

@property(nonatomic, strong) CALayer *sliderLine;
@property(nonatomic, strong) CALayer *sliderColorLine;
@property(nonatomic, strong) CALayer *leftHandle;
@property(nonatomic, strong) CALayer *rightHandle;

@property(nonatomic, assign) BOOL leftHandleSelected;
@property(nonatomic, assign) BOOL rightHandleSelected;
@property(nonatomic, assign) BOOL disableRange;

@end

@implementation BLRangeSlider

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialiseControl];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialiseControl];
    }
    return self;
}

- (void)initialiseControl{
    _minValue = 0;
    _maxValue = 100;
    _selectedMinimum = 10;
    _selectedMaximum = 90;
    
    self.sliderLine = [CALayer layer];
    self.sliderLine.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:self.sliderLine];
    
    self.sliderColorLine = [CALayer layer];
    self.sliderColorLine.backgroundColor = self.tintColor.CGColor;
    [self.layer addSublayer:self.sliderColorLine];
    
    self.leftHandle = [CALayer layer];
    self.leftHandle.cornerRadius = 8.0f;
    self.leftHandle.backgroundColor = self.tintColor.CGColor;
    [self.layer addSublayer:self.leftHandle];
    
    self.rightHandle = [CALayer layer];
    self.rightHandle.cornerRadius = 8.0f;
    self.rightHandle.backgroundColor = self.tintColor.CGColor;
    [self.layer addSublayer:self.rightHandle];
    
    self.leftHandle.frame = CGRectMake(0, 0, HANDLE_DIAMETER, HANDLE_DIAMETER);
    self.rightHandle.frame = CGRectMake(0, 0, HANDLE_DIAMETER, HANDLE_DIAMETER);
    
    [self refresh];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    float barSidePadding = 16.0f;
    CGRect currentFrame = self.frame;
    float yMiddle = currentFrame.size.height/2.0;
    CGPoint lineLeftSide = CGPointMake(barSidePadding, yMiddle);
    CGPoint lineRightSide = CGPointMake(currentFrame.size.width-barSidePadding, yMiddle);
    self.sliderLine.frame = CGRectMake(lineLeftSide.x, lineLeftSide.y, lineRightSide.x-lineLeftSide.x, 1);
    self.sliderColorLine.frame = self.sliderLine.frame;
    
    [self updateHandlePositions];
    [self updateLabelPositions];
}

- (void)updateHandlePositions {
    CGPoint leftHandleCenter = CGPointMake([self getXPositionAlongLineForValue:self.selectedMinimum], CGRectGetMidY(self.sliderLine.frame));
    self.leftHandle.position = leftHandleCenter;
    
    CGPoint rightHandleCenter = CGPointMake([self getXPositionAlongLineForValue:self.selectedMaximum], CGRectGetMidY(self.sliderLine.frame));
    self.rightHandle.position= rightHandleCenter;
}

- (void)updateLabelPositions {
    CGPoint leftHandleCentre = [self getCentreOfRect:self.leftHandle.frame];
    CGPoint rightHandleCentre = [self getCentreOfRect:self.rightHandle.frame];
    
    CGRect frame = self.sliderColorLine.frame;
    frame.origin.x = leftHandleCentre.x;
    frame.size.width = rightHandleCentre.x - leftHandleCentre.x;
    self.sliderColorLine.frame = frame;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(rangeSlider:updatebetweenCenterX:)]) {
        [self.delegate rangeSlider:self
              updatebetweenCenterX:rightHandleCentre.x - leftHandleCentre.x];

    }
}

- (void)refresh {
    if (self.selectedMinimum < self.minValue){
        _selectedMinimum = self.minValue;
    }
    if (self.selectedMaximum > self.maxValue){
        _selectedMaximum = self.maxValue;
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES] ;
    [self updateHandlePositions];
    [self updateLabelPositions];
    [CATransaction commit];
    
    if (self.delegate){
        [self.delegate rangeSlider:self didChangeSelectedMinimumValue:self.selectedMinimum andMaximumValue:self.selectedMaximum];
    }
}


- (float)getXPositionAlongLineForValue:(float) value {
    float percentage = [self getPercentageAlongLineForValue:value];
    float maxMinDif = CGRectGetMaxX(self.sliderLine.frame) - CGRectGetMinX(self.sliderLine.frame);
    float offset = percentage * maxMinDif;
    return CGRectGetMinX(self.sliderLine.frame) + offset;
}

- (float)getPercentageAlongLineForValue:(float) value {
    if (self.minValue == self.maxValue){
        return 0;
    }
    float maxMinDif = self.maxValue - self.minValue;
    float valueSubtracted = value - self.minValue;
    return valueSubtracted / maxMinDif;
}

#pragma mark -- Touch Tracking
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint gesturePressLocation = [touch locationInView:self];
    
    if (CGRectContainsPoint(CGRectInset(self.leftHandle.frame, HANDLE_TOUCH_AREA_EXPANSION, HANDLE_TOUCH_AREA_EXPANSION), gesturePressLocation) || CGRectContainsPoint(CGRectInset(self.rightHandle.frame, HANDLE_TOUCH_AREA_EXPANSION, HANDLE_TOUCH_AREA_EXPANSION), gesturePressLocation))
    {
        float distanceFromLeftHandle = [self distanceBetweenPoint:gesturePressLocation andPoint:[self getCentreOfRect:self.leftHandle.frame]];
        float distanceFromRightHandle =[self distanceBetweenPoint:gesturePressLocation andPoint:[self getCentreOfRect:self.rightHandle.frame]];
        
        if (distanceFromLeftHandle < distanceFromRightHandle && self.disableRange == NO){
            self.leftHandleSelected = YES;
            [self animateHandle:self.leftHandle withSelection:YES];
        } else {
            if (self.selectedMaximum == self.maxValue && [self getCentreOfRect:self.leftHandle.frame].x == [self getCentreOfRect:self.rightHandle.frame].x) {
                self.leftHandleSelected = YES;
                [self animateHandle:self.leftHandle withSelection:YES];
            }
            else {
                self.rightHandleSelected = YES;
                [self animateHandle:self.rightHandle withSelection:YES];
            }
        }
        
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView:self];
    float percentage = ((location.x-CGRectGetMinX(self.sliderLine.frame)) - HANDLE_DIAMETER/2) / (CGRectGetMaxX(self.sliderLine.frame) - CGRectGetMinX(self.sliderLine.frame));
    
    float selectedValue = percentage * (self.maxValue - self.minValue) + self.minValue;
    
    if (self.leftHandleSelected){
        if (selectedValue < self.selectedMaximum){
            self.selectedMinimum = selectedValue;
        }
        else {
            self.selectedMinimum = self.selectedMaximum;
        }
        
    }
    else if (self.rightHandleSelected){
        if (selectedValue > self.selectedMinimum || (self.disableRange && selectedValue >= self.minValue)){
            self.selectedMaximum = selectedValue;
        }
        else {
            self.selectedMaximum = self.selectedMinimum;
        }
    }
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (self.leftHandleSelected){
        self.leftHandleSelected = NO;
        [self animateHandle:self.leftHandle withSelection:NO];
    } else {
        self.rightHandleSelected = NO;
        [self animateHandle:self.rightHandle withSelection:NO];
    }
}

- (void)animateHandle:(CALayer*)handle withSelection:(BOOL)selected {
    if (selected){
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.3];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] ];
        handle.transform = CATransform3DMakeScale(1.7, 1.7, 1);
        [self updateLabelPositions];
        
        [CATransaction setCompletionBlock:^{
        }];
        [CATransaction commit];
        
    } else {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.3];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] ];
        handle.transform = CATransform3DIdentity;
        [self updateLabelPositions];
        [CATransaction commit];
    }
}

#pragma mark - Calculating nearest handle to point
- (float)distanceBetweenPoint:(CGPoint)point1 andPoint:(CGPoint)point2{
    CGFloat xDist = (point2.x - point1.x);
    CGFloat yDist = (point2.y - point1.y);
    return sqrt((xDist * xDist) + (yDist * yDist));
}

- (CGPoint)getCentreOfRect:(CGRect)rect{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}


#pragma mark -- Setter
-(void)setTintColor:(UIColor *)tintColor{
    [super setTintColor:tintColor];
    
    struct CGColor *color = self.tintColor.CGColor;
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.5];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] ];
    self.sliderColorLine.backgroundColor = color;
    self.leftHandle.backgroundColor = color;
    self.rightHandle.backgroundColor = color;
    
    [CATransaction commit];
}

- (void)setMinValue:(float)minValue {
    _minValue = minValue;
    [self refresh];
}

- (void)setMaxValue:(float)maxValue {
    _maxValue = maxValue;
    [self refresh];
}

- (void)setSelectedMinimum:(float)selectedMinimum {
    if (selectedMinimum < self.minValue){
        selectedMinimum = self.minValue;
    }
    
    _selectedMinimum = selectedMinimum;
    [self refresh];
}

- (void)setSelectedMaximum:(float)selectedMaximum {
    if (selectedMaximum > self.maxValue){
        selectedMaximum = self.maxValue;
    }
    
    _selectedMaximum = selectedMaximum;
    [self refresh];
}

- (void)setDisableRange:(BOOL)disableRange {
    _disableRange = disableRange;
    if (_disableRange){
        self.leftHandle.hidden = YES;
    } else {
        self.leftHandle.hidden = NO;
    }
}

@end
