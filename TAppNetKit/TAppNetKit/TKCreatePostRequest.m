//
//  ANCreatePostRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKCreatePostRequest.h"
#import "AppNetKit.h"
#import "NSDictionary+dictionaryWithObjectsForKeys.h"

@implementation TKCreatePostRequest

- (NSURL *)URL {
    return [NSURL URLWithString:@"posts" relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return self.draft.representation;
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
