//
//  SunDrivenInteractive.m
//  SunAnimator
//
//  Created by 孙兴祥 on 2017/9/11.
//  Copyright © 2017年 sunxiangxiang. All rights reserved.
//

#import "SunDrivenInteractive.h"

@interface SunDrivenInteractive ()

@property (nonatomic,weak) UIViewController *fromVC;
@property (nonatomic,assign) CGFloat percent;

@end
@implementation SunDrivenInteractive

- (void)addGestureToViewCOntroller:(UIViewController *)fromVC {

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveAction:)];
    [fromVC.view addGestureRecognizer:panGesture];
    _fromVC = fromVC;
}

- (void)moveAction:(UIPanGestureRecognizer *)panGesture {

    if(panGesture.state == UIGestureRecognizerStateBegan){
        
        _isIneractive = YES;
        [_fromVC dismissViewControllerAnimated:YES completion:NULL];
    }else if (panGesture.state == UIGestureRecognizerStateChanged){
    
        CGFloat translationX = [panGesture translationInView:_fromVC.view].x;
        if(translationX > 0){
            _percent = translationX/300.0;
            //更新进度
            [self updateInteractiveTransition:_percent];
        }
    }else if (panGesture.state == UIGestureRecognizerStateEnded){
    
        _isIneractive = NO;
        if(_percent > 0.5){
            [self finishInteractiveTransition];
        }else{
            [self cancelInteractiveTransition];
        }
    }
}

@end
