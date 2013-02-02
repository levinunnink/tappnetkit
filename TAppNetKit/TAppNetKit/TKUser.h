//
//  ANUser.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import <Foundation/Foundation.h>
#import "TKIdentifiedResource.h"
#import "ANCompletions.h"
#import "AppNetKit.h"
#import "TKUserDescription.h"
#import "TKImage.h"
#import "TKUserCounts.h"

typedef enum {
    TKUserTypeHuman,
    TKUserTypeBot,
    TKUserTypeCorporate,
    TKUserTypeFeed
} TKUserType;

NSString * TKUserTypeToString(TKUserType type);
TKUserType TKUserTypeFromString(NSString * string);

@class TKUserDescription;
@class TKImage;
@class TKUserCounts;
@class TKDraft;

@interface TKUser : TKIdentifiedResource

@property (readonly) NSString * username;
@property (readonly) NSString * name;
@property (readonly) TKUserDescription * userDescription;
@property (readonly) NSDictionary * userDescriptionRepresentation;

@property (readonly) NSString * timezoneString;
@property (readonly) NSTimeZone * timezone;

@property (readonly) NSString * localeString;
@property (readonly) NSLocale * locale;

@property (readonly) TKImage * avatarImage;
@property (readonly) NSDictionary * avatarImageRepresentation;
@property (readonly) TKImage * coverImage;
@property (readonly) NSDictionary * coverImageRepresentation;

@property (readonly) NSString * typeString;
@property (readonly) TKUserType type;

@property (readonly) NSDate * createdAt;
@property (readonly) TKUserCounts * counts;
@property (readonly) NSDictionary * countsRepresentation;
//@property (readonly???) NSDictionary * appData;

@property (readonly) BOOL followsYou;
@property (readonly) BOOL youFollow;
@property (readonly) BOOL youMuted;

- (TKDraft*)draftMention;

- (void)reloadWithCompletion:(TKUserRequestCompletion)completion;

- (void)followWithCompletion:(TKUserRequestCompletion)completion;
- (void)unfollowWithCompletion:(TKUserRequestCompletion)completion;
- (void)followingsWithCompletion:(TKUserListRequestCompletion)completion;
- (void)followersWithCompletion:(TKUserListRequestCompletion)completion;

- (void)muteWithCompletion:(TKUserRequestCompletion)completion;
- (void)unmuteWithCompletion:(TKUserRequestCompletion)completion;

- (void)postsWithCompletion:(TKPostListRequestCompletion)completion;
- (void)postsBetweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion;

- (void)postsStarredByUserWithCompletion:(TKPostListRequestCompletion)completion;
- (void)postsStarredByUserBetweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion;

- (void)postsMentioningUserWithCompletion:(TKPostListRequestCompletion)completion;
- (void)postsMentioningUserBetweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion;

@end
