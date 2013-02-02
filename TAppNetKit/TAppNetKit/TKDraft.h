//
//  ANDraft.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/23/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import <Foundation/Foundation.h>
#import "AppNetKit.h"

@class TKUser;
@class TKDraftEntitySet;

@interface TKDraft : NSObject

@property (strong) NSString * text;
@property (assign) TKResourceID replyTo;
@property (assign) BOOL machineOnly;
@property (readonly) NSMutableArray * annotations;
@property (readonly) TKDraftEntitySet * entities;

@property (copy) NSDictionary * representation;

- (void)createPostViaSession:(TKSession*)session completion:(TKPostRequestCompletion)completion;

@end
