//
//  3DRollingView.m
//  Animation3DRolling
//
//  Created by Devin on 15/12/11.
//  Copyright © 2015年 Devin. All rights reserved.
//

#import "3DRollingView.h"

// 宏定义宽高
#define MainScreenH [UIScreen mainScreen].bounds.size.height
#define MainScreenW [UIScreen mainScreen].bounds.size.width

@implementation _DRollingView

- (void)show3DRollingView{
    
    // 图片数组赋值
    self.imageArr = @[@"0.jpg", @"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg"];
    // 定义图片控件
    self.imageView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, MainScreenW, 180))];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    // 设置默认图片
    self.imageView.image = [UIImage imageNamed:self.imageArr[0]];
    self.imageView.userInteractionEnabled = YES;
    self.userInteractionEnabled = YES;
    [self addSubview:self.imageView];
    
    // 设置一个tag值
    self.imageView.tag = 101;
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.imageView addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;;
    [self addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:rightSwipe];
    
}

#pragma mark --- 点击图片显示第几张
- (void)tap:(UITapGestureRecognizer *)tap{
    
    // 代理不为空, 且代理实现了协议的方法
    if (_delegate != nil && [_delegate respondsToSelector:@selector(clickImage:)]) {
        
        // 代理执行方法
        [_delegate clickImage:(int)(tap.view.tag - 100)];
    }
}
#pragma mark --- 向左滑动浏览下一张图片
- (void)leftSwipe:(UISwipeGestureRecognizer *)swipe{
    [self transitionAnimation:YES];
}
#pragma mark --- 向右滑动浏览上一张图片
- (void)rightSwipe:(UISwipeGestureRecognizer *)swipe{
    [self transitionAnimation:NO];
}

#pragma mark --- 实现动画(核心部分)
- (void)transitionAnimation:(BOOL)isNext{
    
    // 1.创建转场动画对象
    CATransition *transition = [[CATransition alloc] init];
    
    // 2.设置动画类型, 注意对于苹果官方没公开的动画类型只能使用字符串, 并没有对应的常量定义
    transition.type = @"cube";
    
    // 3.设置子类型
    if (isNext) {
        
        transition.subtype = kCATransitionFromRight;
    }else{
        
        transition.subtype = kCATransitionFromLeft;
    }
    
    // 4.设置动画时长
    transition.duration = 1.f;
    
    // 5.设置转场后的新视图添加转场动画
    self.imageView.image = [self getImage:isNext];
    [self.imageView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
}

#pragma mark --- 取得图片
- (UIImage *)getImage:(BOOL)isNext{
    
    if (isNext) {
        
        self.currentIndex = (self.currentIndex + 1) % self.imageArr.count;
    }else{
        
        self.currentIndex = (self.currentIndex - 1 + self.imageArr.count) % (int)self.imageArr.count;
    }
    NSString *imageName = self.imageArr[self.currentIndex];
    
    self.imageView.tag = self.currentIndex + 100;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.imageView addGestureRecognizer:tap];
    
    return [UIImage imageNamed:imageName];
}



@end
