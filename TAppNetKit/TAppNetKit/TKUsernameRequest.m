//
//  ANUsernameRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/21/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKUsernameRequest.h"

@implementation TKUsernameRequest

- (NSURL *)URL {
    return [NSURL URLWithString:[self pathWithFormat:@"users/%@" username:self.username] relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return nil;
}

- (TKRequestMethod)method {
    return TKRequestMethodGet;
}

- (void)sendRequestWithCompletion:(TKUserRequestCompletion)completion {
    NSString * username = self.username;
    
    [self sendRequestWithRepresentationCompletion:^(TKResponse * response, id rep, NSError *error) {
        if(!rep) {
            if(error.code == TKNotFoundError && [error.domain isEqualToString:TKErrorDomain]) {
                NSString * message = [NSString stringWithFormat:NSLocalizedString(@"%@ has not been registered by an App.net user.", @""), username.appNetUsernameString];
                error = [NSError errorWithDomain:TKErrorDomain code:TKNotFoundError userInfo:@{ NSLocalizedDescriptionKey: message, NSUnderlyingErrorKey: error }];
            }
        }
        [self.session completeUserRequest:completion withResponse:response representation:rep error:error];
    }];
}

@end
