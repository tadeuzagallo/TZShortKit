//
//  NotificationHelpers.h
//  TZShortKit
//
//  Created by Tadeu Zagallo on 9/25/13.
//  Copyright (c) 2013 Tadeu Zagallo. All rights reserved.
//

#include <stdarg.h>

#define PP_NARG(...) PP_NARG_(__VA_ARGS__, PP_MAX())
#define PP_MAX() 2, 1
#define PP_NARG_(...) PP_X(__VA_ARGS__)
#define PP_X(_1, _2, N, ...) N

typedef void(^NotificationBlock)(NSNotification *);

@interface NotificationHelpers : NSObject

+ (instancetype)sharedHelper;

- (void)listenFor:(NSString *)key with:(NotificationBlock)observer one:(BOOL)one;
- (void)silence:(NSString *)key;
- (void)silence:(NSString *)key with:(NotificationBlock)observer;

@end

static inline void TZOn(NSString *key, NotificationBlock observer) {
    [[NotificationHelpers sharedHelper] listenFor:key with:observer one:NO];
}

static inline void TZOne(NSString *key, NotificationBlock observer) {
    [[NotificationHelpers sharedHelper] listenFor:key with:observer one:YES];
}

#define TZOff(key...) _TZOff(PP_NARG(key), key)

static inline void _TZOff(int count, NSString *key, ...) {
    if (count == 1) {
        NSLog(@"No observer provided");
        [[NotificationHelpers sharedHelper] silence:key];
    } else {
        va_list ap;
        va_start(ap, key);
        NotificationBlock observer = va_arg(ap, NotificationBlock);
        va_end(ap);
        NSLog(@"Observer provided: %@", observer);
        [[NotificationHelpers sharedHelper] silence:key with:observer];
    }
}

#define TZTrigger(key...) _TZTrigger(PP_NARG(__VA_ARGS__), __VA_ARGS__)


static inline void _TZTrigger(int count, NSString *key, ...) {
    id object = nil;
    
    if (count == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:key object:nil];
        va_list ap;
        va_start(ap, key);
        object = va_arg(ap, id);
        va_end(ap);
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:key object:object];
}