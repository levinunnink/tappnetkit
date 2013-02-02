//
//  ANPost.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKIdentifiedResource.h"
#import "TKSession.h"

@class TKDraft;
@class TKSource;
@class TKAnnotationSet;

@interface TKPost : TKIdentifiedResource <TKTextualResource>

@property (readonly) TKUser * user;
@property (readonly) NSDictionary * userRepresentation;
@property (readonly) NSDate * createdAt;
@property (readonly) NSURL * canonicalURL;

@property (readonly) TKAnnotationSet * annotations;
@property (readonly) NSArray * annotationRepresentations;

@property (readonly) TKSource * source;
@property (readonly) NSDictionary * sourceRepresentation;

@property (readonly) BOOL machineOnly;

// self.repostOf if this is a repost, self otherwise.
@property (readonly) TKPost * originalPost;
@property (readonly) TKResourceID originalID;

@property (readonly) TKResourceID replyTo;
- (void)postRepliedToWithCompletion:(TKPostRequestCompletion)completion;
- (void)replyPostsWithCompletion:(TKPostListRequestCompletion)completion;

@property (readonly) TKResourceID threadID;
@property (readonly) NSUInteger numberOfReplies;
- (void)postAtThreadRootWithCompletion:(TKPostRequestCompletion)completion;

@property (readonly,getter=isDeleted) BOOL deleted;
- (void)deleteWithCompletion:(TKPostRequestCompletion)completion;

@property (readonly) NSUInteger numberOfStars;
@property (readonly) BOOL youStarred;

// Note: will be nil unless your request has includeStarredBy = YES. (The default is NO.)
@property (readonly) NSArray * starredBy;
@property (readonly) NSArray * starredByRepresentation;

- (void)starWithCompletion:(TKPostRequestCompletion)completion;
- (void)unstarWithCompletion:(TKPostRequestCompletion)completion;
- (void)usersWithPostStarredWithCompletion:(TKUserListRequestCompletion)completion;

@property (readonly) NSUInteger numberOfReposts;
@property (readonly) BOOL youReposted;

@property (readonly) NSArray * reposters;
@property (readonly) NSArray * repostersRepresentation;

@property (readonly) TKPost * repostOf;
@property (readonly) NSDictionary * repostOfRepresentation;

- (void)repostWithCompletion:(TKPostRequestCompletion)completion;
- (void)unrepostWithCompletion:(TKPostRequestCompletion)completion;
- (void)usersWithPostRepostedWithCompletion:(TKUserListRequestCompletion)completion;

- (TKDraft*)draftForward;
- (TKDraft*)draftCopy;

- (TKDraft*)draftReply;
// The exception is usually the user who will post the draft.
- (TKDraft*)draftReplyToAllExceptUser:(TKUser*)user;
- (TKDraft*)draftReplyToAllExceptUsername:(NSString*)username;

@end
