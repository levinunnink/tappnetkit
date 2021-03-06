//
//  ANUpdateFilterRequest.m
//  Alef
//
//  Created by Brent Royal-Gordon on 10/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "TKUpdateFilterRequest.h"

@implementation TKUpdateFilterRequest

- (NSURL *)URL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"filters/%lld", self.filterID] relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return self.draftFilter.representation;
}

- (TKRequestMethod)method {
    return TKRequestMethodPut;
}

- (void)sendRequestWithCompletion:(TKFilterRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(TKResponse *response, id rep, NSError *error) {
        [self.session completeFilterRequest:completion withResponse:response representation:rep error:error];
    }];
}

@end
