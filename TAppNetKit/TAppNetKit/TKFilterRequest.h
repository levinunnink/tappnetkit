//
//  ANFilterRequest.h
//  Alef
//
//  Created by Brent Royal-Gordon on 10/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "TKAuthenticatedRequest.h"

@interface TKFilterRequest : TKAuthenticatedRequest

@property (nonatomic,assign) TKResourceID filterID;

- (void)sendRequestWithCompletion:(TKFilterRequestCompletion)completion;

@end
