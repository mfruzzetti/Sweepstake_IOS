//
//  DTLazyImageView.h
//  
//
//  Created by Peerbits Solution on 19/07/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DTLazyImageView;

@protocol DTLazyImageViewDelegate <NSObject>
@optional
- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size;
- (void)imageDidLoad: (DTLazyImageView *) lazyImageView;
@end

@interface DTLazyImageView : UIImageView
{
    UIActivityIndicatorView *actv;
}
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, assign) BOOL shouldShowProgressiveDownload;
@property (nonatomic, strong) UIActivityIndicatorView *actv;
@property (nonatomic, assign) id<DTLazyImageViewDelegate> delegate;    // subtle simulator bug - use assign not __unsafe_unretained

- (void)startLoading;
- (void)cancelLoading;
- (void)loadImageAtURL:(NSURL *)url;
@end