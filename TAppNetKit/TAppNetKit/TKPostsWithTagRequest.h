//
//  ANPostsWithTagRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKRequestReturningPostList.h"

@interface TKPostsWithTagRequest : TKRequestReturningPostList

@property (strong) NSString * tag;

@end
