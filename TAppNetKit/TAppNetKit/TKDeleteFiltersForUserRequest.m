//
//  ANDeleteFiltersForUserRequest.m
//  Alef
//
//  Created by Brent Royal-Gordon on 10/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "TKDeleteFiltersForUserRequest.h"

@implementation TKDeleteFiltersForUserRequest

- (NSURL *)URL {
    return [NSURL URLWithString:@"filters" relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return nil;
}

- (TKRequestMethod)method {
    return TKRequestMethodDelete;
}

- (void)sendRequestWithCompletion:(TKFilterListRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(TKResponse *response, id rep, NSError *error) {
        [self.session completeFilterListRequest:completion withResponse:response representation:rep error:error];
    }];
}

@end
