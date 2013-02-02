//
//  ANUsersWithPostStarredRequest.m
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/7/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKUsersWithPostStarredRequest.h"

@implementation TKUsersWithPostStarredRequest

- (NSURL *)URL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"posts/%lld/stars", self.postID] relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return nil;
}

- (TKRequestMethod)method {
    return ANRequestMethodGet;
}

- (void)sendRequestWithCompletion:(TKUserListRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(TKResponse * response, id rep, NSError *error) {
        [self.session completeUserListRequest:completion withResponse:response representation:rep error:error];
    }];
}

@end
