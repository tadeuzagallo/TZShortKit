//
//  UIView+TZShortKit.m
//  TZShortKit
//
//  Created by Tadeu Zagallo on 9/19/13.
//  Copyright (c) 2013 Tadeu Zagallo. All rights reserved.
//

#import "UIView+TZShortKit.h"

@implementation UIView (TZShortKit)

#pragma mark - Setters

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setBoundsX:(CGFloat)x {
    CGRect frame = self.bounds;
    frame.origin.x = x;
    self.bounds = frame;
}

- (void)setBoundsY:(CGFloat)y {
    CGRect frame = self.bounds;
    frame.origin.y = y;
    self.bounds = frame;
}

- (void)setBoundsWidth:(CGFloat)width {
    CGRect frame = self.bounds;
    frame.size.width = width;
    self.bounds = frame;
}

- (void)setBoundsHeight:(CGFloat)height {
    CGRect frame = self.bounds;
    frame.size.height = height;
    self.bounds = frame;
}

- (void)setBoundsOrigin:(CGPoint)origin {
    CGRect frame = self.bounds;
    frame.origin = origin;
    self.bounds = frame;
}

- (void)setBoundsSize:(CGSize)size {
    CGRect frame = self.bounds;
    frame.size = size;
    self.bounds = frame;
}

#pragma mark - Getters

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)width {
    return self.frame.size.width;
}

-(CGFloat)height {
    return self.frame.size.height;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGSize)size {
    return self.frame.size;
}

- (CGFloat)boundsX {
    return self.bounds.origin.x;
}

- (CGFloat)boundsY {
    return self.bounds.origin.y;
}

- (CGFloat)boundsWidth {
    return self.bounds.size.width;
}

-(CGFloat)boundsHeight {
    return self.bounds.size.height;
}

- (CGPoint)boundsOrigin {
    return self.bounds.origin;
}

- (CGSize)boundsSize {
    return self.bounds.size;
}

@end