//
//  ViewController.h
//  Sweepstakes
//
//  Created by Peerbits Solution on 03/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "MyprofileViewController.h"
#import "WinnerlistViewController.h"
#import "SweepListViewController.h"
#import "FMDatabase.h"
#import "FMDBDataAccess.h"
#import "FMResultSet.h"
#import "Entities.h"
#import "ModelClass.h"
#import "FlurryAdDelegate.h"
#import "Toast+UIView.h"
#import "AdColonyPublic.h"
#import "LLDataControll.h"
@class DarckWaitView;
//@interface ViewController : UIViewController<FlurryAdDelegate,AdColonyTakeoverAdDelegate,AdColonyDelegate>{
@interface ViewController : UIViewController<FlurryAdDelegate>{
    LLDataControll *dc;
    NSString *userid;
    ModelClass *mc;
    UILabel *credit;
    UILabel *plus;
    DarckWaitView *drk;
    IBOutlet UIButton *Acceptbtn;
    IBOutlet UIButton *tickmark;

    
}
@property (retain, nonatomic) IBOutlet UIView *TearmImageView;
- (IBAction)gotick:(id)sender;

- (IBAction)Accept:(id)sender;

- (IBAction)closebtn:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *detaillb;
@property (retain, nonatomic) IBOutlet UILabel *creditlable;

- (IBAction)appsfortickete:(id)sender;
- (IBAction)videoforticketes:(id)sender;

@property (retain, nonatomic) IBOutlet UIImageView *sweepstakesimgview;
@property (retain, nonatomic) IBOutlet UIImageView *earncreditimgview;
@property (retain, nonatomic) IBOutlet UIImageView *winnerslistimgview;
@property (retain, nonatomic) IBOutlet UIImageView *myprofileimgview;
@property (retain, nonatomic) IBOutlet UIView *view2;
@property (retain, nonatomic) IBOutlet UIView *TearmsConditions;

@end
