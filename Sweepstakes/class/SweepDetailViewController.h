//
//  SweepDetailViewController.h
//  Sweepstakes
//
//  Created by Peerbits Solution on 07/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quartzcore/Quartzcore.h"
#import "FMDatabase.h"
#import "FMDBDataAccess.h"
#import "FMResultSet.h"
#import "Entities.h"
#import "DTLazyImageView.h"
#import "ModelClass.h"
#import "GalaryViewController.h"
#import "FbGraph.h"
#import "JSON.h"
#import "SA_OAuthTwitterEngine.h"
#import "SA_OAuthTwitterController.h"
#import "SCTwitter.h"
#import "ViewController.h"
#import "GooglePlusShare.h"
//Ad colony
#import "AdColonyPublic.h"
#import "LLDataControll.h"
#import "FlurryAdDelegate.h"
#import "Flurry.h"
#import "FlurryAds.h"
#import "DarckWaitView.h"
#import "SponsorPaySDK.h"
#import "vunglepub.h"
@interface SweepDetailViewController : UIViewController<UIWebViewDelegate,DTLazyImageViewDelegate,SA_OAuthTwitterEngineDelegate, SA_OAuthTwitterControllerDelegate,GooglePlusShareDelegate,AdColonyTakeoverAdDelegate, AdColonyDelegate,FlurryAdDelegate,UIAlertViewDelegate,SPOfferWallViewControllerDelegate,VGVunglePubDelegate>{
    DarckWaitView *drk;
    DTLazyImageView *biglzimgview;
    ModelClass *mc;
    SA_OAuthTwitterEngine *_engine;
    NSMutableArray *tweets;
    NSString *creditneed;
    NSMutableArray *isdisplay;
    NSMutableArray *imagearray;
    NSMutableArray *islistarray;
    FbGraph *fbGraph;
    NSInteger time;
    NSTimer *timer;
    NSTimer *timer1;
    NSTimeInterval remainingSec;
    UILabel *plus;
    UILabel *creditst;
    IBOutlet UIButton *enterbtn;
    NSString *refcode;
    NSString *spAppURL;
    
    UIView *loadingView;
 //  DarckWaitView *drkSignUp;
    
    //The nsdictionary object which would be containing all my entrymethod details
    NSDictionary *actionListDictionary;
    int tappedTaskId;                       //To hold the task id of the tapped task
    NSString *tappedTaskType;               //Type of the tapped task
    NSString *tappedSubscriptionLink;       //Subscription link of the task if any, which is tapped
    BOOL isWatchingAdColonyVideo;
        
  
    IBOutlet UIButton *fbbtn;
    IBOutlet UIButton *tweetbtn;
    IBOutlet UIButton *googlebtn;
    IBOutlet UIButton *minbtn;
    IBOutlet UIButton *plubtn;
    LLDataControll *dc;
    
    // Display Success View and Save Entry
    bool show;
    NSString *entries;
    IBOutlet UIView *successview;
    
    //The is the dialog box which pops up every 6th time a video is watched, Sponsorpay
    //IBOutlet UIView *MainPopup1;
    IBOutlet UIView *MainPopup2;
   
    IBOutlet UIView *subPopup1;
    IBOutlet UIView *subPopup2;
    IBOutlet UILabel *header1lbl;
    IBOutlet UILabel *header2lbl;
    IBOutlet UILabel *mainlbl1;
    IBOutlet UILabel *mainlbl2;
    
    BOOL vungleMoviePlayed;
}
@property (retain, nonatomic) IBOutlet UIView *view4;
@property (retain, nonatomic) IBOutlet UIWebView *bigwebview;
@property (retain, nonatomic) GooglePlusShare *share;

- (IBAction)minusbtn:(id)sender;
- (IBAction)plusbtn:(id)sender;

@property (nonatomic, retain) FbGraph *fbGraph;
@property (nonatomic, retain) NSString *feedPostId;
@property(nonatomic,assign)  NSInteger time;
@property (nonatomic, retain) NSString *selectedsweepid;
@property (retain, nonatomic) IBOutlet UIImageView *tapclose;
@property (retain,nonatomic) NSString *userid;
@property (retain, nonatomic) IBOutlet UILabel *timeremainstlb;
@property (retain, nonatomic) IBOutlet UILabel *prizevaluestlb;
@property (retain, nonatomic) IBOutlet UILabel *yrcoststlb;
@property (retain, nonatomic) IBOutlet UILabel *timelb;
@property (retain, nonatomic) IBOutlet UILabel *prizelb;
@property (retain, nonatomic) IBOutlet UILabel *minutelb;
@property (retain, nonatomic) IBOutlet UILabel *hourlb;
@property (retain, nonatomic) IBOutlet UILabel *costlb;
@property (retain, nonatomic) IBOutlet UILabel *headerlb;
- (IBAction)entertowin:(id)sender;


