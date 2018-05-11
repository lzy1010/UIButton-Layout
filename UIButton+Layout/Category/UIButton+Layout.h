//
//  UIButton+Layout.h
//  SDLBtn
//
//  Created by zzc-13 on 2018/5/3.
//  Copyright © 2018年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIButtonLayoutType) {
    UIButtonLayoutImageLeft,
    UIButtonLayoutImageRight,
    UIButtonLayoutImageTop,
    UIButtonLayoutImageBottom,
};

@interface UIButton (Layout)

- (void)setImageLayout:(UIButtonLayoutType)type space:(CGFloat)space;

/**
 titleLabel是否自适应宽度
 */
@property (assign, nonatomic) BOOL isSizeToFit;

@end
