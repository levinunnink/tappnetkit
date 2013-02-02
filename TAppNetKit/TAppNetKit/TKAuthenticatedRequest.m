//
//  ANRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKAuthenticatedRequest.h"
#import "TAppNetKit.h"

@implementation TKAuthenticatedRequest

- (id)mutableCopyWithZone:(NSZone *)zone {
    TKMutableRequest * req = [[TKMutableRequest alloc] initWithSession:self.session];
    
    req.URL = self.URL;
    req.parameters = self.parameters;
    req.method = self.method;
    
    return req;
}

+ (BOOL)requiresAccessToken {
    return YES;
}

- (BOOL)requiresAccessToken {
    return self.class.requiresAccessToken;
}

- (NSMutableURLRequest *)URLRequest {
    NSMutableURLRequest * req = super.URLRequest;
    
    if(self.session.accessToken) {
        [req setValue:[NSString stringWithFormat:@"Bearer %@", self.session.accessToken] forHTTPHeaderField:@"Authorization"];
    }
    else {
        NSAssert(!self.requiresAccessToken, @"Session's access token has not been set");
    }
    
    return req;
}

@end

@implementation TKMutableAuthenticatedRequest

@synthesize URL, parameters, method;

@end