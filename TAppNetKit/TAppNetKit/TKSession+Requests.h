//
//  ANSession+Requests.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKSession.h"

@interface TKSession (Requests)

- (void)accessTokenInformationWithCompletion:(TKAccessTokenInformationRequestCompletion)completion;

- (void)userWithID:(TKResourceID)ID completion:(TKUserRequestCompletion)completion;
- (void)userWithUsername:(NSString*)username completion:(TKUserRequestCompletion)completion;
- (void)usersMatchingSearchQuery:(NSString*)query completion:(TKUserListRequestCompletion)completion;

- (void)followUserWithID:(TKResourceID)ID completion:(TKUserRequestCompletion)completion;
- (void)unfollowUserWithID:(TKResourceID)ID completion:(TKUserRequestCompletion)completion;
- (void)followingsForUserWithID:(TKResourceID)ID completion:(TKUserListRequestCompletion)completion;
- (void)followersForUserWithID:(TKResourceID)ID completion:(TKUserListRequestCompletion)completion;

- (void)muteUserWithID:(TKResourceID)ID completion:(TKUserRequestCompletion)completion;
- (void)unmuteUserWithID:(TKResourceID)ID completion:(TKUserRequestCompletion)completion;
- (void)mutingsWithCompletion:(TKUserListRequestCompletion)completion;

- (void)postWithID:(TKResourceID)ID completion:(TKPostRequestCompletion)completion;

- (void)createPostFromDraft:(TKDraft*)draft completion:(TKPostRequestCompletion)completion;
- (void)deletePostWithID:(TKResourceID)ID completion:(TKPostRequestCompletion)completion;

- (void)postsForUserWithID:(TKResourceID)ID betweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion;
- (void)postsMentioningUserWithID:(TKResourceID)ID betweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion;

- (void)postsInStreamWithCompletion:(TKPostListRequestCompletion)completion;
- (void)postsInStreamBetweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion;

- (void)postsInUnifiedStreamWithCompletion:(TKPostListRequestCompletion)completion;
- (void)postsInUnifiedStreamBetweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion;

- (void)postsInGlobalStreamWithCompletion:(TKPostListRequestCompletion)completion;
- (void)postsInGlobalStreamBetweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion;

- (void)postsWithTag:(NSString*)tag completion:(TKPostListRequestCompletion)completion;
- (void)postsWithTag:(NSString*)tag betweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion;

- (void)postsReplyingToPostWithID:(TKResourceID)ID betweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion;

- (void)starPostWithID:(TKResourceID)postID completion:(TKPostRequestCompletion)completion;
- (void)unstarPostWithID:(TKResourceID)postID completion:(TKPostRequestCompletion)completion;

- (void)postsStarredByUserWithID:(TKResourceID)userID betweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion;
- (void)usersWithPostWithIDStarred:(TKResourceID)postID completion:(TKUserListRequestCompletion)completion;

- (void)repostPostWithID:(TKResourceID)postID completion:(TKPostRequestCompletion)completion;
- (void)unrepostPostWithID:(TKResourceID)postID completion:(TKPostRequestCompletion)completion;

- (void)usersWithPostWithIDReposted:(TKResourceID)postID completion:(TKUserListRequestCompletion)completion;

- (void)filtersWithCompletion:(TKFilterListRequestCompletion)completion;
- (void)deleteFiltersWithCompletion:(TKFilterListRequestCompletion)completion;

- (void)filterWithID:(TKResourceID)ID completion:(TKFilterRequestCompletion)completion;
- (void)createFilterFromDraft:(TKDraftFilter*)draftFilter completion:(TKFilterRequestCompletion)completion;
- (void)deleteFilterWithID:(TKResourceID)ID completion:(TKFilterRequestCompletion)completion;
- (void)updateFilterWithID:(TKResourceID)ID fromDraft:(TKDraftFilter*)draftFilter completion:(TKFilterRequestCompletion)completion;

- (void)updateStreamMarkerWithDraft:(TKDraftStreamMarker*)draftMarker completion:(TKStreamMarkerRequestCompletion)completion;

@end
