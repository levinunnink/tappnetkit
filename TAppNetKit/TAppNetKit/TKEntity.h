//
//  ANEntity.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/22/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKResource.h"
#import "AppNetKit.h"

extern const NSRange ANEntityNoRange;

typedef enum {
    ANEntityTypeMention,
    ANEntityTypeTag,
    ANEntityTypeLink
} TKEntityType;

@class TKDraftEntitySet;
@class TKDraftEntity;

@interface TKEntitySet : TKResource

@property (readonly) NSArray * all;

@property (readonly) NSArray * mentions;
@property (readonly) NSArray * mentionRepresentations;

@property (readonly) NSArray * tags;
@property (readonly) NSArray * tagRepresentations;

@property (readonly) NSArray * links;
@property (readonly) NSArray * linkRepresentations;

- (TKDraftEntitySet*)draftEntitySet;

@end

@interface TKEntity : TKResource

@property (readonly) TKEntityType entityType;
@property (readonly) NSRange range;

@property (readonly) NSString * name;
@property (readonly) TKResourceID userID;

@property (readonly) NSURL * URL;
@property (readonly) NSString * text;

- (TKDraftEntity*)draftEntity;

@end

@interface TKDraftEntitySet : NSObject

@property (readonly) NSMutableArray * links;
@property (readonly) NSMutableArray * mentions;

@property (copy) NSDictionary * representation;

- (NSUInteger)addLinkEntityWithURL:(NSURL*)url range:(NSRange)range;

- (NSUInteger)addMentionEntityForUsername:(NSString*)username;
- (NSUInteger)addMentionEntityForUserID:(TKResourceID)userID;
- (NSUInteger)addMentionEntityForUser:(TKUser*)user;

- (void)removeAllEntities;

@end

@interface TKDraftEntity : NSObject

@property (assign) NSRange range;

@property (strong) NSURL * URL;
@property (strong) NSString * name;
@property (assign) TKResourceID userID;

@property (copy) NSDictionary * representation;

@end

