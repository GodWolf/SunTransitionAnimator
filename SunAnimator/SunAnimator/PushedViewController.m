//
//  PushedViewController.m
//  SunAnimator
//
//  Created by 孙兴祥 on 2017/9/12.
//  Copyright © 2017年 sunxiangxiang. All rights reserved.
//

#import "PushedViewController.h"
#import "SunAimator.h"

@implementation PushedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    
    //push动画
    if(operation == UINavigationControllerOperationPush){
        return [[SunAimator alloc] initWithAnimatorType:(SunAimatorTypePush)];
    }else if (operation == UINavigationControllerOperationPop){
        return [[SunAimator alloc] initWithAnimatorType:(SunAimatorTypePop)];
    }
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    //手势
    return  nil;
}


@end
