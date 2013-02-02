//
//  TKSession+Requests.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKSession+Requests.h"
#import "TKAccessTokenInformationRequest.h"
#import "TKCreatePostRequest.h"
#import "TKDeletePostRequest.h"
#import "TKPostsByUserRequest.h"
#import "TKPostsReplyingToPostRequest.h"
#import "TKPostsInUserStreamRequest.h"
#import "TKPostsMentioningUserRequest.h"
#import "TKPostsInGlobalStreamRequest.h"
#import "TKPostsWithTagRequest.h"
#import "TKPostRequest.h"
#import "TKUserRequest.h"
#import "TKFollowUserRequest.h"
#import "TKUnfollowUserRequest.h"
#import "TKFollowingsForUserRequest.h"
#import "TKFollowersForUserRequest.h"
#import "TKMutingsForUserRequest.h"
#import "TKMuteUserRequest.h"
#import "TKUnmuteUserRequest.h"
#import "TKUsernameRequest.h"
#import "TKStarPostRequest.h"
#import "TKUnstarPostRequest.h"
#import "TKPostsStarredByUserRequest.h"
#import "TKUsersWithPostStarredRequest.h"
#import "TKRepostPostRequest.h"
#import "TKUnrepostPostRequest.h"
#import "TKUsersWithPostRepostedRequest.h"
#import "TKUsersMatchingSearchQueryRequest.h"
#import "TKFiltersForCurrentUserRequest.h"
#import "TKFilterRequest.h"
#import "TKCreateFilterRequest.h"
#import "TKDeleteFilterRequest.h"
#import "TKDeleteFiltersForUserRequest.h"
#import "TKUpdateFilterRequest.h"
#import "TKPostsInUserUnifiedStreamRequest.h"
#import "TKUpdateStreamMarkerRequest.h"

@implementation TKSession (Requests)

- (void)accessTokenInformationWithCompletion:(TKAccessTokenInformationRequestCompletion)completion {
    TKAccessTokenInformationRequest * req = [[TKAccessTokenInformationRequest alloc] initWithSession:self];
    
    [req sendRequestWithCompletion:completion];
}

