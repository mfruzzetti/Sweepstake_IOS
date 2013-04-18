//
//  DarckWaitView.m
//  testProject
//
//  Created by Evgeny Kalashnikov on 18.01.11.
//  Copyright 2011 StableFlow. All rights reserved.
//

#import "DarckWaitView.h"


@implementation DarckWaitView

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithDelegate:(id)Class andInterval:(NSTimeInterval)interval andMathod:(SEL)mathod {
    self = [super init];
    if (self) {
        delegate = Class;
        time = interval;
        meth = mathod;
       
    }
    return self;
}

- (void) showWithMessage:(NSString *)message {
	UIWindow* window = [UIApplication sharedApplication].keyWindow;
	if (!window) {
		window = [[UIApplication sharedApplication].windows objectAtIndex:0];
	}
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
   
    [window addSubview:self.view];
    
	[messageLabel setText:message];
    if (meth) {
        [delegate performSelector:meth];
    }
    
    [self performSelector:@selector(hide) withObject:nil afterDelay:30];
}



- (void) hide {
  
   // [delegate performSelector:meth];
	[self.view removeFromSuperview];
}


@end
