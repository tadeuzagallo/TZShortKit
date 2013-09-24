//
//  DeviceHelpers.c
//  TZShortKit
//
//  Created by Tadeu Zagallo on 9/24/13.
//  Copyright (c) 2013 Tadeu Zagallo. All rights reserved.
//

static inline BOOL IsRetinaScreen(void) {
    return [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.f;
}

static inline BOOL IsRetina4Screen(void) {
    return IsRetinaScreen() && [UIScreen mainScreen].bounds.size.height == 568.f;
}
