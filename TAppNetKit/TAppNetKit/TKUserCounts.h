//
//  ANUserCounts.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/21/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKResource.h"

@interface TKUserCounts : TKResource

@property (readonly) NSUInteger following;
@property (readonly) NSUInteger followers;
@property (readonly) NSUInteger posts;
@property (readonly) NSUInteger stars;

@end
