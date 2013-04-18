//
//  MenuViewController.h
//  Sweepstakes
//
//  Created by macmini3 on 19/02/13.
//  Copyright (c) 2013 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLDataControll.h"
#import "SweepListViewController.h"
#import "WinnerlistViewController.h"
#import "MyprofileViewController.h"
#import "ModelClass.h"
#import "DTLazyImageView.h"
#import "Quartzcore/Quartzcore.h"
#import "HowworksViewController.h"
@interface MenuViewController : UIViewController<DTLazyImageViewDelegate>{
    LLDataControll *dc;
    ModelClass *mc;
}
@property (retain, nonatomic) IBOutlet UILabel *namelbl;
@property (retain, nonatomic) IBOutlet UILabel *entrilbl;
@property (retain, nonatomic) IBOutlet UILabel *sweeplbl;
@property (retain, nonatomic) IBOutlet UILabel *winnerlbl;
@property (retain, nonatomic) IBOutlet UILabel *myprofilelbl;
@property (retain, nonatomic) IBOutlet UILabel *howlbl;
- (IBAction)gosweeps:(id)sender;
- (IBAction)gowinnerlist:(id)sender;
- (IBAction)gomyprofile:(id)sender;
- (IBAction)gohowworks:(id)sender;
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
