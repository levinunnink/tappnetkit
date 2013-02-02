//
//  TKSession_TKResource_Private.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/23/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

// This header declares private details of TKSession and TKResource that they use to manage each other.
// No user serviceable parts inside.

#import "TKSession.h"

@interface TKSession ()

- (id)uniqueResource:(TKIdentifiedResource*)resource;

@end

@interface TKResource ()

@property (readwrite,strong,nonatomic) NSDictionary * representation;

@end
