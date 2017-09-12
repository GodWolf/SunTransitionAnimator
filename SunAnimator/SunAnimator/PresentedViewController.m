//
//  PresentedViewController.m
//  SunAnimator
//
//  Created by 孙兴祥 on 2017/9/11.
//  Copyright © 2017年 sunxiangxiang. All rights reserved.
//

#import "PresentedViewController.h"
#import "SunAimator.h"
#import "SunDrivenInteractive.h"

@interface PresentedViewController ()

@property (nonatomic,strong) SunDrivenInteractive *interactive;

@end

@implementation PresentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    _interactive = [[SunDrivenInteractive alloc] init];
    [_interactive addGestureToViewCOntroller:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {

    //present动画
    return [[SunAimator alloc] initWithAnimatorType:(SunAimatorTypePresent)];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {

    //dismiss动画
    return [[SunAimator alloc] initWithAnimatorType:(SunAimatorTypeDismiss)];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {

    //present手势
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {

    //dismiss手势
    return (_interactive.isIneractive?_interactive:nil);
}



@end
