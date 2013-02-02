//
//  ANImage.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/21/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "TKResource.h"

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
typedef void (^TKImageCompletion)(UIImage * image, NSError * error);
#else
typedef void (^ANImageCompletion)(NSImage * image, NSError * error);
#endif

@interface TKImage : TKResource

// Width, height, and size parameters are treated as points, and scaled by this value before requests.
+ (CGFloat)imageScale;
+ (void)setImageScale:(CGFloat)scale;

@property (readonly) NSURL * URL;
@property (readonly) CGSize nativeSize;

- (void)imageWithCompletion:(TKImageCompletion)completion;
- (void)imageAtWidth:(CGFloat)width completion:(TKImageCompletion)completion;
- (void)imageAtHeight:(CGFloat)height completion:(TKImageCompletion)completion;
- (void)imageAtSize:(CGSize)size completion:(TKImageCompletion)completion;

@end
