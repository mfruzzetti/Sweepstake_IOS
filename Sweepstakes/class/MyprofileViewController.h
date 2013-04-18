//
//  MyprofileViewController.h
//  Sweepstakes
//
//  Created by Peerbits Solution on 03/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quartzcore/Quartzcore.h"
#import "FMDatabase.h"
#import "FMDBDataAccess.h"
#import "FMResultSet.h"
#import "Entities.h"
#import "ModelClass.h"
#import "DTLazyImageView.h"
#import "FbGraph.h"
#import "SCTwitter.h"
#import "ViewController.h"
#import "SweepDetailViewController.h"
#import "LLDataControll.h"
#import "DDMenuController.h"
//#import "GTMOAuth2Authentication.h"
//#import "GTMOAuth2SignIn.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MyprofileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DTLazyImageViewDelegate,UIAlertViewDelegate,UIScrollViewDelegate,DDMenuControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate>{


    
    IBOutlet UITableView *sweepstaletableview;
    ModelClass *mc;
    NSString *userid;
    DTLazyImageView *proimage;
    IBOutlet UIButton *fbbtn;
    IBOutlet UIButton *twitterbtn;
    IBOutlet UIButton *googlebtn;
    IBOutlet UIButton *pushnotibtn;
    NSMutableArray *is_livearray;
    NSMutableArray *prizearray;
    NSMutableArray *titlearray;
    NSMutableArray *entry_countarray;
    NSMutableArray *winnernamearray;
    NSMutableArray *iswinnerarray;
    NSMutableArray *timearray;
    NSMutableArray *sweepidarray;
    UILabel *plus;
    UILabel *credit;
    LLDataControll *dc;
    DDMenuController *_menuController;
    IBOutlet UIButton* btnProfilePhoto;
    CLLocationManager *locationManager;
    IBOutlet UILabel* lblLocation;
    
    
    IBOutlet UILabel *refrallb;
    IBOutlet UIImageView *my_sweepImg;
    IBOutlet UIImageView *my_entriesImg;

}
@property (retain, nonatomic) IBOutlet UIImageView *my_sweepImg;
@property (retain, nonatomic) IBOutlet UIImageView *my_entriesImg;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
@property (nonatomic, retain) FbGraph *fbGraph;
@property (nonatomic, retain) NSString *userid;
@property (retain, nonatomic) IBOutlet UILabel *creditslb;
@property (retain, nonatomic) IBOutlet UILabel *mysweepstakelb;
@property (retain, nonatomic) IBOutlet UILabel *socilasettinglb;
@property (retain, nonatomic) IBOutlet UILabel *loadmorelb;
@property (retain, nonatomic) IBOutlet UILabel *namelb;
@property (retain, nonatomic) IBOutlet UILabel *placelb;
@property (retain, nonatomic) IBOutlet UIImageView *profileimgview;
@property (retain, nonatomic) IBOutlet UILabel *tokennumlb;
@property (retain, nonatomic) IBOutlet UILabel *sweepnumlb;
@property (retain, nonatomic) IBOutlet UILabel *fblbl;
@property (retain, nonatomic) IBOutlet UILabel *twilbl;
@property (retain, nonatomic) IBOutlet UILabel *googlelbl;
@property (retain, nonatomic) IBOutlet UILabel *pushlbl;
@property (retain, nonatomic) IBOutlet UIImageView *loadmoreimgview;
@property (retain, nonatomic) IBOutlet UIImageView *socialback;
@property (retain, nonatomic) IBOutlet UIView *scview;


- (IBAction)goback:(id)sender;
- (IBAction)fbonoff:(id)sender;
- (IBAction)tweetonoff:(id)sender;
- (IBAction)goggleonoff:(id)sender;
- (IBAction)pushonoff:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *backbtn;


@end
