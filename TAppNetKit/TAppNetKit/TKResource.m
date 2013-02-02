//
//  ANRepresentation.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKResource.h"
#import "ISO8601DateFormatter.h"
#import "TKSession.h"
#import "TKSession+TKResource_Private.h"

#import "NSObject+AssociatedObject.h"

NSString * const TKResourceDidUpdateNotification = @"TKResourceDidUpdate";

@implementation TKResource

+ (ISO8601DateFormatter *)dateFormatter {
    static ISO8601DateFormatter * singleton;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        singleton = [ISO8601DateFormatter new];
    });
    
    return singleton;
}

+ (NSNumberFormatter *)IDFormatter {
    static NSNumberFormatter * singleton;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        singleton = [NSNumberFormatter new];
    });
    
    return singleton;
}

- (id)initWithRepresentation:(NSDictionary *)rep session:(TKSession *)session {
    NSParameterAssert(session);
    
    if(!rep) {
        self = nil;
    }
    
    if((self = [super init])) {
        _session = session;
        _representation = rep.copy;
    }
    return self;
}

- (void)setRepresentation:(NSDictionary *)representation {
    if([representation isEqualToDictionary:_representation]) {
        return;
    }
    
    [self willChangeValueForKey:@"representation"];
    
    _representation = representation;
    [self removeAllAssociatedObjects];
        
    [self didChangeValueForKey:@"representation"];
    
    NSNotification * note = [NSNotification notificationWithName:TKResourceDidUpdateNotification object:self];
    [NSNotificationQueue.defaultQueue enqueueNotification:note postingStyle:NSPostASAP coalesceMask:NSNotificationCoalescingOnName|NSNotificationCoalescingOnSender forModes:nil];
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if([key isEqualToString:@"representation"]) {
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

- (NSUInteger)hash {
    return (NSUInteger)self.representation.hash ^ (NSUInteger)self.class;
}

- (BOOL)isEqual:(TKResource*)object {
    if(self.class != object.class) {
        return NO;
    }
    
    return [self.representation isEqual:object.representation];
}

@end
