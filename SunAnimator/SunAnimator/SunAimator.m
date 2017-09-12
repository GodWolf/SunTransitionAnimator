//
//  SunAimator.m
//  SunAnimator
//
//  Created by 孙兴祥 on 2017/9/12.
//  Copyright © 2017年 sunxiangxiang. All rights reserved.
//

#import "SunAimator.h"

@interface SunAimator ()

@property (nonatomic,assign) SunAimatorType animaorType;

@end
@implementation SunAimator

- (instancetype)initWithAnimatorType:(SunAimatorType)animatorType {

    if(self = [super init]){
        
        _animaorType = animatorType;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 1.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    switch (_animaorType) {
        case SunAimatorTypePresent:{
            
            [self presentAnimatorTransition:transitionContext];
            break;
        }
        case SunAimatorTypeDismiss:{
            
            [self dismissAnimatorTransition:transitionContext];
            break;
        }
        case SunAimatorTypePush:{
            
            [self pushAnimatorTransition:transitionContext];
            break;
        }
        case SunAimatorTypePop:{
            
            [self popAnimatorTransition:transitionContext];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - present动画
- (void)presentAnimatorTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView *tempView = [self snapWithView:fromView];
    [containerView addSubview:tempView];
    
    [containerView addSubview:toView];
    toView.alpha = 0;
    
    [UIView animateWithDuration:duration animations:^{
        
        toView.alpha = 1;
    } completion:^(BOOL finished) {
       
        if([transitionContext transitionWasCancelled]){
            [transitionContext completeTransition:NO];
            [toView removeFromSuperview];
            [containerView addSubview:fromView];
        }else{
            [transitionContext completeTransition:YES];
        }
        [tempView removeFromSuperview];
    }];
    
}

#pragma mark - dismiss动画
- (void)dismissAnimatorTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //将要消失的视图
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    //将要显示的视图
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    //动画过程的背景视图
    UIView *containerView = [transitionContext containerView];
    //动画时间
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    //应为要在fromView上做动画，为了一些不必要的麻烦这里采用截图处理
    UIView *tempView = [self snapWithView:fromView];
    //将参与动画的视图添加到动画背景视图上
    [containerView addSubview:toView];
    [containerView addSubview:tempView];
    
    //动画的具体内容，也可自自己使用CABasicAnimation、CAKeyframeAnimation和CAKeyframeAnimation实现更复杂的动画
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
        tempView.transform = transform;
    } completion:^(BOOL finished) {
        
        //判断手势是否失败
        if([transitionContext transitionWasCancelled]){
            //发送一个失败的消息
            [transitionContext completeTransition:NO];
            //失败的话需要将目标视图移除，还要将原先的页面显示出来(显示很重要)
            [toView removeFromSuperview];
            [containerView addSubview:fromView];
        }else{
            [transitionContext completeTransition:YES];
        }
        //临时视图不管动画失败还是成功都要移除
        [tempView removeFromSuperview];
    }];
    
}

#pragma mark - push动画
- (void)pushAnimatorTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [containerView addSubview:toView];
    
    UIView *tempView = [self snapWithView:fromView];
    tempView.layer.anchorPoint = CGPointMake(0, 0.5);
    [containerView addSubview:tempView];
    tempView.frame = fromView.frame;
    
    
    [UIView animateWithDuration:duration animations:^{
        
        tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
    } completion:^(BOOL finished) {
        
        if([transitionContext transitionWasCancelled]){
            [transitionContext completeTransition:NO];
            [toView removeFromSuperview];
            [containerView addSubview:fromView];
        }else{
            [transitionContext completeTransition:YES];
        }
        [tempView removeFromSuperview];
    }];
    
}

#pragma mark - pop动画
- (void)popAnimatorTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView *tempView = [self snapWithView:fromView];
    [containerView addSubview:tempView];
    
    [containerView addSubview:toView];
    toView.layer.anchorPoint = CGPointMake(0, 0.5);
    toView.frame = containerView.bounds;
    toView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
    
    
    
    [UIView animateWithDuration:duration animations:^{
        
        toView.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        
        if([transitionContext transitionWasCancelled]){
            [transitionContext completeTransition:NO];
            [toView removeFromSuperview];
            [containerView addSubview:fromView];
        }else{
            [transitionContext completeTransition:YES];
        }
        [tempView removeFromSuperview];
    }];
}

- (UIView *)snapWithView:(UIView *)view {

    UIImageView *snapView = [[UIImageView alloc] initWithFrame:view.frame];
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    snapView.image = image;
    
    return snapView;
}


@end
