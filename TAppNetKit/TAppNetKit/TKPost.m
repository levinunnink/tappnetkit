//
//  ANPost.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKPost.h"
#import "NSObject+AssociatedObject.h"

@implementation TKPost

@dynamic createdAt;
@dynamic canonicalURL;
@dynamic text;
@dynamic HTML;
@dynamic entities;
@dynamic entitiesRepresentation;
@dynamic replyTo;
@dynamic threadID;
@dynamic numberOfReplies;
@dynamic annotationRepresentations;
@dynamic deleted;
@dynamic user;
@dynamic userRepresentation;
@dynamic source;
@dynamic sourceRepresentation;
@dynamic machineOnly;
@dynamic numberOfStars;
@dynamic youStarred;
@dynamic starredByRepresentation;
@dynamic numberOfReposts;
@dynamic youReposted;
@dynamic reposters;
@dynamic repostersRepresentation;
@dynamic repostOf;
@dynamic repostOfRepresentation;

- (TKAnnotationSet *)annotations {
    // We use an associated object here so that setRepresentation: will clear it.
    TKAnnotationSet * annotations = [self associatedObjectForKey:_cmd];
    if(!annotations) {
        annotations = [[TKAnnotationSet alloc] initWithRepresentation:self.annotationRepresentations session:self.session];
        [self setAssociatedObject:annotations forKey:_cmd];
    }
    return annotations;
}

- (NSArray *)starredBy {
    if(self.starredByRepresentation == nil) {
        return nil;
    }
    
    NSMutableArray * array = [NSMutableArray new];
    
    for(NSDictionary * rep in self.starredByRepresentation) {
        [array addObject:[[TKUser alloc] initWithRepresentation:rep session:self.session]];
    }
    
    return array;
}

- (TKDraft*)draftForward {
    TKDraft * draft = [TKDraft new];
    
    draft.text = [NSString stringWithFormat:@"» %@ %@", self.user.username.appNetUsernameString, self.text];
    [draft.entities.links addObjectsFromArray:[self.entities.links valueForKey:@"draftEntity"]];
    
    return draft;
}

- (TKDraft*)draftCopy {
    TKDraft * draft = [TKDraft new];
    
    draft.text = self.text;
    draft.replyTo = self.replyTo;
    [draft.annotations setArray:[self.annotations.all valueForKey:@"draftAnnotation"]];
    
    draft.machineOnly = self.machineOnly;
    
    if(self.machineOnly) {
        [draft.entities.mentions addObjectsFromArray:[self.entities.mentions valueForKey:@"draftEntity"]];
    }
    else {
        [draft.entities.links addObjectsFromArray:[self.entities.links valueForKey:@"draftEntity"]];
    }
    
    return draft;
}

- (NSMutableOrderedSet*)mentionsForDirectReply {
    NSMutableOrderedSet * mentions = self.repostOf ? [self.repostOf mentionsForDirectReply] : [NSMutableOrderedSet new];
    
    [mentions addObject:self.user.username.appNetUsernameString];
    
    return mentions;
}

- (TKDraft*)draftReply {
    TKDraft * draft = [TKDraft new];
    
    draft.text = [[self.mentionsForDirectReply.array componentsJoinedByString:@" "] stringByAppendingString:@" "];
    draft.replyTo = self.originalID;
    
    return draft;
}

- (TKDraft*)draftReplyToAllExcept:(BOOL (^)(TKEntity * mention))rejectionBlock {
    TKDraft * draft = [self draftReply];
    
    NSMutableOrderedSet * usernames = self.mentionsForDirectReply;
    for(TKEntity * mention in self.entities.mentions) {
        if(!rejectionBlock(mention)) {
            [usernames addObject:mention.name.appNetUsernameString];
        }
    }
    
    draft.text = [[usernames.array componentsJoinedByString:@" "] stringByAppendingString:@" "];
    
    return draft;
}

- (TKDraft*)draftReplyToAllExceptUser:(TKUser*)user {
    return [self draftReplyToAllExcept:^BOOL(TKEntity *mention) {
        return mention.userID == user.ID;
    }];
}

- (TKDraft*)draftReplyToAllExceptUsername:(NSString*)username {
    return [self draftReplyToAllExcept:^BOOL(TKEntity *mention) {
        return [mention.name isEqualToString:username];
    }];
}

- (void)postRepliedToWithCompletion:(TKPostRequestCompletion)completion {
    [self.session postWithID:self.originalPost.replyTo completion:completion];
}

- (void)replyPostsWithCompletion:(TKPostListRequestCompletion)completion {
    [self.session postsReplyingToPostWithID:self.originalID betweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postAtThreadRootWithCompletion:(TKPostRequestCompletion)completion {
    [self.session postWithID:self.originalPost.threadID completion:completion];
}

- (void)deleteWithCompletion:(TKPostRequestCompletion)completion {
    [self.session deletePostWithID:self.ID completion:completion];
}

- (void)starWithCompletion:(TKPostRequestCompletion)completion {
    [self.session starPostWithID:self.originalID completion:completion];
}

- (void)unstarWithCompletion:(TKPostRequestCompletion)completion {
    [self.session unstarPostWithID:self.originalID completion:completion];
}

- (void)usersWithPostStarredWithCompletion:(TKUserListRequestCompletion)completion {
    [self.session usersWithPostWithIDStarred:self.originalID completion:completion];
}

+ (NSSet *)keyPathsForValuesAffectingOriginalID {
    return [NSSet setWithObject:@"originalPost.ID"];
}

- (TKResourceID)originalID {
    return self.originalPost.ID;
}

+ (NSSet *)keyPathsForValuesAffectingOriginalPost {
    return [NSSet setWithObject:@"repostOf"];
}

- (TKPost *)originalPost {
    if(self.repostOf) {
        return self.repostOf;
    }
    return self;
}

- (void)repostWithCompletion:(TKPostRequestCompletion)completion {
    [self.session repostPostWithID:self.originalID completion:completion];
}

- (void)unrepostWithCompletion:(TKPostRequestCompletion)completion {
    [self.session unrepostPostWithID:self.originalID completion:completion];
}

- (void)usersWithPostRepostedWithCompletion:(TKUserListRequestCompletion)completion {
    [self.session usersWithPostWithIDReposted:self.originalID completion:completion];
}

@end
