//
//  ANUser.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKUser.h"
#import "TAppNetKit.h"

NSString * TKUserTypeToString(TKUserType type) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"human", [NSNumber numberWithInteger:TKUserTypeHuman],
                 @"bot", [NSNumber numberWithInteger:TKUserTypeBot],
                 @"corporate", [NSNumber numberWithInteger:TKUserTypeCorporate],
                 @"feed", [NSNumber numberWithInteger:TKUserTypeFeed],
                 nil];
    });
    
    return [table objectForKey:[NSNumber numberWithInteger:type]];
}

TKUserType TKUserTypeFromString(NSString * string) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = [NSDictionary dictionaryWithObjectsAndKeys:
                 [NSNumber numberWithInteger:TKUserTypeHuman], @"human",
                 [NSNumber numberWithInteger:TKUserTypeBot], @"bot",
                 [NSNumber numberWithInteger:TKUserTypeCorporate], @"corporate",
                 [NSNumber numberWithInteger:TKUserTypeFeed], @"feed", 
                 nil];
    });
    
    return [[table objectForKey:string] integerValue];

}

@implementation TKUser

@dynamic username;
@dynamic name;
@dynamic userDescriptionRepresentation;
@dynamic userDescription;
@dynamic timezoneString;
@dynamic localeString;
@dynamic typeString;
@dynamic avatarImageRepresentation;
@dynamic avatarImage;
@dynamic coverImageRepresentation;
@dynamic coverImage;
@dynamic createdAt;
@dynamic countsRepresentation;
@dynamic counts;
@dynamic followsYou;
@dynamic youFollow;
@dynamic youMuted;

- (TKUserType)type {
    return TKUserTypeFromString(self.typeString);
}

- (TKDraft *)draftMention {
    TKDraft * draft = [TKDraft new];
    
    draft.text = [NSString stringWithFormat:@"%@ ", self.username.appNetUsernameString];
    
    return draft;
}

- (void)reloadWithCompletion:(TKUserRequestCompletion)completion {
    [self.session userWithID:self.ID completion:completion];
}

- (void)followWithCompletion:(TKUserRequestCompletion)completion {
    [self.session followUserWithID:self.ID completion:completion];
}

- (void)unfollowWithCompletion:(TKUserRequestCompletion)completion {
    [self.session unfollowUserWithID:self.ID completion:completion];
}

- (void)followingsWithCompletion:(TKUserListRequestCompletion)completion {
    [self.session followingsForUserWithID:self.ID completion:completion];
}

- (void)followersWithCompletion:(TKUserListRequestCompletion)completion {
    [self.session followersForUserWithID:self.ID completion:completion];
}

- (void)muteWithCompletion:(TKUserRequestCompletion)completion {
    [self.session muteUserWithID:self.ID completion:completion];
}

- (void)unmuteWithCompletion:(TKUserRequestCompletion)completion {
    [self.session unmuteUserWithID:self.ID completion:completion];
}

- (void)postsWithCompletion:(TKPostListRequestCompletion)completion {
    [self postsBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postsBetweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion {
    [self.session postsForUserWithID:self.ID betweenID:sinceID andID:beforeID completion:completion];
}

- (void)postsStarredByUserWithCompletion:(TKPostListRequestCompletion)completion {
    [self postsStarredByUserBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postsStarredByUserBetweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion {
    [self.session postsStarredByUserWithID:self.ID betweenID:sinceID andID:beforeID completion:completion];
}

- (void)postsMentioningUserWithCompletion:(TKPostListRequestCompletion)completion {
    [self postsMentioningUserBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postsMentioningUserBetweenID:(TKResourceID)sinceID andID:(TKResourceID)beforeID completion:(TKPostListRequestCompletion)completion {
    [self.session postsMentioningUserWithID:self.ID betweenID:sinceID andID:beforeID completion:completion];
}

@end
