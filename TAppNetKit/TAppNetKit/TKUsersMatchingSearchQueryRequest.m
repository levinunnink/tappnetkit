//
//  ANUsersMatchingSearchQueryRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 9/29/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKUsersMatchingSearchQueryRequest.h"

@implementation TKUsersMatchingSearchQueryRequest

- (NSURL *)URL {
    return [NSURL URLWithString:@"users/search" relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return [NSDictionary dictionaryWithObject:self.query forKey:@"q"];
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
