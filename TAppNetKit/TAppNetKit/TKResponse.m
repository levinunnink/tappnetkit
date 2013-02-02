//
//  ANResponse.m
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/2/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKResponse.h"

@interface TKResponse ()

@property (nonatomic,readonly) NSUInteger code;
@property (nonatomic,readonly) NSUInteger minID;
@property (nonatomic,readonly) NSUInteger maxID;
@property (nonatomic,readonly) BOOL more;

@end

@implementation TKResponse

@dynamic code;
@dynamic minID;
@dynamic maxID;
@dynamic more;
@dynamic errorMessage;

@dynamic marker;
@dynamic markerRepresentation;

- (NSUInteger)statusCode {
    return self.code;
}

- (TKResourceID)earliestID {
    return self.minID;
}

- (TKResourceID)latestID {
    return self.maxID;
}

- (BOOL)hasMore {
    return self.more;
}

@end
