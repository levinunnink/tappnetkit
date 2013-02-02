//
//  ANStreamMarker.h
//  Alef
//
//  Created by Brent Royal-Gordon on 11/13/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "TKResource.h"
#import "ANDefines.h"
#import "ANCompletions.h"

extern const NSUInteger TKStreamMarkerUnspecifiedPercentage;
@class TKDraftStreamMarker;

@interface TKStreamMarker : TKResource

@property (nonatomic,readonly) NSString * name;
@property (nonatomic,readonly,getter=isMarked) BOOL marked;

@property (nonatomic,readonly) TKResourceID postID;
@property (nonatomic,readonly) NSUInteger percentage;

@property (nonatomic,readonly) NSDate * updatedAt;
@property (nonatomic,readonly) NSString * version;

- (TKDraftStreamMarker*)draftStreamMarkerWithPostID:(TKResourceID)postID percentage:(NSUInteger)percentage;
- (void)updateWithPostID:(TKResourceID)postID percentage:(NSUInteger)percentage completion:(TKStreamMarkerRequestCompletion)completion;

@end

@interface TKDraftStreamMarker : NSObject

@property (nonatomic,copy) NSString * name;
@property (nonatomic,assign) TKResourceID postID;
@property (nonatomic,assign) NSUInteger percentage;

@property (nonatomic,copy) NSDictionary * representation;

- (void)updateViaSession:(TKSession*)session completion:(TKStreamMarkerRequestCompletion)completion;

@end
