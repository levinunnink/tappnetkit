//
//  _ANIdentifiedResourceSet.h
//  Alef
//
//  Created by Brent Royal-Gordon on 10/27/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKIdentifiedResource.h"

// This table is used by ANSession to unique identified resources without holding strong references to them.
// No user serviceable parts inside.

@interface _TKIdentifiedResourceSet : NSObject

- (void)addResource:(TKIdentifiedResource*)resource;
- (TKIdentifiedResource*)existingResource:(TKIdentifiedResource*)resource;
- (void)removeResource:(TKIdentifiedResource*)resource;

@end
