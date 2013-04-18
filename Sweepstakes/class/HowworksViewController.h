//
//  HowworksViewController.h
//  Sweepstakes
//
//  Created by macmini3 on 21/02/13.
//  Copyright (c) 2013 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SweepListViewController.h"
@interface HowworksViewController : UIViewController<UIScrollViewDelegate>{
BOOL pageControlBeingUsed;
}

- (IBAction)close:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *prevbtn;
- (IBAction)goprevious:(id)sender;
- (IBAction)gonext:(id)sender;
- (IBAction)pagechange:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;

@property (retain, nonatomic) IBOutlet UIView *pageone;
@property (retain, nonatomic) IBOutlet UIView *pagetwo;
@property (retain, nonatomic) IBOutlet UIView *pagethree;
@property (retain, nonatomic) IBOutlet UIView *pagefour;
@property (retain, nonatomic) IBOutlet UIButton *nextbtn;
@property (retain, nonatomic) IBOutlet UIPageControl *pagecontroller;
@end
