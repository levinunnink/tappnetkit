//
//  ANFilter.m
//  Alef
//
//  Created by Brent Royal-Gordon on 10/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "TKFilter.h"
#import "ANSession+Requests.h"

@implementation TKFilter

@dynamic name;
@dynamic clauseRepresentations;
@dynamic matchPolicyRepresentation;

+ (NSSet*)keyPathsForValuesAffectingClauses {
    return [NSSet setWithObject:@"clauseRepresentations"];
}

- (NSArray *)clauses {
    NSMutableArray * array = [NSMutableArray new];
    
    for(NSDictionary * rep in self.clauseRepresentations) {
        [array addObject:[[TKFilterClause alloc] initWithRepresentation:rep session:self.session]];
    }
    
    return array;
}

+ (NSSet *)keyPathsForValuesAffectingMatchPolicy {
    return [NSSet setWithObject:@"matchPolicyRepresentation"];
}

- (TKFilterMatchPolicy)matchPolicy {
    return ANFilterMatchPolicyFromString(self.matchPolicyRepresentation);
}

- (TKDraftFilter *)draftFilter {
    TKDraftFilter * draft = [TKDraftFilter new];
    draft.representation = self.representation;
    return draft;
}

- (void)updateFromDraft:(TKDraftFilter *)draftFilter completion:(TKFilterRequestCompletion)completion {
    [self.session updateFilterWithID:self.ID fromDraft:draftFilter completion:completion];
}

- (void)deleteWithCompletion:(TKFilterRequestCompletion)completion {
    [self.session deleteFilterWithID:self.ID completion:completion];
}

@end

@implementation TKFilterClause

@dynamic objectTypeRepresentation;
@dynamic operatorRepresentation;
@dynamic field;
@dynamic value;

+ (NSSet *)keyPathsForValuesAffectingObjectType {
    return [NSSet setWithObject:@"objectTypeRepresentation"];
}

- (TKFilterClauseObjectType)objectType {
    return ANFilterClauseObjectTypeFromString(self.objectTypeRepresentation);
}

+ (NSSet *)keyPathsForValuesAffectingOperator {
    return [NSSet setWithObject:@"operatorRepresentation"];
}

- (TKFilterClauseOperator)operator {
    return ANFilterClauseOperatorFromString(self.operatorRepresentation);
}

- (TKDraftFilterClause *)draftFilterClause {
    TKDraftFilterClause * draftClause = [TKDraftFilterClause new];
    draftClause.representation = self.representation;
    return draftClause;
}

@end

@implementation TKDraftFilter

- (id)init {
    if((self = [super init])) {
        _clauses = [NSMutableArray new];
    }
    return self;
}

- (NSDictionary *)representation {
    return @{
    @"name": self.name,
    @"clauses": [self.clauses valueForKey:@"representation"],
    @"match_policy": ANStringFromFilterMatchPolicy(self.matchPolicy),
    };
}

- (void)setRepresentation:(NSDictionary *)representation {
    self.name = representation[@"name"];
    self.matchPolicy = ANFilterMatchPolicyFromString(representation[@"match_policy"]);
    
    [self.clauses removeAllObjects];
    for(NSDictionary * clauseRep in representation[@"clauses"]) {
        TKDraftFilterClause * clause = [TKDraftFilterClause new];
        clause.representation = clauseRep;
        [self.clauses addObject:clause];
    }
}

- (void)createFilterViaSession:(TKSession *)session completion:(TKFilterRequestCompletion)completion {
    [session createFilterFromDraft:self completion:completion];
}

@end

@implementation TKDraftFilterClause

- (NSDictionary *)representation {
    return @{
    @"object_type": ANStringFromFilterClauseObjectType(self.objectType),
    @"operator": ANStringFromFilterClauseOperator(self.operator),
    @"field": self.field,
    @"value": self.value
    };
}

- (void)setRepresentation:(NSDictionary *)representation {
    self.objectType = ANFilterClauseObjectTypeFromString(representation[@"object_type"]);
    self.operator = ANFilterClauseOperatorFromString(representation[@"operator"]);
    self.field = representation[@"field"];
    self.value = representation[@"value"];
}

@end

NSString * ANStringFromFilterMatchPolicy(TKFilterMatchPolicy matchPolicy) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = @{
        @(ANFilterMatchPolicyIncludeAll): @"include_all",
        @(ANFilterMatchPolicyIncludeAny): @"include_any",
        @(ANFilterMatchPolicyExcludeAll): @"exclude_all",
        @(ANFilterMatchPolicyExcludeAny): @"exclude_any",
        };
    });
    
    return table[@(matchPolicy)];
}

TKFilterMatchPolicy ANFilterMatchPolicyFromString(NSString * string) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = @{
        @"include_all": @(ANFilterMatchPolicyIncludeAll),
        @"include_any": @(ANFilterMatchPolicyIncludeAny),
        @"exclude_all": @(ANFilterMatchPolicyExcludeAll),
        @"exclude_any": @(ANFilterMatchPolicyExcludeAny),
        };
    });
    
    return [table[string] integerValue];
}

NSString * ANStringFromFilterClauseObjectType(TKFilterClauseObjectType objectType) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = @{
        @(ANFilterClauseObjectTypePost): @"post",
        @(ANFilterClauseObjectTypeStar): @"star",
        @(ANFilterClauseObjectTypeUserFollow): @"user_follow",
        };
    });
    
    return table[@(objectType)];
}

TKFilterClauseObjectType ANFilterClauseObjectTypeFromString(NSString * string) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = @{
        @"post": @(ANFilterClauseObjectTypePost),
        @"star": @(ANFilterClauseObjectTypeStar),
        @"user_follow": @(ANFilterClauseObjectTypeUserFollow),
        };
    });
    
    return [table[string] integerValue];
}


NSString * ANStringFromFilterClauseOperator(TKFilterClauseOperator operator) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = @{
        @(ANFilterClauseOperatorEquals): @"equals",
        @(ANFilterClauseOperatorGreater): @"gt",
        @(ANFilterClauseOperatorGreaterOrEquals): @"ge",
        @(ANFilterClauseOperatorLess): @"lt",
        @(ANFilterClauseOperatorLessOrEquals): @"le",
        @(ANFilterClauseOperatorMatches): @"matches",
        @(ANFilterClauseOperatorOneOf): @"one_of",
        };
    });
    
    return table[@(operator)];
}

TKFilterClauseOperator ANFilterClauseOperatorFromString(NSString * string) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = @{
        @"equals": @(ANFilterClauseOperatorEquals),
        @"gt": @(ANFilterClauseOperatorGreater),
        @"ge": @(ANFilterClauseOperatorGreaterOrEquals),
        @"lt": @(ANFilterClauseOperatorLess),
        @"le": @(ANFilterClauseOperatorLessOrEquals),
        @"matches": @(ANFilterClauseOperatorMatches),
        @"one_of": @(ANFilterClauseOperatorOneOf),
        };
    });
    
    return [table[string] integerValue];
}

