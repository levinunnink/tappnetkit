//
//  ANSession.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import <Foundation/Foundation.h>
#import "AppNetKit.h"

@class TKUser;
@class TKPost;
@class TKFilter;
@class TKResource;
@class TKDraft;
@class TKDraftFilter;
@class TKDraftStreamMarker;

extern const TKResourceID ANMeUserID;
extern const TKResourceID ANUnspecifiedPostID;

typedef enum {
    ANStreamAPIVersion0
} ANStreamAPIVersion;

// NOTE: Most of the methods you'll actually want to use are implemented in the Requests category (ANSession+Requests.h).

@interface TKSession : NSObject

+ (void)beginNetworkActivity;
+ (void)endNetworkActivity;
+ (BOOL)isUsingNetwork;

+ (TKSession*)defaultSession;
+ (void)setDefaultSession:(TKSession*)defaultSession;

@property (strong) NSString * accessToken;

- (NSURL*)URLForStreamAPIVersion:(ANStreamAPIVersion)version;
@property (readonly,nonatomic) NSString * APIEndpointHost;

- (void)completeUserRequest:(TKUserRequestCompletion)completion withResponse:(TKResponse*)response representation:(NSDictionary*)rep error:(NSError*)error;
- (void)completeUserListRequest:(TKUserListRequestCompletion)completion withResponse:(TKResponse*)response representation:(NSArray*)rep error:(NSError*)error;
- (void)completePostRequest:(TKPostRequestCompletion)completion withResponse:(TKResponse*)response representation:(NSDictionary*)rep error:(NSError*)error;
- (void)completePostListRequest:(TKPostListRequestCompletion)completion withResponse:(TKResponse*)response representation:(NSArray*)rep error:(NSError*)error;
- (void)completeFilterRequest:(TKFilterRequestCompletion)completion withResponse:(TKResponse*)response representation:(NSDictionary*)rep error:(NSError*)error;
- (void)completeFilterListRequest:(TKFilterListRequestCompletion)completion withResponse:(TKResponse *)response representation:(NSDictionary *)rep error:(NSError *)error;
- (void)completeStreamMarkerRequest:(TKStreamMarkerRequestCompletion)completion withResponse:(TKResponse *)response representation:(NSDictionary *)rep error:(NSError *)error;

@end

#import "ANSession+Requests.h"
