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
    
    CGFloat spaceOffset = space/2.0;
    
    CGFloat imageWidthOffset = titleSize.width/2.0;
    CGFloat imageHeightOffset = titleSize.height/2.0;
    CGFloat titleWidthOffset = imageSize.width/2.0;
    CGFloat titleHeightOffset = imageSize.height/2.0;
    
    switch (type) {
        case UIButtonLayoutImageTop:
            self.titleEdgeInsets = UIEdgeInsetsMake(titleHeightOffset+space, -titleWidthOffset, -titleHeightOffset-spaceOffset, +titleWidthOffset);
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageHeightOffset-spaceOffset, imageWidthOffset, imageHeightOffset+spaceOffset, -imageWidthOffset);
            break;
        case UIButtonLayoutImageBottom:
            self.titleEdgeInsets = UIEdgeInsetsMake(-titleHeightOffset-spaceOffset, -titleWidthOffset, titleHeightOffset+spaceOffset, titleWidthOffset);
            self.imageEdgeInsets = UIEdgeInsetsMake(imageHeightOffset+spaceOffset, imageWidthOffset, -imageHeightOffset-spaceOffset, -imageWidthOffset);
            break;
        case UIButtonLayoutImageLeft:
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spaceOffset, 0, -spaceOffset);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spaceOffset, 0, spaceOffset);
            break;
        case UIButtonLayoutImageRight:
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -2*titleWidthOffset - spaceOffset, 0, 2*titleWidthOffset + spaceOffset);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 2*imageWidthOffset + spaceOffset, 0, -2*imageWidthOffset - spaceOffset);
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
