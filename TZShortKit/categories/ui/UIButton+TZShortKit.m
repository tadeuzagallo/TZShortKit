//
//  UIButton+TZShortKit.m
//  TZShortKit
//
//  Created by Tadeu Zagallo on 9/20/13.
//  Copyright (c) 2013 Tadeu Zagallo. All rights reserved.
//

#import "UIButton+TZShortKit.h"

@implementation UIButton (TZShortKit)

- (void)setImageNamed:(NSString *)imageName forState:(UIControlState)state {
    [self setImage:[UIImage imageNamed:imageName] forState:state];
}

- (void)setBackgroundImageNamed:(NSString *)imageName forState:(UIControlState)state {
    [self setBackgroundImage:[UIImage imageNamed:imageName] forState:state];
}

@end
