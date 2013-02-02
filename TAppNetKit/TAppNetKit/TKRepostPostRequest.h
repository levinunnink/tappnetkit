//
//  ANRepostPostRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 9/28/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKAuthenticatedRequest.h"

@interface TKRepostPostRequest : TKAuthenticatedRequest

@property (assign) TKResourceID postID;

- (void)sendRequestWithCompletion:(TKPostRequestCompletion)completion;

@end
