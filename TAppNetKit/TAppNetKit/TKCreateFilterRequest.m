//
//  ANCreateFilterRequest.m
//  Alef
//
//  Created by Brent Royal-Gordon on 10/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "TKCreateFilterRequest.h"

@implementation TKCreateFilterRequest

- (NSURL *)URL {
    return [NSURL URLWithString:@"filters" relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return self.draftFilter.representation;
}

- (TKRequestMethod)method {
    return ANRequestMethodPost;
}

- (void)sendRequestWithCompletion:(TKFilterRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(TKResponse *response, id rep, NSError *error) {
        [self.session completeFilterRequest:completion withResponse:response representation:rep error:error];
    }];
}

@end
