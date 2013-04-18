//
//  SignupViewController.h
//  Sweepstakes
//
//  Created by Peerbits Solution on 03/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FbGraph.h"
#import "JSON.h"
#import "ViewController.h"
#import "ModelClass.h"
#import "FMDatabase.h"
#import "FMDBDataAccess.h"
#import "FMResultSet.h"
#import "Entities.h"
#import "Toast+UIView.h"
#import "LLDataControll.h"

@interface SignupViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    ModelClass *mc;
    SBJsonParser *parser;
    IBOutlet UIButton *btfemale;
    IBOutlet UIButton *btmale;
    NSString *gender;
    FbGraph *fbGraph;
	NSString *feedPostId;
    NSString *fb_firstname;
    NSString *fb_lastname;
    NSString *fb_uid;
    NSString *fb_email;
    NSString *fb_proimageurl;
    NSString *fb_gender;
    LLDataControll *dc;
   
    


}
- (IBAction)facebookregester:(id)sender;
- (IBAction)goback:(id)sender;
@property (nonatomic, retain) FbGraph *fbGraph;
@property (nonatomic, retain) NSString *feedPostId;
@property (retain, nonatomic) IBOutlet UIImageView *firstnametickimgview;
@property (retain, nonatomic) IBOutlet UIImageView *lastnametickimgview;
@property (retain, nonatomic) IBOutlet UIImageView *emailtickimgview;
@property (retain, nonatomic) IBOutlet UIImageView *passtickimgview;
@property (retain, nonatomic) IBOutlet UIImageView *conpasstickimgview;
@property (retain, nonatomic) IBOutlet UIImageView *reffcodetickimgview;
@property (retain, nonatomic) IBOutlet UITextField *firstnametextfield;
@property (retain, nonatomic) IBOutlet UITextField *lastnametextfield;
@property (retain, nonatomic) IBOutlet UITextField *emailtextfield;
@property (retain, nonatomic) IBOutlet UITextField *passwordtextfield;
@property (retain, nonatomic) IBOutlet UITextField *confpasstextfield;
@property (retain, nonatomic) IBOutlet UITextField *reffcodetextfield;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
- (IBAction)femalebtn:(id)sender;

- (IBAction)malebtn:(id)sender;
- (IBAction)createaccountbtn:(id)sender;

@end
