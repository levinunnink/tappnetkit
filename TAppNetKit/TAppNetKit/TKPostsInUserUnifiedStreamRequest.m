//
//  ANPostsInUserUnifiedStreamRequest.m
//  Alef
//
//  Created by Brent Royal-Gordon on 10/25/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "TKPostsInUserUnifiedStreamRequest.h"

@implementation TKPostsInUserUnifiedStreamRequest

- (NSURL *)URL {
    return [super.URL URLByAppendingPathComponent:@"unified"];
}

@end
