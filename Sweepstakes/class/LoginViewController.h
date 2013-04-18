//
//  LoginViewController.h
//  Sweepstakes
//
//  Created by Peerbits Solution on 03/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignupViewController.h"
#import "ModelClass.h"
#import "ViewController.h"
#import "FMDatabase.h"
#import "FMDBDataAccess.h"
#import "FMResultSet.h"
#import "Entities.h"
#import "Toast+UIView.h"
#import "LLDataControll.h"
#import "SweepListViewController.h"
#import "FbGraph.h"
#import "AccountLoginVC.h"
#import "FbGraph.h"

@interface LoginViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIWebViewDelegate>{
    ModelClass *mc;
    LLDataControll *dc;
    FbGraph *fbGraph;
    SBJsonParser *parser;
	NSString *feedPostId;
    NSString *fb_firstname;
    NSString *fb_lastname;
    NSString *fb_uid;
    NSString *fb_email;
    NSString *fb_proimageurl;
    NSString *fb_gender;

}
- (IBAction)goback:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *emailtextfield;
@property (retain, nonatomic) IBOutlet UITextField *passwordtextfield;
- (IBAction)login:(id)sender;
- (IBAction)signup:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
@property (retain, nonatomic) IBOutlet UILabel *forgotpasslb;

//KB March-13
-(void)startLoginProcess;
-(void)connectWithFacebook;
@end
