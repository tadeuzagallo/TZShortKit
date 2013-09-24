//
//  UIButton+TZShortKit.h
//  TZShortKit
//
//  Created by Tadeu Zagallo on 9/20/13.
//  Copyright (c) 2013 Tadeu Zagallo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TZShortKit)

@property (nonatomic) UIImage *image, *backgroundImage,
                              *selectedImage, *selectedBackgroundImage;

@property (nonatomic) NSString *title, *selectedTitle;

- (void)setImageName:(NSString *)imageName;
- (void)setBackgroundImageName:(NSString *)backgroundImageName;

- (void)setSelectedImageName:(NSString *)imageName;
- (void)setSelectedBackgroundImageName:(NSString *)backgroundImageName;

- (void)setImageNamed:(NSString *)imageName forState:(UIControlState)state;
- (void)setBackgroundImageNamed:(NSString *)imageName forState:(UIControlState)state;

@end
