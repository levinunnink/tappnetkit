//
//  ANCreateFilterRequest.h
//  Alef
//
//  Created by Brent Royal-Gordon on 10/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "TKAuthenticatedRequest.h"

@interface TKCreateFilterRequest : TKAuthenticatedRequest

@property (nonatomic,strong) TKDraftFilter * draftFilter;

- (void)sendRequestWithCompletion:(TKFilterRequestCompletion)completion;

@end
