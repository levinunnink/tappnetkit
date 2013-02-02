//
//  ADAppNetAuthenticator.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/17/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKAuthenticator.h"
#import "TAppNetKit.h"
#import "NSDictionary+Parameters.h"
#import "TKRequest.h"

NSString * const TKScopeStream = @"stream";
NSString * const TKScopeEmail = @"email";
NSString * const TKScopeWritePost = @"write_post";
NSString * const TKScopeFollow = @"follow";
NSString * const TKScopeMessages = @"messages";
NSString * const TKScopeExport = @"export";

@implementation TKAuthenticator

- (id)initSingleton {
    if(self = [super init]) {
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
        self.omitsPaymentOptions = YES;
#else
        self.omitsPaymentOptions = NO;
#endif
    }
    return self;
}

- (NSString*)parameterForScopes:(NSArray*)scopes {
    return [scopes componentsJoinedByString:@" "];
}

- (NSString*)parametersForScopes:(NSArray *)scopes {
    NSParameterAssert(scopes);
    NSAssert(self.clientID, @"ANAuthenticator.clientID not set");
    NSAssert(self.redirectURL, @"ANAuthenticator.redirectURL not set");
    
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    self.clientID, @"client_id",
                                    @"token", @"response_type",
                                    self.redirectURL.absoluteString, @"redirect_uri",
                                    [self parameterForScopes:scopes], @"scope",
                                    nil];
    
    if(self.omitsPaymentOptions) {
        [params setObject:@"appstore" forKey:@"adnview"];
    }
    
    return params.queryString;
}

- (NSURL *)URLToAuthenticateForScopes:(NSArray *)scopes {
    NSString * urlStr = [NSString stringWithFormat:@"https://alpha.app.net/oauth/authenticate?%@", [self parametersForScopes:scopes]];
    return [NSURL URLWithString:urlStr];
}

- (NSURL *)URLToAuthorizeForScopes:(NSArray *)scopes {
    NSString * urlStr = [NSString stringWithFormat:@"https://alpha.app.net/oauth/authorize?%@", [self parametersForScopes:scopes]];
    return [NSURL URLWithString:urlStr];
}

- (BOOL)isRedirectURL:(NSURL *)url {
    NSAssert(self.redirectURL, @"ANAuthenticator.redirectURL has not been set");
    return [url.scheme isEqualToString:self.redirectURL.scheme] && [url.host isEqualToString:self.redirectURL.host] && [url.path isEqualToString:self.redirectURL.path];
}

- (NSDictionary*)errorCodeDictionary {
    static NSDictionary * singleton;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        singleton = [NSDictionary dictionaryWithObjectsAndKeys:
                     [NSNumber numberWithInteger:TKOAuthInvalidRequestError], @"invalid_request",
                     [NSNumber numberWithInteger:TKOAuthUnauthorizedClientError], @"unauthorized_client",
                     [NSNumber numberWithInteger:TKOAuthAccessDeniedError], @"access_denied",
                     [NSNumber numberWithInteger:TKOAuthUnsupportedResponseTypeError], @"unsupported_response_type",
                     [NSNumber numberWithInteger:TKOAuthInvalidScopeError], @"invalid_scope",
                     [NSNumber numberWithInteger:TKOAuthServerError], @"server_error",
                     [NSNumber numberWithInteger:TKOAuthTemporarilyUnavailableError], @"temporarily_unavailable",                     
                     nil];
    });
    
    return singleton;

}

- (TKErrorCode)errorCodeForDictionary:(NSDictionary*)dict {
    NSString * errCodeString = [dict objectForKey:@"error"];
    
    return [[self.errorCodeDictionary objectForKey:errCodeString] integerValue];
}

- (NSString*)accessTokenFromRedirectURL:(NSURL*)redirectURL error:(NSError *__autoreleasing *)error {
    NSDictionary * dict = [[NSDictionary alloc] initWithQueryString:redirectURL.fragment];
    
    if([dict objectForKey:@"access_token"]) {
        return [dict objectForKey:@"access_token"];
    }
    
    if(error) {
        *error = [NSError errorWithDomain:TKErrorDomain code:[self errorCodeForDictionary:dict] userInfo:
                  [NSDictionary dictionaryWithObjectsAndKeys:
                   [[dict objectForKey:@"error_description"] stringByReplacingOccurrencesOfString:@"+" withString:@" "], NSLocalizedDescriptionKey,
                   [NSURL URLWithString:[dict objectForKey:@"error_uri"]], TKExplanationURLKey,
                   nil]];
    }
    
    return nil;
}

- (void)accessTokenForScopes:(NSArray *)scopes withUsername:(NSString *)username password:(NSString *)password completion:(void (^)(NSString *accessToken, id rep, NSError * error))completion {
    NSAssert(self.clientID, @"ANAuthenticator.clientID not set");
    NSAssert(self.passwordGrantSecret, @"You must set ANAuthenticator.passwordGrantSecret before calling -%@", NSStringFromSelector(_cmd));
    
    TKMutableRequest *authRequest = [[TKMutableRequest alloc] initWithSession:TKSession.defaultSession];
    
    authRequest.URL = [NSURL URLWithString:@"https://alpha.app.net/oauth/access_token"];
    authRequest.method = TKRequestMethodPost;
    authRequest.parameterEncoding = TKRequestParameterEncodingURL;
    authRequest.parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"password", @"grant_type", self.clientID, @"client_id", self.passwordGrantSecret, @"password_grant_secret", username, @"username", password, @"password", [self parameterForScopes:scopes], @"scope", nil];

    [authRequest sendRequestWithRepresentationCompletion:^(TKResponse *response, id rep, NSError *error) {
        if (error) {
            NSDictionary *errorResults = [error.userInfo objectForKey:@"json"];

            if ([errorResults isKindOfClass:NSDictionary.class]) {
                NSString *errorMessage = [errorResults objectForKey:@"error"];
                NSString *errorText = [errorResults objectForKey:@"error_text"];
                NSString *errorTitle = [errorResults objectForKey:@"error_title"];

                NSMutableDictionary *userInfo = [NSMutableDictionary new];
                [userInfo setObject:errorMessage forKey:NSLocalizedDescriptionKey];
                [userInfo setObject:error forKey:NSUnderlyingErrorKey];
                
                if (errorText) { 
                    [userInfo setObject:errorText forKey:TKPasswordErrorTextKey];
                }
                if (errorTitle) {
                    [userInfo setObject:errorText forKey:TKPasswordErrorTitleKey];
                }

                error = [NSError errorWithDomain:TKErrorDomain code:TKGenericError userInfo:userInfo];
            }

            if (completion) {
                completion(nil, nil, error);
            }
            return;
        }

        NSString *accessToken = nil;

        if([rep isKindOfClass:NSDictionary.class]) {
            accessToken = [rep objectForKey:@"access_token"];
        }

        if (completion) {
            completion(accessToken, rep, nil);
        }
    }];
}

#pragma mark Singleton machinery

+ (TKAuthenticator *)sharedAuthenticator {
    static TKAuthenticator * singleton;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        singleton = [[super allocWithZone:nil] initSingleton];
    });
    
    return singleton;
}

- (id)init {
    return self;
}

+ (id)allocWithZone:(NSZone *)zone {
    return self.sharedAuthenticator;
}

@end
