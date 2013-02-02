//
//  ANUpdateStreamMarkerRequest.h
//  Alef
//
//  Created by Brent Royal-Gordon on 11/13/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "TKAuthenticatedRequest.h"
#import "TKStreamMarker.h"

@interface TKUpdateStreamMarkerRequest : TKAuthenticatedRequest

@property (nonatomic,strong) TKDraftStreamMarker * draftMarker;

- (void)sendRequestWithCompletion:(TKStreamMarkerRequestCompletion)completion;

@end
