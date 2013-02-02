//
//  ANUsersWithPostStarredRequest.h
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/7/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKAuthenticatedRequest.h"

@interface TKUsersWithPostStarredRequest : TKAuthenticatedRequest

@property (assign) TKResourceID postID;

- (void)sendRequestWithCompletion:(TKUserListRequestCompletion)completion;

@end
