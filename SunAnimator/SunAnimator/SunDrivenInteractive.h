//
//  SunDrivenInteractive.h
//  SunAnimator
//
//  Created by 孙兴祥 on 2017/9/11.
//  Copyright © 2017年 sunxiangxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SunDrivenInteractive : UIPercentDrivenInteractiveTransition

@property (nonatomic,assign) BOOL isIneractive;
- (void)addGestureToViewCOntroller:(UIViewController *)fromVC;

@end
