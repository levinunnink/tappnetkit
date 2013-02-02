//
//  ANResource+Magic.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/22/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKResource.h"

@interface TKResource (Magic)

+ (BOOL)resolveInstanceMethod:(SEL)sel;
+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key;

@end
