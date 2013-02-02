//
//  ANCreatePostRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKAuthenticatedRequest.h"
#import "TKSession.h"

@class TKDraft;

@interface TKCreatePostRequest : TKAuthenticatedRequest

@property (strong) TKDraft * draft;

- (void)sendRequestWithCompletion:(TKPostRequestCompletion)completion;

@end
