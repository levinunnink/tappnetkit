//
//  ANUsernameRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/21/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKAuthenticatedRequest.h"
#import "TAppNetKit.h"

@interface TKUsernameRequest : TKAuthenticatedRequest

@property (assign) NSString * username;

- (void)sendRequestWithCompletion:(TKUserRequestCompletion)completion;

@end
