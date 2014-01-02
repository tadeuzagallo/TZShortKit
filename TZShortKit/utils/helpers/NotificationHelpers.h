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

@interface NotificationObject : NSObject
@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL selector;
- (id)initWithTarget:(id)target selector:(SEL)sel;
@end

@interface NotificationHelpers : NSObject

+ (instancetype)sharedHelper;

- (void)listenFor:(NSString *)event with:(id)observer object:(id)object one:(BOOL)one;
- (void)silence:(NSString *)event;
- (void)silence:(NSString *)event with:(id)observer;
- (void)silence:(NSString *)event with:(id)observer selector:(SEL)sel;

@end

#define One(...) TZOne(__VA_ARGS__)
#define TZOne(event...) _TZOn(PP_NARG(event), YES, event)

#define On(...) TZOn(__VA_ARGS__)
#define TZOn(event...) _TZOn(PP_NARG(event), NO, event)


static inline void _TZOn(int count, BOOL one, NSString *event, ...) {
    id observer = nil,
       object = nil;
    NSString *selector;
    
    va_list ap;
    va_start(ap, event);
    
    if (count == 2) {
        observer = va_arg(ap, id);
        [[NotificationHelpers sharedHelper] listenFor:event with:observer object:nil one:one];
    } else if (count == 3){
        object = va_arg(ap, id);
        observer = va_arg(ap, id);
        if ([observer isKindOfClass:[NSString class]]) {
            selector = (NSString *)observer;
            observer = [[NotificationObject alloc] initWithTarget:object selector:NSSelectorFromString(selector)];
            [[NotificationHelpers sharedHelper] listenFor:event with:observer object:nil one:one];
        } else {
            [[NotificationHelpers sharedHelper] listenFor:event with:observer object:object one:one];
        }
    } else if (count == 4) {
        observer = va_arg(ap, id);
        object = va_arg(ap, id);
        selector = va_arg(ap, NSString*);
        observer = [[NotificationObject alloc] initWithTarget:observer selector:NSSelectorFromString(selector)];
        [[NotificationHelpers sharedHelper] listenFor:event with:observer object:object one:one];
    }
    
    va_end(ap);
    
}

#define Off(...) TZOff(__VA_ARGS__)
#define TZOff(event...) _TZOff(PP_NARG(event), event)

static inline void _TZOff(int count, NSString *event, ...) {
    if (count == 1) {
        NSLog(@"No observer provided");
        [[NotificationHelpers sharedHelper] silence:event];
    } else {
        va_list ap;
        va_start(ap, event);
        id observer = va_arg(ap, id);
        if (count == 2) {
            [[NotificationHelpers sharedHelper] silence:event with:observer];
        } else if (count == 3) {
            NSString *selector = va_arg(ap, NSString *);
            [[NotificationHelpers sharedHelper] silence:event with:observer selector:NSSelectorFromString(selector)];
        }
        va_end(ap);
        NSLog(@"Observer provided: %@", observer);
    }
}

#define Trigger(...) TZTrigger(__VA_ARGS__)
#define TZTrigger(event...) _TZTrigger(PP_NARG(event), self, event)


static inline void _TZTrigger(int count, id _self, id event, ...) {
    id object = _self;
    id userInfo = nil;
    
    if (count > 1) {
        va_list ap;
        va_start(ap, event);
        userInfo = va_arg(ap, id);
        
        if ([userInfo isKindOfClass:[NSString class]]) {
            object = event;
            event = userInfo;

            if (count > 2) {
                userInfo = va_arg(ap, id);
            } else {
                userInfo = nil;
            }
        }
        
        va_end(ap);
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:event object:object userInfo:userInfo];
}