//
//  SunAimator.h
//  SunAnimator
//
//  Created by 孙兴祥 on 2017/9/12.
//  Copyright © 2017年 sunxiangxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SunAimatorType) {
    SunAimatorTypePresent,
    SunAimatorTypeDismiss,
    SunAimatorTypePush,
    SunAimatorTypePop,
};
@interface SunAimator : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithAnimatorType:(SunAimatorType)animatorType;

@end
