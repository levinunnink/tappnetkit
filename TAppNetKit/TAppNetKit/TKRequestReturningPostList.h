//
//  ANRequestReturningPostList.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKAuthenticatedRequest.h"
#import "TAppNetKit.h"

@interface TKRequestReturningPostList : TKAuthenticatedRequest

@property (assign) TKResourceID sinceID;
@property (assign) TKResourceID beforeID;
@property (assign) NSUInteger count;

@property (assign) BOOL includeUser;
@property (assign) BOOL includeAnnotations;
@property (assign) BOOL includeReplies;
@property (assign) BOOL includeDirectedPosts;
@property (assign) BOOL includeMuted;
@property (assign) BOOL includeDeleted;
@property (assign) BOOL includeStarredBy;
@property (assign) BOOL includeMachine;
@property (assign) BOOL includeReposters;

- (void)sendRequestWithCompletion:(TKPostListRequestCompletion)completion;

@end
