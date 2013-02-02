//
//  AppNetKit.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import <Foundation/Foundation.h>

#import "TKDefines.h"

extern NSString * const TKErrorDomain;
extern NSString * const TKExplanationURLKey;

// Used with password auth
extern NSString * const TKPasswordErrorTitleKey;
extern NSString * const TKPasswordErrorTextKey;

typedef enum {
    TKGenericError,
    TKOAuthInvalidRequestError,
    TKOAuthUnauthorizedClientError,
    TKOAuthAccessDeniedError,
    TKOAuthUnsupportedResponseTypeError,
    TKOAuthInvalidScopeError,
    TKOAuthServerError,
    TKOAuthTemporarilyUnavailableError,
    
    TKBadRequestError = 400,
    TKUnauthorizedError,
    TKPaymentRequiredError,
    TKForbiddenError,
    TKNotFoundError,
    TKMethodNotAllowedError,
    TKNotAcceptableError,
    TKProxyAuthenticationRequiredError,
    TKRequestTimeoutError,
    TKConflictError,
    TKGoneError,
    TKLengthRequiredError,
    TKPreconditionFailedError,
    TKRequestEntityTooLargeError,
    TKRequestURITooLongError,
    TKUnsupportedMediaTypeError,
    TKRequestedRTKgeNotSatisfiableError,
    TKExpectationFailedError,
    
    TKInternalServerError = 500,
    TKNotImplementedError,
    TKBadGatewayError,
    TKServiceUnavailableError,
    TKGatewayTimeoutError,
    TKHTTPVersionNotSupportedError
} TKErrorCode;

#import "NSString+AppNetExtensions.h"
#import "TKCompletions.h"
#import "TKAuthenticator.h"
#import "TKSession.h"
#import "TKUser.h"
#import "TKPost.h"
#import "TKFilter.h"
#import "TKAnnotation.h"
#import "TKEntity.h"
#import "TKSource.h"
#import "TKDraft.h"
#import "TKResponse.h"
