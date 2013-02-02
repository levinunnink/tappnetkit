//
//  ANRepresentation.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import <Foundation/Foundation.h>
#import "ISO8601DateFormatter.h"

// Sent when the resource is updated; the resource is the object, and there is no userInfo.
extern NSString * const ANResourceDidUpdateNotification;

@class TKSession;
@class TKEntitySet;

@protocol TKTextualResource <NSObject>

@property (nonatomic,readonly) NSString * text;
@property (nonatomic,readonly) NSString * HTML;
@property (nonatomic,readonly) TKEntitySet * entities;
@property (nonatomic,readonly) NSDictionary * entitiesRepresentation;

@end

@interface TKResource : NSObject

- (id)initWithRepresentation:(NSDictionary*)rep session:(TKSession*)session;

@property (readonly,weak,nonatomic) TKSession * session;
@property (readonly,strong,nonatomic) NSDictionary * representation;

+ (ISO8601DateFormatter*)dateFormatter;
+ (NSNumberFormatter*)IDFormatter;

@end
