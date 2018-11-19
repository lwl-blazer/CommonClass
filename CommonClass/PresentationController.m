
//
//  PresentationController.m
//  TextObject
//
//  Created by blazer on 2018/11/16.
//  Copyright © 2018年 com.calabashboy. All rights reserved.
//

#import "PresentationController.h"

#define CORNER_RADIUS   16.f

@interface PresentationController() <UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIView *dimmingView;
@property (nonatomic, strong) UIView *presentationWrappingView;

@end

@implementation PresentationController

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
        
        
        UIView *presentationRoundedCornerView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(presentationWrapperView.bounds, UIEdgeInsetsMake(0, 0, -CORNER_RADIUS, 0))];
        presentationRoundedCornerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        presentationRoundedCornerView.layer.cornerRadius = CORNER_RADIUS;
        presentationRoundedCornerView.layer.masksToBounds = YES;
        
        UIView *presentedViewControllerWrapperView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(presentationRoundedCornerView.bounds, UIEdgeInsetsMake(0, 0, CORNER_RADIUS, 0))];
        presentedViewControllerWrapperView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
       
        presentedViewControllerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        presentedViewControllerView.frame = presentedViewControllerWrapperView.bounds;
        
        [presentedViewControllerWrapperView addSubview:presentedViewControllerView];
        [presentationRoundedCornerView addSubview:presentedViewControllerWrapperView];
       [presentationWrapperView addSubview:presentationRoundedCornerView];
        //[presentationWrapperView addSubview:presentedViewControllerWrapperView];
        
        NSLog(@"presentationWrapperView:%@", NSStringFromCGRect(presentationWrapperView.frame));
        
        NSLog(@"presentationRoundedCornerView:%@", NSStringFromCGRect(presentationRoundedCornerView.frame));
        
        NSLog(@"presentedViewControllerWrapperView:%@", NSStringFromCGRect(presentedViewControllerWrapperView.frame));
        
        NSLog(@"presentedViewControllerView:%@", NSStringFromCGRect(presentedViewControllerView.frame));
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
/**
 * UIContentContainer的协议   从iOS8开始加入的新的一组协议，默认自动实现，我们可以自定义ViewConttroller的时候可以重写这些方法来调整视图布局
 */

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    
    if (container == self.presentedViewController) {
        [self.containerView setNeedsLayout];
    }
}

/**
 * 这个方法，一个ViewController可以设置ChildViewController的Size
 * 当容器viewControllerViewWillTransitionTosize：withTransitionCoordinator：被调用时（我们重写这个方法时要调用super），sizeForChildContentContainer方法将被调用。然后我们可以把需要设置desire发送给childViewController。当我们设置的这个size和当前childViewController的size一样，那么childViewController的viewWillTransitionToSize方法将不会被调用。
 */
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
    
    CGRect presentedViewControllerFrame = containerViewBounds;
    presentedViewControllerFrame.size.height = presentedViewContentSize.height;
    
    presentedViewControllerFrame.origin.y = CGRectGetMaxY(containerViewBounds) - presentedViewContentSize.height;
    return presentedViewControllerFrame;
}


- (void)containerViewWillLayoutSubviews{
    [super containerViewWillLayoutSubviews];
    
    self.dimmingView.frame = self.containerView.bounds;
    self.presentationWrappingView.frame = self.frameOfPresentedViewInContainerView;
}

/**
 * 如何改变 控制器大小:
     1.改变view的大小   实质上不是改变控制器大小
     2.-(CGSize)perrferredContentSize
 
 * 注意：
 *   当一个容器ViewController的ChildViewController的perferredContentSize值发生改变时，UIKit会调用preferredContentSizeDidChangeForChildContentContainer这个方法告诉当前容器ViewController。我们可以在这个方法里根据新的Size对界面进行调整。
 */




#pragma mark -- Tap

- (void)dimmingViewTapped:(UITapGestureRecognizer*)sender{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -- UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return [transitionContext isAnimated] ? 0.35 : 0;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
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
    
    if (isPresenting) {
        toViewInitialFrame.origin = CGPointMake(CGRectGetMinX(containerView.bounds), CGRectGetMaxY(containerView.bounds));
        toViewInitialFrame.size = toViewFinalFrame.size;
        toView.frame = toViewInitialFrame;
    } else {

        fromViewFinalFrame = CGRectOffset(fromView.frame, 0, CGRectGetHeight(fromView.frame));
    }
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        if (isPresenting)
            toView.frame = toViewFinalFrame;
        else
            fromView.frame = fromViewFinalFrame;
        
    } completion:^(BOOL finished) {
       
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

#pragma mark -- UIViewControllerTransitioningDelegate

- (UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    NSAssert(self.presentedViewController == presented, @"You didn't initialize %@ with the correct presentedViewController.  Expected %@, got %@.",
             self, presented, self.presentedViewController);
    
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}

@end
