//
//  NotificationHelpers.m
//  TZShortKit
//
//  Created by Tadeu Zagallo on 9/25/13.
//  Copyright (c) 2013 Tadeu Zagallo. All rights reserved.
//

#import <objc/runtime.h>

#import "NotificationHelpers.h"

@interface NotificationHelpers()

@property (nonatomic, strong) NSMutableDictionary *listeners;

- (void)_proxy:(NSNotification *)notification;

@end

@implementation NotificationObject
- (id)initWithTarget:(id)target selector:(SEL)sel {
    self = [super init];
    if (self) {
        self.target = target;
        self.selector = sel;
    }
    return self;
}
@end

@implementation NotificationHelpers

#pragma mark - Getters

- (NSMutableDictionary *)listeners {
    if (!_listeners) {
        _listeners = [NSMutableDictionary dictionary];
    }
    
    return _listeners;
}

#pragma mark - Private Methods
#pragma mark Instance Methods

- (void)_proxy:(NSNotification *)notification {
    NSString *event = notification.name;
    
    NSMutableArray *listeners = self.listeners[event];
    
    for (id observer in listeners) {
        id object = objc_getAssociatedObject(observer, @"object");
        
        if (object && notification.object != object) {
            continue;
        }
        
        if ([observer isKindOfClass:NSClassFromString(@"NSBlock")]) {
            ((NotificationBlock)observer)(notification);
        } else if ([observer isKindOfClass:[NotificationObject class]]) {
            NotificationObject *o = observer;
            [o.target performSelector:o.selector withObject:notification];
        }
        
        NSNumber *one = objc_getAssociatedObject(observer, @"one");
        
        if (one.boolValue) {
            [listeners removeObject:observer];
        }
    }
    
    self.listeners[event] = listeners;
}

#pragma mark - Public Methods
#pragma mark Class Methods

+ (instancetype)sharedHelper {
    static id _instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

#pragma mark Instance Methods

- (void)listenFor:(NSString *)event with:(id)observer object:(id)object one:(BOOL)one {
    NSMutableArray *listeners = self.listeners[event];
    
    if (!listeners) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_proxy:) name:event object:nil];
        listeners = [NSMutableArray array];
    }
    
    objc_setAssociatedObject(observer, @"one", @(one), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(observer, @"object", object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [listeners addObject:observer];
    self.listeners[event] = listeners;
}

- (void)silence:(NSString *)event {
    [self.listeners removeObjectForKey:event];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:event object:nil];
}

- (void)silence:(NSString *)event with:(id)observer {
    NSMutableArray *listeners = self.listeners[event];
    
    [listeners removeObject:observer];
    
    if (!listeners.count) {
        [self silence:event];
    } else {
        self.listeners[event] = listeners;
    }
}

- (void)silence:(NSString *)event with:(id)observer selector:(SEL)sel {
    NSMutableArray *listeners = self.listeners[event];
    
    for (NotificationObject *o in listeners) {
        if ([o isKindOfClass:[NotificationObject class]]) {
            if (o.target == observer && o.selector == sel) {
                [listeners removeObject:o];
                break;
            }
        }
    }
    
    if (!listeners.count) {
        [self silence:event];
    } else {
        self.listeners[event] = listeners;
    }
}

@end
