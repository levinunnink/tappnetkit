//
//  ANAccessTokenInformationRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKAuthenticatedRequest.h"
#import "TKSession.h"

@interface TKAccessTokenInformationRequest : TKAuthenticatedRequest

- (void)sendRequestWithCompletion:(TKAccessTokenInformationRequestCompletion)completion;

@end
