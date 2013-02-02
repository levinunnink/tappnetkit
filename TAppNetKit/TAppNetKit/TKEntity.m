//
//  ANEntity.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/22/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKEntity.h"

#import "NSObject+AssociatedObject.h"

const NSRange ANEntityNoRange = (NSRange){ NSNotFound, 0 };

@interface TKEntity ()

+ (NSArray*)entitiesWithRepresentations:(NSArray*)reps session:(TKSession*)session;

@property (readonly) TKResourceID ID;

@end

@interface ANMentionEntity : TKEntity @end
@interface ANTagEntity : TKEntity @end
@interface ANLinkEntity : TKEntity @end

@implementation TKEntitySet

@dynamic mentionRepresentations;
@dynamic tagRepresentations;
@dynamic linkRepresentations;

- (NSArray *)mentions {
    return [ANMentionEntity entitiesWithRepresentations:self.mentionRepresentations session:self.session];
}

- (NSArray *)tags {
    return [ANTagEntity entitiesWithRepresentations:self.tagRepresentations session:self.session];
}

- (NSArray *)links {
    return [ANLinkEntity entitiesWithRepresentations:self.linkRepresentations session:self.session];
}

- (NSArray *)all {
    // We use associated objects here because associated objects are cleared when the representation is set.
    NSArray * ret = [self associatedObjectForKey:_cmd];
    
    if(!ret) {
        NSMutableArray * allEntities = [NSMutableArray new];
        
        NSMutableArray * groupedEntities = [NSMutableArray arrayWithObjects:
                                            self.mentions.mutableCopy,
                                            self.tags.mutableCopy,
                                            self.links.mutableCopy,
                                            nil];
        
        for(NSMutableArray * someEntities in groupedEntities.copy) {
            if(someEntities.count == 0) {
                [groupedEntities removeObject:someEntities];
            }
        }
        
        while(groupedEntities.count) {
            NSMutableArray * nextEntityArray;
            
            for(NSMutableArray * someEntities in groupedEntities) {
                if(!nextEntityArray) {
                    nextEntityArray = someEntities;
                    continue;
                }
                if([[nextEntityArray objectAtIndex:0] range].location > [[someEntities objectAtIndex:0] range].location) {
                    nextEntityArray = someEntities;
                    continue;
                }
            }
            
            [allEntities addObject:[nextEntityArray objectAtIndex:0]];
            [nextEntityArray removeObjectAtIndex:0];
            
            if(nextEntityArray.count == 0) {
                [groupedEntities removeObject:nextEntityArray];
            }
        }
        
        ret = allEntities.copy;
        
        [self setAssociatedObject:ret forKey:_cmd];
    }
    
    return ret;
}

- (TKDraftEntitySet *)draftEntitySet {
    TKDraftEntitySet * draftSet = [TKDraftEntitySet new];
    
    [draftSet.links addObjectsFromArray:[self.links valueForKey:@"draftEntity"]];
    [draftSet.mentions addObjectsFromArray:[self.mentions valueForKey:@"draftEntity"]];
    
    return draftSet;
}

@end

@implementation TKEntity

- (NSUInteger)_location {
    return self.range.location;
}

+ (NSArray *)entitiesWithRepresentations:(NSArray *)reps session:(TKSession *)session {
    NSMutableArray * entities = [NSMutableArray new];
    for(NSDictionary * rep in reps) {
        [entities addObject:[[self alloc] initWithRepresentation:rep session:session]];
    }
    return entities.copy;
}

@dynamic entityType;
@dynamic URL;
@dynamic name;
@dynamic text;
@dynamic ID;

- (NSRange)range {
    if(![self.representation objectForKey:@"pos"]) {
        return ANEntityNoRange;
    }
    
    return NSMakeRange([[self.representation objectForKey:@"pos"] unsignedIntegerValue],
                       [[self.representation objectForKey:@"len"] unsignedIntegerValue]);
}

- (TKResourceID)userID {
    return self.ID;
}

- (TKDraftEntity *)draftEntity {
    TKDraftEntity * draft = [TKDraftEntity new];
    
    if(!NSEqualRanges(self.range, ANEntityNoRange)) {
        draft.range = self.range;
    }
    
    return draft;
}

@end

@implementation ANMentionEntity

- (TKEntityType)entityType {
    return ANEntityTypeMention;
}

- (NSString *)text {
    return self.name.appNetUsernameString;
}

- (NSURL *)URL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://alpha.app.net/%@", self.name]];
}

- (TKDraftEntity *)draftEntity {
    TKDraftEntity * draft = [super draftEntity];
    draft.userID = self.userID;
    draft.name = self.name;
    return draft;
}

@end

@implementation ANTagEntity

