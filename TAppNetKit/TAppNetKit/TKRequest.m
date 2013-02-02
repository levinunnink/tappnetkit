//
//  ANRequest.m
//  
//
//  Created by Brent Royal-Gordon on 8/19/12.
//
//

#import "TKRequest.h"
#import "TAppNetKit.h"
#import "NSDictionary+Parameters.h"

@interface TKRequest ()

@property (readonly) NSURL * fullURL;
@property (readonly) NSData * body;

@end

@implementation TKRequest

- (id)initWithSession:(TKSession *)session {
    if((self = [super init])) {
        _session = session;
    }
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    TKMutableRequest * req = [[TKMutableRequest alloc] initWithSession:self.session];
    
    req.URL = self.URL;
    req.parameters = self.parameters;
    req.method = self.method;
    req.parameterEncoding = self.parameterEncoding;
    
    return req;
}

@dynamic URL, parameters, method;

- (NSString*)methodString {
    switch (self.method) {
        case TKRequestMethodGet:
            return @"GET";
            
        case TKRequestMethodPost:
            return @"POST";
            
        case TKRequestMethodDelete:
            return @"DELETE";
            
        case TKRequestMethodPut:
            return @"PUT";
            
        default:
            NSAssert(NO, @"Unknown method %d", self.method);
            return nil;
    }
}

- (NSURL *)fullURL {
    if(self.method != TKRequestMethodGet) {
        return self.URL;
    }
    
    NSDictionary * params = self.parameters;
    if(params.count == 0) {
        return self.URL;
    }
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", self.URL.absoluteString, params.queryString]];
}

- (TKRequestParameterEncoding)parameterEncoding {
    return TKRequestParameterEncodingJSON;
}

- (NSData *)body {
    if(self.method == TKRequestMethodGet) {
        return nil;
    }
    
    NSDictionary * params = self.parameters;
    if(params.count == 0) {
        return nil;
    }

    NSData * data = nil;
    NSError * error = nil;

    switch (self.parameterEncoding) {
        case TKRequestParameterEncodingURL:
            data = params.formBodyData;
            break;

        case TKRequestParameterEncodingJSON:
        default:
            data = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
            NSAssert(data, @"Params could not be serialized to JSON--error: %@", error.localizedDescription);
            break;
    }

    return data;
}

- (NSError*)errorForHTTPRequest:(NSURLRequest*)req response:(NSHTTPURLResponse*)res {
    if(res.statusCode < TKBadRequestError) {
        return nil;
    }
    
    return [NSError errorWithDomain:TKErrorDomain code:res.statusCode userInfo:nil];
}

- (NSMutableURLRequest *)URLRequest {
    NSMutableURLRequest * req = [[NSMutableURLRequest alloc] initWithURL:self.fullURL];
    req.HTTPMethod = self.methodString;
    req.HTTPBody = self.body;
    
    if(req.HTTPBody) {
        switch (self.parameterEncoding) {
            case TKRequestParameterEncodingURL:
                [req setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
                break;
                
            case TKRequestParameterEncodingJSON:
            default:
                [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                break;
        }
    }
    
    return req;
}

- (NSString*)pathWithFormat:(NSString*)format userID:(TKResourceID)ID {
    NSString * IDString = @"me";
    if(ID != ANMeUserID) {
        IDString = [NSString stringWithFormat:@"%lld", ID];
    }
    return [NSString stringWithFormat:format, IDString];
}

- (NSString*)pathWithFormat:(NSString*)format username:(NSString*)username {
    username = [@"@" stringByAppendingString:username];
    return [NSString stringWithFormat:format, username];
}

- (void)sendRequestWithDataCompletion:(void (^)(NSData * body, NSError * error))completion {
    NSURLRequest * req = self.URLRequest;
    
    [TKSession beginNetworkActivity];
    
    [NSURLConnection sendAsynchronousRequest:req queue:NSOperationQueue.mainQueue completionHandler:^(NSURLResponse * response, NSData * body, NSError * error) {
        [TKSession endNetworkActivity];
        
        NSHTTPURLResponse * HTTPResponse = (id)response;
        
        if(!error) {
            error = [self errorForHTTPRequest:req response:HTTPResponse];
            if(error) {
                NSLog(@"Error page contents:\n%@", [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding]);
            }
        }
        
        if(error.code == NSURLErrorUserCancelledAuthentication && [error.domain isEqualToString:NSURLErrorDomain]) {
            NSMutableDictionary * userInfo = error.userInfo.mutableCopy;
            [userInfo setObject:NSLocalizedString(@"Your account is not allowed to perform this operation.", @"") forKey:NSLocalizedDescriptionKey];
            [userInfo setObject:error forKey:NSUnderlyingErrorKey];
            
            error = [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo.copy];
        }
        
        if(error) {
            completion(body, error);
            return;
        }
        
        completion(body, nil);
    }];
}

- (id)dataRepresentationForRepresentation:(id)rep response:(TKResponse**)response {
    if(![rep isKindOfClass:NSDictionary.class]) {
        *response = nil;
        return rep;
    }
    
    if(![rep objectForKey:@"meta"]) {
        *response = nil;
        return rep;
    }
    
    *response = [[TKResponse alloc] initWithRepresentation:[rep objectForKey:@"meta"] session:self.session];
    return [rep objectForKey:@"data"];
}

- (void)sendRequestWithRepresentationCompletion:(void (^)(TKResponse *, id, NSError *))completion {
    [self sendRequestWithDataCompletion:^(NSData *body, NSError *error) {
        NSError * jsonError;
        id json = body == nil ? nil : [NSJSONSerialization JSONObjectWithData:body options:0 error:&jsonError];
        
        TKResponse * response;
        json = [self dataRepresentationForRepresentation:json response:&response];
        
        if(!error) {
            error = jsonError;
        }
        if(error && (response || json)) {
            NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
            
            [userInfo setObject:error forKey:NSUnderlyingErrorKey];
            if(json) {
                [userInfo setObject:json forKey:@"json"];
            }
            if(response.errorMessage) {
                [userInfo setObject:response.errorMessage forKey:NSLocalizedDescriptionKey];
            }
            
            error = [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo];

            json = nil;
        }
        
        completion(response, json, error);
    }];
}

@end

@implementation TKMutableRequest

@synthesize URL, parameters, method, parameterEncoding;

@end
