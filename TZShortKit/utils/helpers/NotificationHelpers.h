//
//  NotificationHelpers.h
//  TZShortKit
//
//  Created by Tadeu Zagallo on 9/25/13.
//  Copyright (c) 2013 Tadeu Zagallo. All rights reserved.
//

#include <stdarg.h>

#define PP_NARG(...) PP_NARG_(__VA_ARGS__, PP_MAX())
#define PP_MAX() 3, 2, 1
#define PP_NARG_(...) PP_X(__VA_ARGS__)
#define PP_X(_1, _2, _3, N, ...) N

typedef void(^NotificationBlock)(NSNotification *);

@interface NotificationHelpers : NSObject

+ (instancetype)sharedHelper;

- (void)listenFor:(NSString *)event with:(NotificationBlock)observer object:(id)object one:(BOOL)one;
- (void)silence:(NSString *)event;
- (void)silence:(NSString *)event with:(NotificationBlock)observer;

@end

#define TZOne(event...) _TZOn(PP_NARG(event), YES, event)

#define TZOn(event...) _TZOn(PP_NARG(event), NO, event)

static inline void _TZOn(int count, BOOL one, NSString *event, ...) {
    id observer = nil,
       object = nil;
    
    va_list ap;
    va_start(ap, event);
    
    if (count == 2) {
        observer = va_arg(ap, id);
    } else {
        object = va_arg(ap, id);
        observer = va_arg(ap, id);
    }
    
    va_end(ap);
    
    [[NotificationHelpers sharedHelper] listenFor:event with:observer object:object one:NO];
}

#define TZOff(event...) _TZOff(PP_NARG(event), event)

static inline void _TZOff(int count, NSString *event, ...) {
    if (count == 1) {
        NSLog(@"No observer provided");
        [[NotificationHelpers sharedHelper] silence:event];
    } else {
        va_list ap;
        va_start(ap, event);
        NotificationBlock observer = va_arg(ap, NotificationBlock);
        va_end(ap);
        NSLog(@"Observer provided: %@", observer);
        [[NotificationHelpers sharedHelper] silence:event with:observer];
    }
}

#define TZTrigger(event...) _TZTrigger(PP_NARG(event), self, event)


static inline void _TZTrigger(int count, id _self, NSString *event, ...) {
    id object = nil;
    
    if (count > 1) {
        va_list ap;
        va_start(ap, event);
        object = va_arg(ap, id);
        va_end(ap);
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:event object:_self userInfo:object];
}