- (TKEntityType)entityType {
    return ANEntityTypeTag;
}

- (NSString *)text {
    return self.name.appNetTagString;
}

- (NSURL *)URL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://alpha.app.net/hashtags/%@", self.name]];
}

- (TKDraftEntity *)draftEntity {
    return nil;
}

@end

@implementation ANLinkEntity

- (TKEntityType)entityType {
    return ANEntityTypeLink;
}

- (TKDraftEntity *)draftEntity {
    TKDraftEntity * draft = [super draftEntity];
    draft.URL = self.URL;
    return draft;
}

@end

@implementation TKDraftEntitySet

- (id)init {
    if((self = [super init])) {
        _links = [NSMutableArray new];
        _mentions = [NSMutableArray new];
    }
    return self;
}

- (NSUInteger)addLinkEntityWithURL:(NSURL*)url range:(NSRange)range {
    NSUInteger i = self.links.count;
    
    TKDraftEntity * entity = [TKDraftEntity new];
    entity.URL = url;
    entity.range = range;
    
    [self.links insertObject:entity atIndex:i];
    
    return i;
}

- (NSUInteger)addMentionEntityForUsername:(NSString*)username {
    NSUInteger i = self.mentions.count;
    
    TKDraftEntity * entity = [TKDraftEntity new];
    entity.name = username;
    
    [self.mentions insertObject:entity atIndex:i];
    
    return i;
}

- (NSUInteger)addMentionEntityForUserID:(TKResourceID)userID {
    NSUInteger i = self.mentions.count;
    
    TKDraftEntity * entity = [TKDraftEntity new];
    entity.userID = userID;
    
    [self.mentions insertObject:entity atIndex:i];
    
    return i;
}

- (NSUInteger)addMentionEntityForUser:(TKUser*)user {
    NSUInteger i = self.mentions.count;
    
    TKDraftEntity * entity = [TKDraftEntity new];
    entity.name = user.username;
    entity.userID = user.ID;
    
    [self.mentions insertObject:entity atIndex:i];
    
    return i;
}

- (void)removeAllEntities {
    [self.links removeAllObjects];
    [self.mentions removeAllObjects];
}

- (NSDictionary *)representation {
    NSMutableDictionary * rep = [NSMutableDictionary new];
    
    if(self.links.count) {
        [rep setObject:[self.links valueForKey:@"representation"] forKey:@"links"];
    }
    if(self.mentions.count) {
        [rep setObject:[self.mentions valueForKey:@"representation"] forKey:@"mentions"];
    }
    
    if(!rep.count) {
        return nil;
    }
    
    return rep;
}

- (void)setRepresentation:(NSDictionary *)rep {
    [self removeAllEntities];
    
    for(NSDictionary * entityRep in [rep objectForKey:@"links"]) {
        TKDraftEntity * draftEntity = [TKDraftEntity new];
        draftEntity.representation = entityRep;
        
        [self.links addObject:draftEntity];
    }

    for(NSDictionary * entityRep in [rep objectForKey:@"mentions"]) {
        TKDraftEntity * draftEntity = [TKDraftEntity new];
        draftEntity.representation = entityRep;
        
        [self.mentions addObject:draftEntity];
    }
}

@end

@implementation TKDraftEntity

- (id)init {
    if((self = [super init])) {
        _range = ANEntityNoRange;
    }
    return self;
}

- (NSDictionary *)representation {
    NSMutableDictionary * rep = [NSMutableDictionary new];
    
    if(self.URL) {
        [rep setObject:self.URL.absoluteString forKey:@"url"];
    }
    if(self.name) {
        [rep setObject:self.name forKey:@"name"];
    }
    if(self.userID != 0) {
        [rep setObject:[ANResource.IDFormatter stringFromNumber:[NSNumber numberWithUnsignedLongLong:self.userID]]  forKey:@"id"];
    }
    if(!NSEqualRanges(self.range, ANEntityNoRange)) {
        [rep setObject:[NSString stringWithFormat:@"%d", self.range.location] forKey:@"pos"];
        [rep setObject:[NSString stringWithFormat:@"%d", self.range.length] forKey:@"len"];
    }
    
    return rep;
}

- (void)setRepresentation:(NSDictionary *)rep {
    self.URL = [NSURL URLWithString:[rep objectForKey:@"url"]];
    self.name = [rep objectForKey:@"name"];
    self.userID = [[ANResource.IDFormatter numberFromString:[rep objectForKey:@"id"]] unsignedLongLongValue];
    
    if([rep objectForKey:@"pos"]) {
        self.range = NSMakeRange([[rep objectForKey:@"pos"] integerValue], [[rep objectForKey:@"len"] integerValue]);
    }
    else {
        self.range = ANEntityNoRange;
    }
}

@end
