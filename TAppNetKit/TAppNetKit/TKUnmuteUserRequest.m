//
//  ANUnmuteUserRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKUnmuteUserRequest.h"

@implementation TKUnmuteUserRequest

- (TKRequestMethod)method {
    return ANRequestMethodDelete;
}

@end
