//
//  UIView+TZShortKit.h
//  TZShortKit
//
//  Created by Tadeu Zagallo on 9/19/13.
//  Copyright (c) 2013 Tadeu Zagallo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TZShortKit)

@property (nonatomic) CGFloat x, y, width, height, boundsX, boundsY, boundsHeight, boundsWidth;
@property (nonatomic) CGPoint origin, boundsOrigin;
@property (nonatomic) CGSize size, boundsSize;

- (void)addSubviews:(NSArray *)objects;

@end
