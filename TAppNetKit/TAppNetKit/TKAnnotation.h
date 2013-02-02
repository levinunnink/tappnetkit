//
//  ANAnnotation.h
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/1/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKResource.h"

@class TKDraftAnnotation;
extern NSString * const ANAnnotationTypeGeolocation;

@interface TKAnnotationSet : NSObject

- (id)initWithRepresentation:(id)rep session:(TKSession *)session;

@property (readonly) TKSession * session;
@property (readonly) NSArray * representation;

@property (readonly) NSArray * all;
@property (readonly) NSArray * types;

- (NSArray*)annotationsOfType:(NSString*)type;

@end

@interface TKAnnotation : TKResource

@property (readonly) NSString * type;
@property (readonly) id value;

- (TKDraftAnnotation*)draftAnnotation;

@end

@interface TKDraftAnnotation : NSObject

@property (strong) NSString * type;
@property (strong) id value;

@property (copy) NSDictionary * representation;

@end

#import "TKDefines.h"

#if APPNETKIT_USE_CORE_LOCATION
#import <CoreLocation/CoreLocation.h>

@interface TKAnnotation (CLLocation)

@property (readonly) CLLocation * geolocationValue;

@end

@interface TKDraftAnnotation (CLLocation)

+ (TKDraftAnnotation*)draftAnnotationWithGeolocationValue:(CLLocation*)location;

@end

#endif
