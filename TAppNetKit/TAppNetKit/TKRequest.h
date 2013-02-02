//
//  ANRequest.h
//  
//
//  Created by Brent Royal-Gordon on 8/19/12.
//
//

#import <Foundation/Foundation.h>
#import "TAppNetKit.h"

@class TKSession;

typedef enum {
    TKRequestMethodGet,
    TKRequestMethodPost,
    TKRequestMethodDelete,
    TKRequestMethodPut
} TKRequestMethod;

typedef enum {
    TKRequestParameterEncodingJSON,
    TKRequestParameterEncodingURL
} TKRequestParameterEncoding;

@interface TKRequest : NSObject <NSMutableCopying>

- (id)initWithSession:(TKSession*)session;

@property (weak) TKSession * session;

@property (readonly) NSURL * URL;
@property (readonly) NSDictionary * parameters;
@property (readonly) TKRequestMethod method;
@property (readonly) TKRequestParameterEncoding parameterEncoding;

@property (readonly) NSMutableURLRequest * URLRequest;

- (NSString*)pathWithFormat:(NSString*)format userID:(TKResourceID)ID;
- (NSString*)pathWithFormat:(NSString*)format username:(NSString*)username;

- (void)sendRequestWithDataCompletion:(void (^)(NSData * body, NSError * error))completion;
- (void)sendRequestWithRepresentationCompletion:(void (^)(TKResponse * response, id rep, NSError * error))completion;

@end

// TKMutableRequest (and ANMutableAuthenticatedRequest) allow you to change the URL, parameters, and method.
// This is more a means of doing completely custom requests than customizing an existing request.
@interface TKMutableRequest : TKRequest

@property (readwrite,strong) NSURL * URL;
@property (readwrite,strong) NSDictionary * parameters;
@property (readwrite,assign) TKRequestMethod method;
@property (readwrite,assign) TKRequestParameterEncoding parameterEncoding;

@end
