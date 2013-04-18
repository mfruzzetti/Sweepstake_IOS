//
//  DarckWaitView.h
//  testProject
//
//  Created by Evgeny Kalashnikov on 18.01.11.
//  Copyright 2011 StableFlow. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DarckWaitView : UIViewController {
	IBOutlet UITextView *messageLabel;
    IBOutlet UIView *vie;
    
    id delegate;
    NSTimeInterval time;
    SEL meth;
	
}
- (id)initWithDelegate:(id)Class andInterval:(NSTimeInterval)interval andMathod:(SEL)mathod;
- (void) showWithMessage:(NSString *)message;
- (void) hide;

@end
