//
//  ANStarPostRequest.m
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/7/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKStarPostRequest.h"

@implementation TKStarPostRequest

- (NSURL *)URL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"posts/%lld/star", self.postID] relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return nil;
}

- (TKRequestMethod)method {
    return ANRequestMethodPost;
}

- (void)sendRequestWithCompletion:(TKPostRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(TKResponse * response, id rep, NSError *error) {
        [self.session completePostRequest:completion withResponse:response representation:rep error:error];
    }];
}

@end
