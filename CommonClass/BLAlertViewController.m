//
//  BLAlertViewController.m
//  TextObject
//
//  Created by luowailin on 2018/11/22.
//  Copyright © 2018 com.calabashboy. All rights reserved.
//

#import "BLAlertViewController.h"


@interface BLAlertViewController() <UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

@property (nonatomic, strong) UIView *dimmingView;
@property (nonatomic, strong) UIView *presentationWrappingView;

@property (nonatomic, weak) id<UIViewControllerContextTransitioning>transitionContext;

@end

@implementation BLAlertViewController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController{
    self = [super initWithPresentedViewController:presentedViewController
                         presentingViewController:presentingViewController];
    if (self) {
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (UIView *)presentedView{
    return self.presentationWrappingView;
}


#pragma mark -- presentation && dismiss

- (void)presentationTransitionWillBegin{
    UIView *presentedViewControllerView = [super presentedView];
    
    {
        UIView *presentationWrapperView = [[UIView alloc] initWithFrame:self.frameOfPresentedViewInContainerView];
        presentationWrapperView.layer.shadowOpacity = 0.44f;
        presentationWrapperView.layer.shadowRadius = 13.f;
        presentationWrapperView.layer.shadowOffset = CGSizeMake(0, -6.f);
        self.presentationWrappingView = presentationWrapperView;
    
        UIView *presentationRoundedCornerView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(presentationWrapperView.bounds, UIEdgeInsetsMake(0, 0, 0, 0))];
        presentationRoundedCornerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        presentationRoundedCornerView.layer.cornerRadius = 10.0;
        presentationRoundedCornerView.layer.masksToBounds = YES;
        
        UIView *presentedViewControllerWrapperView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(presentationRoundedCornerView.bounds, UIEdgeInsetsMake(0, 0, 0, 0))];
        presentedViewControllerWrapperView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        
        presentedViewControllerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        presentedViewControllerView.frame = presentedViewControllerWrapperView.bounds;
        
        [presentedViewControllerWrapperView addSubview:presentedViewControllerView];
        [presentationRoundedCornerView addSubview:presentedViewControllerWrapperView];
        [presentationWrapperView addSubview:presentationRoundedCornerView];
    }
    
    //背景view
    {
        UIView *dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
        dimmingView.backgroundColor = [UIColor blackColor];
        dimmingView.opaque = NO;
        dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)]];
        self.dimmingView = dimmingView;
        [self.containerView addSubview:dimmingView];
        
        
        //显示动画
        id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
        self.dimmingView.alpha = 0.f;
        [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            self.dimmingView.alpha = 0.5f;
        } completion:NULL];
    }
}

- (void)presentationTransitionDidEnd:(BOOL)completed{
    if (completed == NO) {
        self.presentationWrappingView = nil;
        self.dimmingView = nil;
    }
}

- (void)dismissalTransitionWillBegin{
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.f;
    } completion:NULL];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed{
    if (completed == YES) {
        self.presentationWrappingView = nil;
        self.dimmingView = nil;
    }
}


#pragma mark -- Layout --

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    
    if (container == self.presentedViewController) {
        [self.containerView setNeedsLayout];
    }
}

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize{
    if (container == self.presentedViewController) {
        return ((UIViewController *)container).preferredContentSize;
    }else{
        return [super sizeForChildContentContainer:container
                           withParentContainerSize:parentSize];
    }
}


- (CGRect)frameOfPresentedViewInContainerView{ //最终定义被呈现的View的最终位置
    CGRect containerViewBounds = self.containerView.bounds;
    
    CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    
    CGRect presentedViewControllerFrame = CGRectMake(([UIScreen mainScreen].bounds.size.width - presentedViewContentSize.width) / 2,
                                                     ([UIScreen mainScreen].bounds.size.height - presentedViewContentSize.height) / 2,
                                                     presentedViewContentSize.width,
                                                     presentedViewContentSize.height);
    return presentedViewControllerFrame;
}


- (void)containerViewWillLayoutSubviews{
    [super containerViewWillLayoutSubviews];
    
    self.dimmingView.frame = self.containerView.bounds;
    self.presentationWrappingView.frame = self.frameOfPresentedViewInContainerView;
}

#pragma mark -- Tap

- (void)dimmingViewTapped:(UITapGestureRecognizer*)sender{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -- UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return [transitionContext isAnimated] ? 0.35 : 0;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    self.transitionContext = transitionContext;
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    BOOL isPresenting = (fromViewController == self.presentingViewController);
    
    
    CGRect __unused fromViewInitialFrame = [transitionContext initialFrameForViewController:fromViewController];
    
    CGRect fromViewFinalFrame = [transitionContext finalFrameForViewController:fromViewController];
    
    CGRect toViewInitialFrame = [transitionContext initialFrameForViewController:toViewController];
    
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toViewController];
    
    [containerView addSubview:toView];
    
    if (isPresenting) { //YES 显示
        toViewInitialFrame.origin = CGPointMake(CGRectGetMinX(containerView.bounds), CGRectGetMaxY(containerView.bounds));
        toViewInitialFrame.size = toViewFinalFrame.size;
        toView.frame = toViewInitialFrame;
    } else {  //隐藏
        
        fromViewFinalFrame = CGRectOffset(fromView.frame, 0, CGRectGetHeight(fromView.frame));
    }
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    if (isPresenting) {

        CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = transitionDuration;
        animation.removedOnCompletion = NO;
        
        animation.fillMode = kCAFillModeForwards;
        
        NSMutableArray *values = [NSMutableArray array];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.15, 1.15, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        animation.delegate = self;
        animation.values = values;
        animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut];
        [toView.layer addAnimation:animation forKey:nil];
    }else{
        [UIView animateWithDuration:transitionDuration animations:^{
            [fromView removeFromSuperview];
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
    }
}

#pragma mark -- UIViewControllerTransitioningDelegate

- (UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    NSAssert(self.presentedViewController == presented, @"You didn't initialize %@ with the correct presentedViewController.  Expected %@, got %@.",
             self, presented, self.presentedViewController);
    
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    BOOL wasCancelled = [self.transitionContext transitionWasCancelled];
    [self.transitionContext completeTransition:!wasCancelled];
}




@end
