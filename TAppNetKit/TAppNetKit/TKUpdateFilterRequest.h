//
//  ANUpdateFilterRequest.h
//  Alef
//
//  Created by Brent Royal-Gordon on 10/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "TKAuthenticatedRequest.h"

@interface TKUpdateFilterRequest : TKAuthenticatedRequest

@property (nonatomic,assign) TKResourceID filterID;
@property (nonatomic,strong) TKDraftFilter * draftFilter;

- (void)sendRequestWithCompletion:(TKFilterRequestCompletion)completion;

@end
