//
//  TKResponse.h
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/2/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import <Foundation/Foundation.h>
#import "TKResource.h"
#import "TKDefines.h"
#import "TKStreamMarker.h"

@interface TKResponse : TKResource

@property (nonatomic,readonly) NSUInteger statusCode;
@property (nonatomic,readonly) NSString * errorMessage;

@property (nonatomic,readonly) TKResourceID earliestID;
@property (nonatomic,readonly) TKResourceID latestID;
@property (nonatomic,readonly) BOOL hasMore;

@property (nonatomic,readonly) TKStreamMarker * marker;
@property (nonatomic,readonly) NSDictionary * markerRepresentation;

@end
