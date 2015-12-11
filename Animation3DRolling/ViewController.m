//
//  ViewController.m
//  Animation3DRolling
//
//  Created by Devin on 15/12/11.
//  Copyright © 2015年 Devin. All rights reserved.
//

#import "ViewController.h"
#import "3DRollingView.h"

@interface ViewController ()<ClickImageDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) int currentIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _DRollingView *rollingView = [[_DRollingView alloc] initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, 180))];
    rollingView.delegate = self;
    
    [rollingView show3DRollingView];
    
    [self.view addSubview:rollingView];
}

// 实现协议, 点击了第几张图片
- (void)clickImage:(int)index{
    
    NSLog(@"点击了第%d张", index);
}

@end
