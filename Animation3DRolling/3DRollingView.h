//
//  3DRollingView.h
//  Animation3DRolling
//
//  Created by Devin on 15/12/11.
//  Copyright © 2015年 Devin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClickImageDelegate <NSObject>

- (void)clickImage:(int)index;

@end

@interface _DRollingView : UIView

// 当前图片的下标
@property (nonatomic, assign) int currentIndex;
// 图片
@property (nonatomic, strong) UIImageView *imageView;
// 图片数组
@property (nonatomic, strong) NSArray *imageArr;

// 代理
@property (nonatomic, assign) id<ClickImageDelegate>delegate;

// 接口
- (void)show3DRollingView;

@end
