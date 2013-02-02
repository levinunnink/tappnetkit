//
//  ANUpdateStreamMarkerRequest.m
//  Alef
//
//  Created by Brent Royal-Gordon on 11/13/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "TKUpdateStreamMarkerRequest.h"

@implementation TKUpdateStreamMarkerRequest

- (NSURL *)URL {
    return [NSURL URLWithString:@"posts/marker" relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return self.draftMarker.representation;
}

- (TKRequestMethod)method {
    return TKRequestMethodPost;
}

- (void)sendRequestWithCompletion:(TKStreamMarkerRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(TKResponse *response, id rep, NSError *error) {
        [self.session completeStreamMarkerRequest:completion withResponse:response representation:rep error:error];
    }];
}

@end
