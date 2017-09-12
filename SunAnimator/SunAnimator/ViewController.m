//
//  ViewController.m
//  SunAnimator
//
//  Created by 孙兴祥 on 2017/9/11.
//  Copyright © 2017年 sunxiangxiang. All rights reserved.
//

#import "ViewController.h"
#import "PresentedViewController.h"
#import "PushedViewController.h"

@interface ViewController ()

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = YES;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _imageView.center = self.view.center;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    _imageView.image = [UIImage imageNamed:@"test.jpg"];
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentViewAction)];
    [_imageView addGestureRecognizer:tap];
}

- (void)presentViewAction {

//    PresentedViewController *vc = [[PresentedViewController alloc] init];
//    vc.transitioningDelegate = vc;
//    [self presentViewController:vc animated:YES completion:NULL];
    
    PushedViewController *vc = [[PushedViewController alloc] init];
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];

}




@end
