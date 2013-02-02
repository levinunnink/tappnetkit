//
//  TKCompletions.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import <Foundation/Foundation.h>

@class TKUser;
@class TKPost;
@class TKFilter;
@class TKStreamMarker;
@class TKResponse;

typedef void (^TKAccessTokenInformationRequestCompletion)(TKResponse * response, NSArray * scopes, TKUser * user, NSError * error);
typedef void (^TKUserRequestCompletion)(TKResponse * response, TKUser * user, NSError * error);
typedef void (^TKUserListRequestCompletion)(TKResponse * response, NSArray * users, NSError * error);
typedef void (^TKPostRequestCompletion)(TKResponse * response, TKPost * post, NSError * error);
typedef void (^TKPostListRequestCompletion)(TKResponse * response, NSArray * posts, NSError * error);
typedef void (^TKFilterRequestCompletion)(TKResponse * response, TKFilter * filter, NSError * error);
typedef void (^TKFilterListRequestCompletion)(TKResponse * response, NSArray * filters, NSError * error);
typedef void (^TKStreamMarkerRequestCompletion)(TKResponse * response, TKStreamMarker * marker, NSError * error);
