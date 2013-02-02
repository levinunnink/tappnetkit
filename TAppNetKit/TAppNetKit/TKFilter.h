//
//  ANFilter.h
//  Alef
//
//  Created by Brent Royal-Gordon on 10/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "TKIdentifiedResource.h"
#import "TKCompletions.h"

@class TKDraftFilter;
@class TKDraftFilterClause;

typedef enum {
    ANFilterMatchPolicyIncludeAny,
    ANFilterMatchPolicyIncludeAll,
    ANFilterMatchPolicyExcludeAny,
    ANFilterMatchPolicyExcludeAll
} TKFilterMatchPolicy;

extern NSString * ANStringFromFilterMatchPolicy(TKFilterMatchPolicy matchPolicy);
extern TKFilterMatchPolicy ANFilterMatchPolicyFromString(NSString * string);

@interface TKFilter : TKIdentifiedResource

@property (nonatomic,readonly) NSString * name;

@property (nonatomic,readonly) NSArray * clauses;
@property (nonatomic,readonly) NSArray * clauseRepresentations;

@property (nonatomic,readonly) TKFilterMatchPolicy matchPolicy;
@property (nonatomic,readonly) NSString * matchPolicyRepresentation;

- (void)deleteWithCompletion:(TKFilterRequestCompletion)completion;
- (void)updateFromDraft:(TKDraftFilter*)draftFilter completion:(TKFilterRequestCompletion)completion;

- (TKDraftFilter*)draftFilter;

@end

typedef enum {
    ANFilterClauseObjectTypePost,
    ANFilterClauseObjectTypeStar,
    ANFilterClauseObjectTypeUserFollow
} TKFilterClauseObjectType;

extern NSString * ANStringFromFilterClauseObjectType(TKFilterClauseObjectType objectType);
extern TKFilterClauseObjectType ANFilterClauseObjectTypeFromString(NSString * string);

typedef enum {
    ANFilterClauseOperatorEquals,
    ANFilterClauseOperatorMatches,
    ANFilterClauseOperatorLess,
    ANFilterClauseOperatorLessOrEquals,
    ANFilterClauseOperatorGreater,
    ANFilterClauseOperatorGreaterOrEquals,
    ANFilterClauseOperatorOneOf
} TKFilterClauseOperator;

extern NSString * ANStringFromFilterClauseOperator(TKFilterClauseOperator operator);
extern TKFilterClauseOperator ANFilterClauseOperatorFromString(NSString * string);

@interface TKFilterClause : TKResource

@property (nonatomic,readonly) TKFilterClauseObjectType objectType;
@property (nonatomic,readonly) NSString * objectTypeRepresentation;

@property (nonatomic,readonly) TKFilterClauseOperator operator;
@property (nonatomic,readonly) NSString * operatorRepresentation;

@property (nonatomic,readonly) NSString * field;
@property (nonatomic,readonly) id value;

- (TKDraftFilterClause*)draftFilterClause;

@end

@interface TKDraftFilter : NSObject

@property (nonatomic,readwrite) NSString * name;
@property (nonatomic,readonly) NSMutableArray * clauses;
@property (nonatomic,readwrite) TKFilterMatchPolicy matchPolicy;

@property (nonatomic,copy) NSDictionary * representation;

- (void)createFilterViaSession:(TKSession*)session completion:(TKFilterRequestCompletion)completion;

@end

@interface TKDraftFilterClause : NSObject

@property (nonatomic,assign) TKFilterClauseObjectType objectType;
@property (nonatomic,assign) TKFilterClauseOperator operator;
@property (nonatomic,strong) NSString * field;
@property (nonatomic,strong) id value;

@property (nonatomic,copy) NSDictionary * representation;

@end
