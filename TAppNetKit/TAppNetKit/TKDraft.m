//
//  ANDraft.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/23/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKDraft.h"
#import "TKResource.h"

@implementation TKDraft

- (id)init {
    if((self = [super init])) {
        _annotations = [NSMutableArray new];
        _entities = [TKDraftEntitySet new];
    }
    return self;
}

- (NSDictionary *)representation {
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    if(self.machineOnly) {
        [dict setObject:@"1" forKey:@"machine_only"];
    }
    else {
        [dict setObject:self.text forKey:@"text"];
    }
    
    if(self.replyTo) {
        [dict setObject:[NSString stringWithFormat:@"%llu", self.replyTo] forKey:@"reply_to"];
    }
    if(self.annotations.count) {
        [dict setObject:[self.annotations valueForKey:@"representation"] forKey:@"annotations"];
    }
    
    id entitiesRep = self.entities.representation;
    if(entitiesRep) {
        [dict setObject:entitiesRep forKey:@"entities"];
    }
    
    return dict.copy;
}

- (void)setRepresentation:(NSDictionary *)dict {
    self.text = [dict objectForKey:@"text"];
    
    self.replyTo = ANUnspecifiedPostID;
    if([dict objectForKey:@"reply_to"]) {
        self.replyTo = [TKResource.IDFormatter numberFromString:[dict objectForKey:@"reply_to"]].unsignedLongLongValue;
    }
    
    [self.annotations removeAllObjects];
    if([dict objectForKey:@"annotations"]) {
        for(NSDictionary * annotationRep in [dict objectForKey:@"annotations"]) {
            TKDraftAnnotation * annotation = [TKDraftAnnotation new];
            annotation.representation = annotationRep;
            [self.annotations addObject:annotation];
        }
    }
    
    self.entities.representation = [dict objectForKey:@"entities"];
}

- (void)createPostViaSession:(TKSession*)session completion:(TKPostRequestCompletion)completion {
    [session createPostFromDraft:self completion:completion];
}

@end
