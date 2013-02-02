//
//  ANUsersMatchingSearchQueryRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 9/29/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKAuthenticatedRequest.h"

@interface TKUsersMatchingSearchQueryRequest : TKAuthenticatedRequest

@property (copy) NSString * query;

- (void)sendRequestWithCompletion:(TKUserListRequestCompletion)completion;

@end
