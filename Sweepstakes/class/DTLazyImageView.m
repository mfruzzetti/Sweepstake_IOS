//
//  DTLazyImageView.m
//  
//
//  Created by Peerbits Solution on 19/07/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "DTLazyImageView.h"

static NSCache *_imageCache = nil;

@interface DTLazyImageView ()

- (void)notify;

@end

@implementation DTLazyImageView
{
    NSURL *_url;
    
    NSURLConnection *_connection;
    NSMutableData *_receivedData;
    
    CGFloat _fullHeight;
    CGFloat _fullWidth;
    NSUInteger _expectedSize;
    
    BOOL shouldShowProgressiveDownload;
    
    __unsafe_unretained id<DTLazyImageViewDelegate> _delegate;
}
@synthesize delegate=_delegate;

- (void)dealloc
{   
    [super dealloc];
    [_connection cancel];
    actv = nil;
}

- (void) startLoading
{
  //  NSLog(@"Tag: %d , Url :%@",self.tag,[_url absoluteString]);
    
    if (!self.image && [[_url absoluteString] length]>0)
    {
        UIImage *image = [_imageCache objectForKey:_url];
        actv = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        actv.frame = CGRectMake(60.0, 30.0, 30.0, 30.0);
        [self addSubview:actv];
        if (image)
        {
            self.image = image;
            _fullWidth = image.size.width;
            _fullHeight = image.size.height;
            
            // for unknown reasons direct notify does not work below iOS 5
            [self performSelector:@selector(notify) withObject:nil afterDelay:0.0];
            return;
        }
        [self loadImageAtURL:_url];
    }   
    else
    {
        UIImage *image = [UIImage imageNamed:@"noimg.png"];
        self.image = image;
        _fullWidth = image.size.width;
        _fullHeight = image.size.height;
        self.frame = CGRectMake(0, 0, 80, 80);

    }
}

- (void)loadImageAtURL:(NSURL *)url
{
    [self performSelectorInBackground:@selector(loadImage:) withObject:url];
}

- (void)loadImage:(NSURL *)url
{
    @autoreleasepool
    {
        [actv startAnimating];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60.0];
        
        _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
        [_connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [_connection start];
        
        // necessary because otherwise otherwise the delegate methods would not get delivered
        CFRunLoopRun();
    }
}


- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
}

- (void)cancelLoading
{
    [_connection cancel];
    _connection = nil;
    _receivedData = nil;
}

#pragma mark NSURL Loading

- (void)notify
{
    [self.delegate imageDidLoad:self];
}

- (void)completeDownloadWithData:(NSData *)data
{
    UIImage *image = [[UIImage alloc] initWithData:data];
    self.image = image;
    _fullWidth = image.size.width;
    _fullHeight = image.size.height;
    
    [self notify];
    [actv stopAnimating];
    [actv removeFromSuperview];
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _imageCache = [[NSCache alloc] init];
    });
    
    if (_url)
    {
        // cache image
        [_imageCache setObject:image forKey:_url];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // every time we get an response it might be a forward, so we discard what data we have
    _receivedData = nil;
    
    // does not fire for local file URLs
    if ([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse *httpResponse = (id)response;
        
        if (![[httpResponse MIMEType] hasPrefix:@"image"])
        {
            [self cancelLoading];
            return;
        }
    }
    
    /* For progressive download */
    _fullWidth = _fullHeight = -1.0f;
    _expectedSize = (NSUInteger)[response expectedContentLength];
    
    _receivedData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receivedData appendData:data];
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (_receivedData)
    {
        [self performSelectorOnMainThread:@selector(completeDownloadWithData:) withObject:_receivedData waitUntilDone:YES];
        _receivedData = nil;
    }
    _connection = nil;
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _connection = nil;
    _receivedData = nil;
    CFRunLoopStop(CFRunLoopGetCurrent());
}

#pragma mark Properties

@synthesize url = _url;
@synthesize shouldShowProgressiveDownload;
@synthesize actv;
@end