//
//  ANPostRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKAuthenticatedRequest.h"
#import "TAppNetKit.h"

@interface TKPostRequest : TKAuthenticatedRequest

@property (assign) TKResourceID postID;

- (void)sendRequestWithCompletion:(TKPostRequestCompletion)completion;

@end
