//
//  ANStreamMarker.m
//  Alef
//
//  Created by Brent Royal-Gordon on 11/13/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "TKStreamMarker.h"
#import "ANSession+Requests.h"

const NSUInteger TKStreamMarkerUnspecifiedPercentage = 0;

@interface TKStreamMarker ()

@property (nonatomic,readonly) TKResourceID ID;

@end

@implementation TKStreamMarker

@dynamic name;
@dynamic ID;
@dynamic percentage;
@dynamic updatedAt;
@dynamic version;

- (TKResourceID)postID {
    return self.ID;
}

- (BOOL)isMarked {
    return [self.representation objectForKey:@"id"] != nil;
}

- (TKDraftStreamMarker*)draftStreamMarkerWithPostID:(TKResourceID)postID percentage:(NSUInteger)percentage {
    TKDraftStreamMarker * draft = [TKDraftStreamMarker new];
    
    draft.name = self.name;
    draft.postID = postID;
    draft.percentage = percentage;
    
    return draft;
}

- (void)updateWithPostID:(TKResourceID)postID percentage:(NSUInteger)percentage completion:(TKStreamMarkerRequestCompletion)completion {
    [[self draftStreamMarkerWithPostID:postID percentage:percentage] updateViaSession:self.session completion:completion];
}

@end

@implementation TKDraftStreamMarker

- (NSDictionary *)representation {
    NSMutableDictionary * rep = [NSMutableDictionary new];
    
    [rep setObject:self.name forKey:@"name"];
    if(self.postID) {
        [rep setObject:[ANResource.IDFormatter stringFromNumber:[NSNumber numberWithUnsignedLongLong:self.postID]] forKey:@"id"];
    }
    if(self.percentage) {
        [rep setObject:[NSString stringWithFormat:@"%d", self.percentage] forKey:@"percentage"];
    }
    
    return rep;
}

- (void)setRepresentation:(NSDictionary *)rep {
    self.name = [rep objectForKey:@"name"];
    self.postID = [[ANResource.IDFormatter numberFromString:[rep objectForKey:@"id"]] unsignedLongLongValue];
    self.percentage = [[rep objectForKey:@"percentage"] integerValue];
}

- (void)updateViaSession:(TKSession *)session completion:(TKStreamMarkerRequestCompletion)completion {
    [session updateStreamMarkerWithDraft:self completion:completion];
}

@end