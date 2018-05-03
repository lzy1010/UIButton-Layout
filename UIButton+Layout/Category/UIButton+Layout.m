//
//  UIButton+Layout.m
//  SDLBtn
//
//  Created by zzc-13 on 2018/5/3.
//  Copyright © 2018年 lzy. All rights reserved.
//

#import "UIButton+Layout.h"
#import <objc/runtime.h>

static void *typeKey = &typeKey;
static void *spaceKey = &spaceKey;

@interface UIButton ()

@property (assign, nonatomic) UIButtonLayoutType type;
@property (assign, nonatomic) CGFloat space;

@end

@implementation UIButton (Layout)

+ (void)load{
    Method newMethod = class_getInstanceMethod([self class], @selector(lzyLayoutSubviews));
    Method method = class_getInstanceMethod([self class], @selector(layoutSubviews));
    method_exchangeImplementations(newMethod, method);
}

- (void)setImageLayout:(UIButtonLayoutType)type space:(CGFloat)space{
    self.type = type;
    self.space = space;
}

- (void)lzyLayoutSubviews{
    
    [self lzyLayoutSubviews];

    UIButtonLayoutType type = self.type;
    CGFloat space = self.space;
    
    CGSize titleSize = self.titleLabel.bounds.size;
    CGSize imageSize = self.imageView.frame.size;
    
    switch (type) {
        case UIButtonLayoutImageTop:
            self.titleEdgeInsets = UIEdgeInsetsMake(imageSize.height + space, -imageSize.width, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + space), titleSize.width, 0, 0);
            break;
        case UIButtonLayoutImageBottom:
            self.titleEdgeInsets = UIEdgeInsetsMake(-(imageSize.height + space), -imageSize.width, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(titleSize.height + space, titleSize.width, 0, 0);
            break;
        case UIButtonLayoutImageLeft:
            self.titleEdgeInsets = UIEdgeInsetsMake(0, space, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -space, 0, 0);
            break;
        case UIButtonLayoutImageRight:
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(2*imageSize.width + space), 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 2*titleSize.width + space, 0, 0);
            break;
        default:
            break;
    }
}

- (void)setType:(UIButtonLayoutType)type{
    
    NSString *typeStr = [NSString stringWithFormat:@"%lu",(unsigned long)type];
    objc_setAssociatedObject(self, &typeKey, typeStr, OBJC_ASSOCIATION_COPY);
}

- (UIButtonLayoutType)type{
    return (UIButtonLayoutType)[objc_getAssociatedObject(self, &typeKey) integerValue];
}

- (void)setSpace:(CGFloat)space{
    NSString *spaceStr = [NSString stringWithFormat:@"%f",space];
    objc_setAssociatedObject(self, &spaceKey, spaceStr, OBJC_ASSOCIATION_COPY);
}

- (CGFloat)space{
    return [objc_getAssociatedObject(self, &spaceKey) floatValue];
}

@end
