//
//  ANUserPostListRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKRequestReturningPostList.h"
#import "TAppNetKit.h"

@interface TKPostsByUserRequest : TKRequestReturningPostList

@property (assign) TKResourceID userID;

@end
