//
//  TZNotificationHelpersSpec.m
//  TZShortKit
//
//  Created by Tadeu Zagallo on 1/2/14.
//  Copyright (c) 2014 Tadeu Zagallo. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NotificationHelpers.h"

@interface NotificationHelpers()

@property(nonatomic, strong) NSMutableDictionary *listeners;

@end

SPEC_BEGIN(NotificaitonHelpers)
    NSString *event = @"event";
    NSString *anotherEvent = @"anotherEvent";
    NSString *selString = @"onEvent:";

    __block BOOL called = NO;
    id mock = [NSObject mock];
    __block NSDictionary *userInfo;

    NotificationBlock block = ^void(NSNotification *notification) {
        called = YES;
        userInfo = notification.userInfo;
    };

    NotificationBlock anotherBlock = ^void(NSNotification *notification){
        called = YES;
    };

describe(@"On", ^{
    beforeAll(^{
        On(event, block);
    });

    it(@"Should add a notification to queue", ^{
        [[theValue([NotificationHelpers sharedHelper].listeners.count) should] equal:theValue(1)];
    });
    
    it(@"Should list by event name", ^{
        NSMutableArray *listeners = [NotificationHelpers sharedHelper].listeners[event];
        [[theValue(listeners.count) should] equal:theValue(1)];
    });
});

describe(@"Trigger", ^{
    it(@"Shouldn't have been triggered so far", ^{
        [[@(called) should] beNo];
    });
    
    it(@"Should trigger block", ^{
        Trigger(event);
        [[@(called) should] beYes];
    });
    
    it(@"Should trigger selector", ^{
        [[mock should] receive:NSSelectorFromString(selString) withCount:1];
        
        On(event, mock, selString);
        Trigger(event);
    });
    
    it(@"Should respect object scope", ^{
        called = NO;
        On(anotherEvent, mock, anotherBlock);
        
        Trigger(anotherEvent);
        [[@(called) should] beNo];
        
        Trigger(mock, anotherEvent);
        [[@(called) should] beYes];
    });
    
    it(@"Should pass dictionaries as UserInfo", ^{
        Trigger(event, @{ @"key": @"value" });
        [[userInfo[@"key"] should] equal:@"value"];
    });
});

describe(@"Off", ^{
    __block NSMutableArray *listeners;
    __block NSInteger count;
    
    beforeEach(^{
        listeners = [NotificationHelpers sharedHelper].listeners[event];
        count = listeners.count;
    });
    
    it(@"Should remove one block from an event", ^{
        [[theValue([listeners indexOfObject:block]) shouldNot] equal:theValue(NSNotFound)];
        
        Off(event, block);
        
        [[theValue(listeners.count) should] equal:theValue(count - 1)];
        [[theValue([listeners indexOfObject:block]) should] equal:theValue(NSNotFound)];
    });
    
    it(@"Should remove one selector from an event", ^{
        Off(event, mock, selString);
        
        [[theValue(listeners.count) should] equal:theValue(count - 1)];
    });
    
    it(@"Should clear an event", ^{
        NSMutableDictionary *listeners = [NotificationHelpers sharedHelper].listeners;
        
        [[listeners[anotherEvent] shouldNot] beNil];
        [[theValue([listeners[anotherEvent] count]) should] beGreaterThan:theValue(0)];
        
        Off(anotherEvent);
        
        [[[NotificationHelpers sharedHelper].listeners[anotherEvent] should] beNil];
    });
       
    it(@"Should automatically clear on empty event", ^{
        Off(event);
        
        On(event, block);
        
        [[theValue([[NotificationHelpers sharedHelper].listeners[event] count]) should] equal:theValue(1)];
        
        Off(event, block);
        
        [[[NotificationHelpers sharedHelper].listeners[event] should] beNil];
    });
       
    it(@"Should not call removed listeners", ^{
        called = NO;
        
        Trigger(event);
        [[@(called) should] beNo];
        
        [[mock shouldNot] receive:NSSelectorFromString(selString)];
        Trigger(mock, anotherEvent);
    });
});

SPEC_END