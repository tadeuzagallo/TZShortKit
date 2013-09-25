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
    NSString *key = notification.name;
    
    NSMutableArray *listeners = self.listeners[key];
    
    for (NotificationBlock observer in listeners) {
        observer(notification);
        
        NSNumber *one = objc_getAssociatedObject(observer, @"one");
        
        if (one.boolValue) {
            [listeners removeObject:observer];
        }
    }
    
    self.listeners[key] = listeners;
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

- (void)listenFor:(NSString *)key with:(NotificationBlock)observer one:(BOOL)one {
    NSMutableArray *listeners = self.listeners[key];
    
    if (!listeners) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_proxy:) name:key object:nil];
        listeners = [NSMutableArray array];
    }
    
    objc_setAssociatedObject(observer, @"one", @(one), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [listeners addObject:observer];
    self.listeners[key] = listeners;
}

- (void)silence:(NSString *)key {
    [self.listeners removeObjectForKey:key];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:key object:nil];
}

- (void)silence:(NSString *)key with:(NotificationBlock)observer {
    NSMutableArray *listeners = self.listeners[key];
    
    if (listeners.count == 1) {
        return [self silence:key];
    }
    
    [listeners removeObject:observer];
    self.listeners[key] = listeners;
}

@end