- (void)userWithID:(TKResourceID)ID completion:(TKUserRequestCompletion)completion {
    TKUserRequest * req = [[TKUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)userWithUsername:(NSString *)username completion:(TKUserRequestCompletion)completion {
    TKUsernameRequest * req = [[TKUsernameRequest alloc] initWithSession:self];
    
    req.username = username;
    
    [req sendRequestWithCompletion:completion];
}

- (void)usersMatchingSearchQuery:(NSString *)query completion:(TKUserListRequestCompletion)completion {
    TKUsersMatchingSearchQueryRequest * req = [[TKUsersMatchingSearchQueryRequest alloc] initWithSession:self];
    
    req.query = query;
    
    [req sendRequestWithCompletion:completion];
}

- (void)followUserWithID:(TKResourceID)ID completion:(TKUserRequestCompletion)completion {
    TKFollowUserRequest * req = [[TKFollowUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)unfollowUserWithID:(TKResourceID)ID completion:(TKUserRequestCompletion)completion {
    TKUnfollowUserRequest * req = [[TKUnfollowUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)followingsForUserWithID:(TKResourceID)ID completion:(TKUserListRequestCompletion)completion {
    TKFollowingsForUserRequest * req = [[TKFollowingsForUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)followersForUserWithID:(TKResourceID)ID completion:(TKUserListRequestCompletion)completion {
    TKFollowersForUserRequest * req = [[TKFollowersForUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)muteUserWithID:(TKResourceID)ID completion:(TKUserRequestCompletion)completion {
    TKMuteUserRequest * req = [[TKMuteUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)unmuteUserWithID:(TKResourceID)ID completion:(TKUserRequestCompletion)completion {
    TKUnmuteUserRequest * req = [[TKUnmuteUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    
    [req sendRequestWithCompletion:completion];
}


- (void)mutingsWithCompletion:(TKUserListRequestCompletion)completion {
    TKMutingsForUserRequest * req = [[TKMutingsForUserRequest alloc] initWithSession:self];
    [req sendRequestWithCompletion:completion];
}

- (void)postWithID:(TKResourceID)ID completion:(TKPostRequestCompletion)completion {
    TKPostRequest * req = [[TKPostRequest alloc] initWithSession:self];
    
    req.postID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)createPostFromDraft:(TKDraft *)draft completion:(TKPostRequestCompletion)completion {
    TKCreatePostRequest * req = [[TKCreatePostRequest alloc] initWithSession:self];
    
    req.draft = draft;
    
    [req sendRequestWithCompletion:completion];
}

- (void)deletePostWithID:(TKResourceID)ID completion:(TKPostRequestCompletion)completion {
    NSParameterAssert(ID != ANUnspecifiedPostID);
    
    TKDeletePostRequest * req = [[TKDeletePostRequest alloc] initWithSession:self];
    
    req.postID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)postsForUserWithID:(TKResourceID)ID betweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion {
    TKPostsByUserRequest * req = [[TKPostsByUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    req.sinceID = sinceID;
    req.beforeID = beforeID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)postsReplyingToPostWithID:(TKResourceID)ID betweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion {
    TKPostsReplyingToPostRequest * req = [[TKPostsReplyingToPostRequest alloc] initWithSession:self];
    
    req.postID = ID;
    req.sinceID = sinceID;
    req.beforeID = beforeID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)postsInStreamWithCompletion:(TKPostListRequestCompletion)completion {
    [self postsInStreamBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postsInStreamBetweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion {
    TKPostsInUserStreamRequest * req = [[TKPostsInUserStreamRequest alloc] initWithSession:self];
    
    req.sinceID = sinceID;
    req.beforeID = beforeID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)postsInUnifiedStreamWithCompletion:(TKPostListRequestCompletion)completion {
    [self postsInUnifiedStreamBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postsInUnifiedStreamBetweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion {
    TKPostsInUserUnifiedStreamRequest * req = [[TKPostsInUserUnifiedStreamRequest alloc] initWithSession:self];
    
    req.sinceID = sinceID;
    req.beforeID = beforeID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)postsMentioningUserWithID:(TKResourceID)ID betweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion {
    TKPostsMentioningUserRequest * req = [[TKPostsMentioningUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    req.sinceID = sinceID;
    req.beforeID = beforeID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)postsInGlobalStreamWithCompletion:(TKPostListRequestCompletion)completion {
    [self postsInGlobalStreamBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postsInGlobalStreamBetweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion {
    TKPostsInGlobalStreamRequest * req = [[TKPostsInGlobalStreamRequest alloc] initWithSession:self];
    
    req.sinceID = sinceID;
    req.beforeID = beforeID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)postsWithTag:(NSString *)tag completion:(TKPostListRequestCompletion)completion {
    [self postsWithTag:tag betweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postsWithTag:(NSString *)tag betweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion {
    TKPostsWithTagRequest * req = [[TKPostsWithTagRequest alloc] initWithSession:self];
    
    req.tag = tag;
    req.sinceID = sinceID;
    req.beforeID = beforeID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)starPostWithID:(TKResourceID)postID completion:(TKPostRequestCompletion)completion {
    TKStarPostRequest * req = [[TKStarPostRequest alloc] initWithSession:self];
    
    req.postID = postID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)unstarPostWithID:(TKResourceID)postID completion:(TKPostRequestCompletion)completion {
    TKUnstarPostRequest * req = [[TKUnstarPostRequest alloc] initWithSession:self];
    
    req.postID = postID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)postsStarredByUserWithID:(TKResourceID)userID betweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion {
    TKPostsStarredByUserRequest * req = [[TKPostsStarredByUserRequest alloc] initWithSession:self];
    
    req.userID = userID;
    req.beforeID = beforeID;
    req.sinceID = sinceID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)usersWithPostWithIDStarred:(TKResourceID)postID completion:(TKUserListRequestCompletion)completion {
    TKUsersWithPostStarredRequest * req = [[TKUsersWithPostStarredRequest alloc] initWithSession:self];
    
    req.postID = postID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)repostPostWithID:(TKResourceID)postID completion:(TKPostRequestCompletion)completion {
    TKRepostPostRequest * req = [[TKRepostPostRequest alloc] initWithSession:self];
    
    req.postID = postID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)unrepostPostWithID:(TKResourceID)postID completion:(TKPostRequestCompletion)completion {
    TKUnrepostPostRequest * req = [[TKUnrepostPostRequest alloc] initWithSession:self];
    
    req.postID = postID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)usersWithPostWithIDReposted:(TKResourceID)postID completion:(TKUserListRequestCompletion)completion {
    TKUsersWithPostRepostedRequest * req = [[TKUsersWithPostRepostedRequest alloc] initWithSession:self];
    
    req.postID = postID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)filtersWithCompletion:(TKFilterListRequestCompletion)completion {
    TKFiltersForCurrentUserRequest * req = [[TKFiltersForCurrentUserRequest alloc] initWithSession:self];
    [req sendRequestWithCompletion:completion];
}

- (void)deleteFiltersWithCompletion:(TKFilterListRequestCompletion)completion {
    TKDeleteFiltersForUserRequest * req = [[TKDeleteFiltersForUserRequest alloc] initWithSession:self];
    [req sendRequestWithCompletion:completion];
}

- (void)filterWithID:(TKResourceID)ID completion:(TKFilterRequestCompletion)completion {
    TKFilterRequest * req = [[TKFilterRequest alloc] initWithSession:self];
    
    req.filterID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)createFilterFromDraft:(TKDraftFilter*)draftFilter completion:(TKFilterRequestCompletion)completion {
    TKCreateFilterRequest * req = [[TKCreateFilterRequest alloc] initWithSession:self];
    
    req.draftFilter = draftFilter;
    
    [req sendRequestWithCompletion:completion];
}

- (void)deleteFilterWithID:(TKResourceID)ID completion:(TKFilterRequestCompletion)completion {
    TKDeleteFilterRequest * req = [[TKDeleteFilterRequest alloc] initWithSession:self];
    
    req.filterID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)updateFilterWithID:(TKResourceID)ID fromDraft:(TKDraftFilter*)draftFilter completion:(TKFilterRequestCompletion)completion {
    TKUpdateFilterRequest * req = [[TKUpdateFilterRequest alloc] initWithSession:self];
    
    req.filterID = ID;
    req.draftFilter = draftFilter;
    
    [req sendRequestWithCompletion:completion];
}

- (void)updateStreamMarkerWithDraft:(TKDraftStreamMarker*)draftMarker completion:(TKStreamMarkerRequestCompletion)completion {
    TKUpdateStreamMarkerRequest * req = [[TKUpdateStreamMarkerRequest alloc] initWithSession:self];
    
    req.draftMarker = draftMarker;
    
    [req sendRequestWithCompletion:completion];
}

@end
