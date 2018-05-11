//
//  UIButton+Layout.m
//  SDLBtn
//
//  Created by zzc-13 on 2018/5/3.
//  Copyright © 2018年 lzy. All rights reserved.
//

#import "UIButton+Layout.h"
#import <objc/runtime.h>

static void *infoDicKey = &infoDicKey;

@interface UIButton ()

@property (strong, nonatomic) NSMutableDictionary *infoDic;
@property (assign, nonatomic) UIButtonLayoutType type;
@property (assign, nonatomic) CGFloat space;
@property (assign, nonatomic) BOOL support;

@end

@implementation UIButton (Layout)

+ (void)load{
    Method newMethod = class_getInstanceMethod([self class], @selector(lzyLayoutSubviews));
    Method method = class_getInstanceMethod([self class], @selector(layoutSubviews));
    method_exchangeImplementations(newMethod, method);
}

- (void)setImageLayout:(UIButtonLayoutType)type space:(CGFloat)space{
    [self.infoDic setValue:@(type) forKey:@"type"];
    [self.infoDic setValue:@(space) forKey:@"space"];
    [self.infoDic setValue:@true forKey:@"support"];
    
    objc_setAssociatedObject(self, &infoDicKey, self.infoDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lzyLayoutSubviews{
    
    [self lzyLayoutSubviews];
    
    if (!self.support) {
        if (self.isSizeToFit) {
            [self.titleLabel sizeToFit];
        }
        return;
    }
    
    UIButtonLayoutType type = self.type;
    CGFloat space = self.space;
    
    CGSize titleSize = self.titleLabel.bounds.size;
    CGSize imageSize = self.imageView.frame.size;
    
    CGFloat fitOffset = 0;
    if (self.isSizeToFit) {
        [self.titleLabel sizeToFit];
        CGSize fitTitleSize = self.titleLabel.bounds.size;
        fitOffset = fitTitleSize.width - titleSize.width;
    }
    
    CGFloat spaceOffset = space/2.0;
    
    CGFloat imageWidthOffset = titleSize.width/2.0;
    CGFloat imageHeightOffset = titleSize.height/2.0;
    CGFloat titleWidthOffset = imageSize.width/2.0 + fitOffset/2.0;
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

- (void)setIsSizeToFit:(BOOL)isSizeToFit{
    [self.infoDic setValue:@(isSizeToFit) forKey:@"isSizeToFit"];
    objc_setAssociatedObject(self, &infoDicKey, self.infoDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isSizeToFit{
    return [self.infoDic[@"isSizeToFit"] boolValue];
}

- (CGFloat)space{
    return [self.infoDic[@"space"] floatValue];
}

- (UIButtonLayoutType)type{
    return (UIButtonLayoutType)[self.infoDic[@"type"] integerValue];
}

- (BOOL)support{
    return [self.infoDic[@"support"] boolValue];
}

- (NSMutableDictionary *)infoDic{
    NSMutableDictionary *infoDic = objc_getAssociatedObject(self, &infoDicKey);
    if (!infoDic) {
        infoDic = [@{@"type":@(UIButtonLayoutImageLeft),@"space":@0,@"isSizeToFit":@false,@"support":@false} mutableCopy];
        objc_setAssociatedObject(self, &infoDicKey, infoDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return infoDic;
}


@end
