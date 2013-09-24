//
//  UIButton+TZShortKit.m
//  TZShortKit
//
//  Created by Tadeu Zagallo on 9/20/13.
//  Copyright (c) 2013 Tadeu Zagallo. All rights reserved.
//

#import "UIButton+TZShortKit.h"

@implementation UIButton (TZShortKit)

#pragma mark - Setters

- (void)setImageName:(NSString *)imageName {
    [self setImageNamed:imageName forState:UIControlStateNormal];
}

- (void)setBackgroundImageName:(NSString *)backgroundImageName {
    [self setBackgroundImageNamed:backgroundImageName forState:UIControlStateNormal];
}

- (void)setImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
}

- (void)setSelectedImageName:(NSString *)imageName {
    [self setImageNamed:imageName forState:UIControlStateSelected];
}

- (void)setSelectedBackgroundImageName:(NSString *)backgroundImageName {
    [self setImageNamed:backgroundImageName forState:UIControlStateSelected];
}

- (void)setSelectedImage:(UIImage *)selectedImage {
    [self setImage:selectedImage forState:UIControlStateSelected];
}

- (void)setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage {
    [self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
}

- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setSelectedTitle:(NSString *)selectedTitle {
    [self setTitle:selectedTitle forState:UIControlStateSelected];
}

#pragma mark - Getters

- (UIImage *)image {
    return [self imageForState:UIControlStateNormal];
}

- (UIImage *)backgroundImage {
    return [self backgroundImageForState:UIControlStateNormal];
}

- (UIImage *)selectedImage {
    return [self imageForState:UIControlStateSelected];
}

-  (UIImage *)selectedBackgroundImage {
    return [self backgroundImageForState:UIControlStateSelected];
}

- (NSString *)title {
    return [self titleForState:UIControlStateNormal];
}

- (NSString *)selectedTitle {
    return [self titleForState:UIControlStateSelected];
}

#pragma mark - Overriden Methods

- (void)setImageNamed:(NSString *)imageName forState:(UIControlState)state {
    [self setImage:[UIImage imageNamed:imageName] forState:state];
}

- (void)setBackgroundImageNamed:(NSString *)imageName forState:(UIControlState)state {
    [self setBackgroundImage:[UIImage imageNamed:imageName] forState:state];
}

@end
