//
//  NSDictionary+Parameters.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Parameters)

- (NSString*)queryString;
- (NSData*)formBodyData;

- (id)initWithQueryString:(NSString*)queryString;
- (id)initWithFormBodyData:(NSData*)formData;

@end
