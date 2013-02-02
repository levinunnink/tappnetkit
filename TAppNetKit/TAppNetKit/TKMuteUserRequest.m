//
//  ANMuteUserRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKMuteUserRequest.h"

@implementation TKMuteUserRequest

- (NSURL *)URL {
    return [NSURL URLWithString:[self pathWithFormat:@"users/%@/mute" userID:self.userID] relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return nil;
}

- (TKRequestMethod)method {
    return ANRequestMethodPost;
}

- (void)sendRequestWithCompletion:(TKUserRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(TKResponse * response, id rep, NSError *error) {
        [self.session completeUserRequest:completion withResponse:response representation:rep error:error];
    }];
}

@end