//The view for the entry options which would be displayed dynamically to the user
@property (retain, nonatomic) IBOutlet UIView *vwEntryOptions;
//The following is the outlet for the generic confirmation dialog box which shows up
@property (retain, nonatomic) IBOutlet UIView *vwGenericConfDialog;
@property (retain, nonatomic) IBOutlet UIView *MainPopup1;
//vwAppDownloadConfDialog


//this is intended to be showing the gray area for the Entry options
@property (retain, nonatomic) IBOutlet UIImageView *ivGrayAreaEntryOptions;
//This is the image view which makes the visible container of the entry section
@property (retain, nonatomic) IBOutlet UIImageView *ivEntrySectionVisibleContainer;
//The image view for the close button for the entry section
@property (retain, nonatomic) IBOutlet UIImageView *ivCloseButtonEntryDialog;

//The action icon 1
@property (retain, nonatomic) IBOutlet UIImageView *ivAction1;
//The action icon 2
@property (retain, nonatomic) IBOutlet UIImageView *ivAction2;
//Action label 1
@property (retain, nonatomic) IBOutlet UIImageView *ivActionLabel1;
//Action label 2
@property (retain, nonatomic) IBOutlet UIImageView *ivActionLabel2;
//The lets go button
@property (retain, nonatomic) IBOutlet UIImageView *ivLetsGo;
//The image view for the sponsor logo
@property (retain, nonatomic) IBOutlet UIImageView *ivSponsorLogo;
//To display the subscription links, a separate view
@property (retain, nonatomic) IBOutlet UIView *vwSubscriptionViewer;
//The webview in which the link to the subscription would be opened
@property (retain, nonatomic) IBOutlet UIWebView *wvSubscription;
//The button to close the subscription view
@property (retain, nonatomic) IBOutlet UIButton *cmdCloseSubscriptionView;
//The view for the confirm entry view
@property (retain, nonatomic) IBOutlet UIView *vwEntryConfirm;
//The dark area of the overlay for the confirm dialog
@property (retain, nonatomic) IBOutlet UIImageView *ivEntryConfirmDarkArea;
//The visible area of the confirmation dialog box
@property (retain, nonatomic) IBOutlet UIImageView *ivEntryConfVisibleArea;
//The close button for the entry confirmation dialog box
@property (retain, nonatomic) IBOutlet UIImageView *ivCloseConfirmationDialog;
//The Enter again button
@property (retain, nonatomic) IBOutlet UIImageView *ivEnterAgain;
//The thanks for entering label
@property (retain, nonatomic) IBOutlet UILabel *lblThanksForEntering;
//The handler for the close button of subscription view
//- (IBAction)closeSubscriptionView:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *btnGenericDialogDoneButton;
@property (retain, nonatomic) IBOutlet UIImageView *ivSPOfferIcon;

//The close action for the generic dialog box
- (IBAction)closeGenericConfDialog:(id)sender;
- (IBAction)closeGenericConfDialogFromCross:(id)sender;



@property (retain, nonatomic) IBOutlet UIWebView *webview;
@property (retain, nonatomic) IBOutlet UIImageView *bigimgvew;
@property (retain, nonatomic) IBOutlet UILabel *credit;
- (IBAction)goback:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *view2;
- (IBAction)confirmbtn:(id)sender;
@property (retain, nonatomic) IBOutlet UISlider *slider;
@property (retain, nonatomic) IBOutlet UILabel *numoftktstlb;
@property (retain, nonatomic) IBOutlet UILabel *increasestlb;
@property (retain, nonatomic) IBOutlet UILabel *ticketlb;
@property (retain, nonatomic) IBOutlet UILabel *thankustlb;
@property (retain, nonatomic) IBOutlet UILabel *notifylb;
@property (retain, nonatomic) IBOutlet UILabel *considerlb;
- (IBAction)tweetplus:(id)sender;
- (IBAction)fbplus:(id)sender;
- (IBAction)googleshare:(id)sender;

@property (retain, nonatomic) IBOutlet UILabel *clickherelb;
@property (retain, nonatomic) IBOutlet UIImageView *clickherreimgview;
@property (retain, nonatomic) IBOutlet UIView *view3;
@property (retain, nonatomic) IBOutlet UIView *whiteview;
@property (retain, nonatomic) IBOutlet UIView *secondwhiteview;
- (IBAction)expandweb:(id)sender;
- (IBAction)closewebview:(id)sender;

- (IBAction)closesucess:(id)sender;
-(IBAction)OnButtonRefresh:(id)sender;


@end
