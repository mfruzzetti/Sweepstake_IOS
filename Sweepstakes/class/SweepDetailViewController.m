//
//  SweepDetailViewController.m
//  Sweepstakes
//
//  Created by Peerbits Solution on 07/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "SweepDetailViewController.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <CommonCrypto/CommonDigest.h>
#define IS_IPHONE_5 ( [ [ UIScreen mainScreen ] bounds ].size.height == 568 )
@interface SweepDetailViewController ()

@end

@implementation SweepDetailViewController
@synthesize view4,share;
@synthesize bigwebview;
@synthesize tapclose;
@synthesize clickherelb,time;
@synthesize clickherreimgview;
@synthesize view3;
@synthesize whiteview;
@synthesize secondwhiteview;

@synthesize slider;
@synthesize numoftktstlb;
@synthesize increasestlb;
@synthesize ticketlb;
@synthesize thankustlb;
@synthesize notifylb;
@synthesize considerlb;
@synthesize view2;
@synthesize webview;
@synthesize bigimgvew;
@synthesize credit;
@synthesize timeremainstlb;
@synthesize prizevaluestlb;
@synthesize yrcoststlb;
@synthesize timelb;
@synthesize prizelb;
@synthesize minutelb;
@synthesize hourlb;
@synthesize costlb;
@synthesize headerlb,userid,fbGraph,feedPostId;
@synthesize selectedsweepid;
//Entry section variables
@synthesize vwEntryOptions;
@synthesize ivGrayAreaEntryOptions;
@synthesize ivEntrySectionVisibleContainer;
@synthesize ivCloseButtonEntryDialog;
@synthesize ivAction1;
@synthesize ivAction2;
@synthesize ivActionLabel1;
@synthesize ivActionLabel2;
@synthesize ivLetsGo;
@synthesize ivSponsorLogo;
@synthesize vwSubscriptionViewer;
@synthesize wvSubscription;
@synthesize cmdCloseSubscriptionView;
@synthesize vwEntryConfirm;
@synthesize ivEntryConfirmDarkArea;
@synthesize ivCloseConfirmationDialog;
@synthesize ivEntryConfVisibleArea;
@synthesize ivEnterAgain;
@synthesize lblThanksForEntering;
@synthesize ivSPOfferIcon;

//The generic confirmation dialog box which the user sees after watching a video
@synthesize vwGenericConfDialog;
@synthesize MainPopup1;



float x;
int i;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     

        // Custom initialization
    }
    return self;
}
-(void)showPopup2{
    MainPopup2.clipsToBounds=YES;
    subPopup2.alpha = 1.0;
    [self.view addSubview:MainPopup2];
    MainPopup2.frame = self.view.frame;
    [subPopup2 setNeedsLayout];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes:frameTimes];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .3;
    [subPopup1.layer addAnimation:animation forKey:@"popup"];
}
-(void)showPopup1{
    MainPopup1.clipsToBounds=YES;
    subPopup1.alpha = 1.0;
    [self.view addSubview:MainPopup1];
    MainPopup1.frame = self.view.frame;
    [subPopup1 setNeedsLayout];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes:frameTimes];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .3;
    [subPopup1.layer addAnimation:animation forKey:@"popup"];
}
- (IBAction)closePopup1:(id)sender {
    /*[UIView animateWithDuration:0.4
                     animations:^{subPopup1.alpha = 0.0;}
                     completion:^(BOOL finished){
                         
                         [MainPopup1 removeFromSuperview];
                     }];*/
    [MainPopup1 removeFromSuperview];
}
- (IBAction)cancelPopup1:(UIButton *)sender {
    /*[UIView animateWithDuration:0.4
                     animations:^{subPopup1.alpha = 0.0;}
                     completion:^(BOOL finished){
                         
                         [MainPopup1 removeFromSuperview];
                     }];*/
    [MainPopup1 removeFromSuperview];
}
- (IBAction)EarnPopup1:(UIButton *)sender {
    
    //Check if URL is having something
    if([spAppURL length] != 0)
    {
        //OPen up safari with the link
    }
    
    /*
    [SponsorPaySDK showOfferWallWithParentViewController:self];
    [UIView animateWithDuration:0.4
                     animations:^{subPopup1.alpha = 0.0;}
                     completion:^(BOOL finished){
                         
                         [MainPopup1 removeFromSuperview];
                     }];
     */
}
- (IBAction)donePopup2:(UIButton *)sender {
    [UIView animateWithDuration:0.4
                     animations:^{subPopup2.alpha = 0.0;}
                     completion:^(BOOL finished){
                         
                         [MainPopup2 removeFromSuperview];
                     }];
}
- (IBAction)closePopup2:(UIButton *)sender {
    [UIView animateWithDuration:0.4
                     animations:^{subPopup2.alpha = 0.0;}
                     completion:^(BOOL finished){
                         
                         [MainPopup2 removeFromSuperview];
                     }];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(CheckPoint)
                                                name:UIApplicationDidBecomeActiveNotification
                                              object:nil];
    
    [mainlbl1 setFont:[UIFont fontWithName:@"Calibri-Bold" size:18]];
    

    [header1lbl setFont: [UIFont fontWithName:@"Calibri" size:16]];
    
    [mainlbl2 setFont:[UIFont fontWithName:@"Calibri" size:18]];

    [header2lbl setFont: [UIFont fontWithName:@"Calibri" size:16]];
  
    
    
//    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"spinstalled"]) {
//        [self showPopup2];
//    }
//    else{
//         [self showPopup1];
//    }
    
    
   
    
    dc = [[LLDataControll alloc]init];
    drk = [[DarckWaitView alloc] initWithDelegate:nil andInterval:0.1 andMathod:nil];
    timeremainstlb.font = [UIFont fontWithName:@"Calibri" size:12];
    prizevaluestlb.font = [UIFont fontWithName:@"Calibri" size:12];
    yrcoststlb.font = [UIFont fontWithName:@"Calibri" size:12];
    timelb.font = [UIFont fontWithName:@"Calibri-Bold" size:16];
    hourlb.font = [UIFont fontWithName:@"Calibri-Bold" size:16];
    minutelb.font =[UIFont fontWithName:@"Calibri-Bold" size:16];
    prizelb.font = [UIFont fontWithName:@"Calibri-Bold" size:14];
    costlb.font = [UIFont fontWithName:@"Calibri-Bold" size:16];
    headerlb.font = [UIFont fontWithName:@"Calibri-Bold" size:20];
    credit.font = [UIFont fontWithName:@"Calibri-BoldItalic" size:18];
    increasestlb.font = [UIFont fontWithName:@"Calibri-Bold" size:16];
    numoftktstlb.font = [UIFont fontWithName:@"Calibri" size:16];
    ticketlb.font = [UIFont fontWithName:@"Calibri-Bold" size:80];
    thankustlb.font = [UIFont fontWithName:@"Corbel-Bold" size:18]; 
    notifylb.font = [UIFont fontWithName:@"Corbel-Italic" size:14];
    considerlb.font = [UIFont fontWithName:@"Corbel-Bold" size:12];
    clickherelb.font = [UIFont fontWithName:@"Corbel-BoldItalic" size:16];

    mc = [[ModelClass alloc]init];
    [mc setDelegate:self];
   
    
    
    
    
    if(IS_IPHONE_5){
        CGRect frame = webview.frame;
        frame.size.height = frame.size.height + 14;
        webview.frame = frame;
    }

        
    //Assign the sweepsid into the local variable
    //currentSweepsId = selectedsweepid;
    
    NSLog(@"THE SWEEPS ID ONLOAD is --> %@", selectedsweepid);
    if (DELEGATE.isHostAvailable) {
        
        [mc Getdetailsweep:userid sweepid:selectedsweepid selector:@selector(Detailsweepresponse:)];
        
        
        
        
        //enterbtn.enabled = NO;
    }else 
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        //enterbtn.enabled = NO;
        
        
    }
    
    [FlurryAds setAdDelegate:self];
    NSDictionary *cookies =[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",userid],@"user_id",[NSString stringWithFormat:@"%@",selectedsweepid],@"sweeps_id", nil];
    [FlurryAds setUserCookies:cookies];
    [Flurry setUserID:userid];
    
    [AdColony setCustomID:userid];
    [AdColony initAdColonyWithDelegate:self];
    
    show = NO;
    
    [selectedsweepid retain];
    
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer];
    [recognizer addTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer release];

   /*
    UITapGestureRecognizer *Tapsweepstake = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tapsweepstack)] autorelease];
    UITapGestureRecognizer *Tapsweepstake2 = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tapsweepstack)] autorelease];
    UITapGestureRecognizer *Tapsweepstake3 = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tapsweepstack2)] autorelease];
    [tapclose addGestureRecognizer:Tapsweepstake3];
    [clickherreimgview addGestureRecognizer:Tapsweepstake2];
    [clickherelb addGestureRecognizer:Tapsweepstake];
    */
  //  FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
  //  [db open];
    
    /*
    // ***********************Entry method section code follows***************** //
    UITapGestureRecognizer *dismissEntryMethodsDialog = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissEntryMethodsDialogNaturally)] autorelease];
    UITapGestureRecognizer *dismissEntryMethodsDialog2 = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissEntryMethodsDialogNaturally2)] autorelease];
    //Associate this with the gray image View
    [ivGrayAreaEntryOptions addGestureRecognizer:dismissEntryMethodsDialog];
    //Close button event
    [ivCloseButtonEntryDialog addGestureRecognizer:dismissEntryMethodsDialog2];
    // *********************End of entry section releated codes***************** //
    */
    //************Initialize AdColony***********
    //Init the isWatchingAdVideo flag
   // isWatchingAdColonyVideo = NO;
    
    //******************************************
    
    /*
    FMResultSet *resultss=[db executeQuery:@"SELECT * FROM login_master where rowid=1"];
    while ([resultss next]) 
    {
        
        credit.text = [NSString stringWithFormat:@"%@",[resultss stringForColumn:@"credits"]];
        refcode = [[NSString alloc]initWithFormat:@"%@",[resultss stringForColumn:@"refcode"]];
        
    }
    [db close];
    
    CGSize textSize = [credit.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
    x= textSize.width;
    plus = [[UILabel alloc]initWithFrame:CGRectMake(268-x,5,10,20)];
    [plus setTextColor:[UIColor colorWithRed:0.0/255.0 green:120.0/255.0 blue:91.0/255.0 alpha:1.0]];
    [plus setBackgroundColor:[UIColor clearColor]];
    plus.textAlignment = UITextAlignmentRight;
    plus.font=[UIFont fontWithName:@"Calibri-BoldItalic" size:12];
    plus.text = @"+";
    [self.view addSubview:plus];
    [plus release];
    
    creditst = [[UILabel alloc]initWithFrame:CGRectMake(277,13,40,20)];
    [creditst setTextColor:[UIColor colorWithRed:0.0/255.0 green:120.0/255.0 blue:91.0/255.0 alpha:1.0]];
    [creditst setBackgroundColor:[UIColor clearColor]];
    creditst.textAlignment = UITextAlignmentLeft;
    creditst.font=[UIFont fontWithName:@"Calibri-BoldItalic" size:11];
    creditst.text = @"Tickets";
    [self.view addSubview:creditst];
    [creditst release];

      */
    
    
}

-(void)CheckPoint{
    if (DELEGATE.isHostAvailable)
    {
        
        // [mc getuserentries:userid sweepstakeid:selectedsweepid selector:@selector(userentrieres:)];
        
        // [mc enterSTForAdNetworkUser:userid inSweepstakes:selectedsweepid forNetwork:@"flurry_video" selector:@selector(processAdColonyEntryResponse:)];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *currentSweepsID = [prefs valueForKey:@"currentSweepsid"];
        [mc getNumberOfEntriesForUser:userid forSweepstakes:currentSweepsID selector:@selector(userentrieres:)];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    NSLog(@"VIEW DID APPEAR");
//    if(isWatchingAdColonyVideo == YES)
//    {
//        NSLog(@"WAS WATCHING VIDEO");
//        //Reset
//        isWatchingAdColonyVideo = NO;
//        //Show a toast
//        //[self.view makeToast:[NSString stringWithFormat:@"You'll be entered in the Sweepstakes %@", headerlb.text] duration:3.0 position:@"center"];
//        
//        
//    }


    
}


-(IBAction)OnButtonRefresh:(id)sender {
    if (DELEGATE.isHostAvailable) {
        
        [mc Getdetailsweep:userid sweepid:selectedsweepid selector:@selector(Detailsweepresponse:)];
        
        //Fetch the number of times the user has already entered into this sweepstakes
        //[mc getNumberOfEntriesForUser:userid forSweepstakes:selectedsweepid selector:@selector(processNumberOfEntriesResponse:)];
        
    }else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
    //Disable enter btn temporarily
    //enterbtn.enabled = NO;

}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight)
    {
        //click code on top left button
        [DELEGATE.menuController showLeftController:YES];
    }
    else
    {
        NSLog(@"Swipe received.");
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    DELEGATE.nCurrentListItem = CURRENT_LIST_ITEM_SWEEP_STAKES_DETAIL;
    }

-(void)Detailsweepresponse:(NSDictionary *)results{
  //  NSLog(@"%@",results);
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
    
    //Invariably enable the enter to sweepstakes button to true, last developer kept it within the following if block
    //result was catastrophic, at times the button was never coming back
    enterbtn.enabled = YES;
    
    if([result isEqualToString:@"true"]){
        
        
        //At this point fetch the number of times the user has already entered into this sweepstakes
        [mc getNumberOfEntriesForUser:userid forSweepstakes:selectedsweepid selector:@selector(processNumberOfEntriesResponse:)];
        
        
      //  UITapGestureRecognizer *Tapimg = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagegalary)] autorelease];
       // [bigimgvew addGestureRecognizer:Tapimg];
        
        time = [[NSString stringWithFormat:@"%@",[results valueForKey:@"time"]]intValue];
        [self counttime];
        
        creditneed = [[NSString alloc]initWithFormat:@"%@",[results valueForKey:@"credit_needed"]];
        isdisplay = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"image"]valueForKey:@"is_display"]];
        islistarray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"image"]valueForKey:@"is_list"]];
        imagearray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"image"]valueForKey:@"name"]];
        headerlb.text = [NSString stringWithFormat:@"%@",[results valueForKey:@"product_name"]];
        prizelb.text = [NSString stringWithFormat:@"$%@ USD",[results valueForKey:@"product_prize"]];
       
        // Display User Entries
      //  int totEntries = ([results valueForKey:@"entrycount"] == NULL)? 0 : [results valueForKey:@"entrycount"];
        //costlb.text =[NSString stringWithFormat:@"%d", totEntries];
        //entries = [[NSString alloc]initWithFormat:@"%d", totEntries];
       
        for (NSString *element in [results objectForKey:@"share"]) 
        {
           
            if ([element isEqualToString:@"F"]) {
              
                fbbtn.enabled = NO;
            }else if([element isEqualToString:@"T"]){
              
                tweetbtn.enabled = NO;
                
            }else if([element isEqualToString:@"G"]){
               
                googlebtn.enabled = NO;
            }
                                         
        }
    
        biglzimgview = [[DTLazyImageView alloc] initWithFrame:CGRectMake(0,0,320,173)];
        biglzimgview.delegate = self;
    
        for (i=0; i<[isdisplay count]; i++)
        {
         
            if ([[isdisplay objectAtIndex:i]isEqualToString:@"Y"])
            {
                
             //   biglzimgview.url = [NSURL URLWithString:[NSString stringWithFormat:@"http://peerdevelopment.com/cashking/%@",[imagearray objectAtIndex:i]]];
               biglzimgview.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGPATH,[imagearray objectAtIndex:i]]]; 
                [imagearray removeObjectAtIndex:i];
                [islistarray removeObjectAtIndex:i];
            }
        }
        
        for (i=0; i<[islistarray count]; i++)
        {
            
            if ([[islistarray objectAtIndex:i]isEqualToString:@"Y"])
            {
                
                [imagearray removeObjectAtIndex:i];
               
            }
        }

        
        biglzimgview.backgroundColor= [UIColor clearColor];
        [bigimgvew addSubview:biglzimgview];
        if (!biglzimgview.image) 
        {
            [biglzimgview startLoading];
            biglzimgview.actv.frame = CGRectMake(150.0, 95.0, 30.0, 30.0);
        }

        [webview loadHTMLString:[results valueForKey:@"description"] baseURL:nil];
        [bigwebview loadHTMLString:[results valueForKey:@"description"] baseURL:nil];
        
    }
    else if([[results valueForKey:@"message"]isEqualToString:@"User Does Not Exists"])
    {
       
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open];
        
        BOOL d= [db executeUpdate:@ "Delete from login_master"];
        if (!d)
        {
            NSLog(@"delete failed login_master!!");
        }
        else {
            NSLog(@"successfully delete login_master");
            
        }
        NSLog(@"Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:[results valueForKey:@"message"] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
        [dc deleteData];
//        credit.text = @"0"; 
//        CGSize textSize = [credit.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
//        x= textSize.width;
//            CGRect frame = CGRectMake(268-x,5,10,20);
//            plus.frame = frame;
//            CGRect frame1 = CGRectMake(277,13,40,20);
//            creditst.frame = frame1;
    }
    else {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:[results valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
        
    }


              
       
}


- (void)imageDidLoad: (DTLazyImageView *) lazyImageView
{
    
}

-(void)counttime
{
    if (!timer || remainingSec <= 0) 
    {
        [timer invalidate];
        timer = nil;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self 
                                               selector:@selector(counttime)  
                                               userInfo:nil 
                                                repeats:YES];
    }
    if (time <= 0) {
        
        timelb.text = [NSString stringWithFormat:@"0d"] ;
        hourlb.text=[NSString stringWithFormat:@"0h"];
        minutelb.text=[NSString stringWithFormat:@"0m"];
        //enterbtn.enabled = NO;
       // secondlabel.text=[NSString stringWithFormat:@"00\nSecs"];
        
    }
    else {
        NSInteger totalminut=time/60;
        NSInteger totalhour=totalminut/60;
        NSInteger minut=totalminut%60;
        
        NSInteger day=totalhour/24;
        NSInteger hour=totalhour%24;
   
        timelb.text = [NSString stringWithFormat:@"%2dd",day] ;
        hourlb.text=[NSString stringWithFormat:@"%2dh",hour];
        minutelb.text=[NSString stringWithFormat:@"%2dm",minut];
     
        time--;
        
    } 
    
}

-(void)Tapsweepstack2{
    [view2 removeFromSuperview];
    if (timer1 != nil) 
        [timer1 invalidate];
    timer1 = nil;
    minbtn.userInteractionEnabled = YES;
    plubtn.userInteractionEnabled = YES;


}

/**
 the following method dismisses theEntry methods dialog box
 */
-(void)dismissEntryMethodsDialogNaturally {
    [vwEntryOptions removeFromSuperview];
}

/**
 and yet another
 */
-(void)dismissEntryMethodsDialogNaturally2 {
    [vwEntryOptions removeFromSuperview];
}


-(void)Tapsweepstack{

    [view3 removeFromSuperview];


}
- (void)viewDidUnload
{
    [self setTimeremainstlb:nil];
    [self setPrizevaluestlb:nil];
    [self setYrcoststlb:nil];
    [self setTimelb:nil];
    [self setPrizelb:nil];
    [self setCostlb:nil];
    [self setHeaderlb:nil];
    [self setWebview:nil];
    [self setBigimgvew:nil];
    [self setCredit:nil];
    [self setView2:nil];
    [self setSlider:nil];
    [self setNumoftktstlb:nil];
    [self setIncreasestlb:nil];
    [self setTicketlb:nil];
    [self setThankustlb:nil];
    [self setNotifylb:nil];
    [self setConsiderlb:nil];
    [self setClickherelb:nil];
    [self setClickherreimgview:nil];
    [self setView3:nil];
    [self setWhiteview:nil];
    [self setWhiteview:nil];
    [self setSecondwhiteview:nil];
    [self setHourlb:nil];
    [self setMinutelb:nil];
    [enterbtn release];
    enterbtn = nil;
    [self setTapclose:nil];
    [self setView4:nil];
    [self setBigwebview:nil];
    [fbbtn release];
    fbbtn = nil;
    [tweetbtn release];
    tweetbtn = nil;
    [googlebtn release];
    googlebtn = nil;
    [minbtn release];
    minbtn = nil;
    [plubtn release];
    plubtn = nil;
    [self setVwEntryOptions:nil];
    [self setIvGrayAreaEntryOptions:nil];
    [self setVwGenericConfDialog:nil];
    [self setMainPopup1:nil];
    
        
    [self setIvEntrySectionVisibleContainer:nil];
    [self setIvCloseButtonEntryDialog:nil];
    [self setIvAction1:nil];
    [self setIvAction2:nil];
    [self setIvActionLabel1:nil];
    [self setIvActionLabel2:nil];
    [self setIvLetsGo:nil];
    [self setIvSponsorLogo:nil];
    [self setVwSubscriptionViewer:nil];
    [self setWvSubscription:nil];
    [self setCmdCloseSubscriptionView:nil];
    [self setVwEntryConfirm:nil];
    [self setIvEntryConfirmDarkArea:nil];
    [self setIvCloseConfirmationDialog:nil];
    [self setIvEnterAgain:nil];
    [self setIvEntryConfVisibleArea:nil];
    [self setLblThanksForEntering:nil];
    //[successview release];
    //successview = nil;
    [MainPopup1 release];
    MainPopup1 = nil;
    [MainPopup2 release];
    MainPopup2 = nil;
    [header1lbl release];
    header1lbl = nil;
    [subPopup1 release];
    subPopup1 = nil;
    [mainlbl1 release];
    mainlbl1 = nil;
    [header2lbl release];
    header2lbl = nil;
    [mainlbl2 release];
    mainlbl2 = nil;
    [subPopup2 release];
    subPopup2 = nil;
    [self setVwGenericConfDialog:nil];
    [self setMainPopup1:nil];
    [self setBtnGenericDialogDoneButton:nil];
    [self setCloseGenericConfDialogFromCross:nil];
    [self setIvSPOfferIcon:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [timeremainstlb release];
    [prizevaluestlb release];
    [yrcoststlb release];
    [timelb release];
    [prizelb release];
    [costlb release];
    [headerlb release];
    [webview release];
    [bigimgvew release];
    [credit release];
    [view2 release];
    [slider release];
    [numoftktstlb release];
    [increasestlb release];
    [ticketlb release];
    [thankustlb release];
    [notifylb release];
    [considerlb release];
    [clickherelb release];
    [clickherreimgview release];
    [view3 release];
    [whiteview release];
    [whiteview release];
    [secondwhiteview release];
    [hourlb release];
    [minutelb release];
    [enterbtn release];
    [tapclose release];
    [view4 release];
    [bigwebview release];
    
    [fbbtn release];
    [tweetbtn release];
    [googlebtn release];
    [minbtn release];
    [plubtn release];
    [vwEntryOptions release];
    [vwGenericConfDialog release];
    [ivGrayAreaEntryOptions release];
    [ivEntrySectionVisibleContainer release];
    [ivCloseButtonEntryDialog release];
    [ivAction1 release];
    [ivAction2 release];
    [ivActionLabel1 release];
    [ivActionLabel2 release];
    [ivLetsGo release];
    [ivSponsorLogo release];
    [vwSubscriptionViewer release];
    [wvSubscription release];
    [cmdCloseSubscriptionView release];
    [vwEntryConfirm release];
    [ivEntryConfirmDarkArea release];
    [ivCloseConfirmationDialog release];
    [ivEnterAgain release];
    [ivEntryConfVisibleArea release];
    [lblThanksForEntering release];
   
    //[successview release];
    [MainPopup1 release];
    [MainPopup2 release];
    [header1lbl release];
    [subPopup1 release];
    [mainlbl1 release];
    [header2lbl release];
    [mainlbl2 release];
    [subPopup2 release];
    [vwGenericConfDialog release];
    [_btnGenericDialogDoneButton release];
    [ivSPOfferIcon release];
    [super dealloc];
}
- (IBAction)slidervalue:(id)sender {
   
    UISlider *slide = (UISlider *)sender;
    ticketlb.text = [NSString stringWithFormat:@"%d", (int)(slide.value + 0.0f)];
    
}


- (void)processNumberOfEntriesResponse:(NSDictionary *)results {
    //NSLog(@"Number of entries --> %@", [results valueForKey:@"entries"]);
    costlb.text =[NSString stringWithFormat:@"%@",[results valueForKey:@"entries"]];
    entries = [[NSString alloc]initWithFormat:@"%@",[results valueForKey:@"entries"]];
    //Force Force Force Force ...enable please
    enterbtn.enabled = YES;
}

/**
 This is the method which opens up the dialog for entry section
 */



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([[alertView title] isEqualToString:@"User Does Not Exists"] && buttonIndex == 0)
	{
        
        LoginViewController *gotorootview = [[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil]autorelease];
        [self.navigationController pushViewController:gotorootview animated:YES];
	}
    

    
    //    else if(buttonIndex == 0){
    //
    //        if (DELEGATE.isHostAvailable)
    //        {
    //
    //          //  [mc applypoint:userid sweepid:selectedsweepid credits:[NSString stringWithFormat:@"%d",[ticketlb.text intValue]*[creditneed intValue]] selector:@selector(applypointres:)];
    //            [view2 removeFromSuperview];
    //
    //        }
    //        else
    //        {
    //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //            [alert show];
    //            [alert release];
    //        }
    //    }
}
- (void)offerWallViewController:(SPOfferWallViewController *)offerWallVC
           isFinishedWithStatus:(int)status{
    NSLog(@"offerWallViewController-->%d",status);
    


    
   // [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"email"] forKey:@"useremail"];
  //  [[NSUserDefaults standardUserDefaults] synchronize];
    
    // we could know if status determines a network error by comparing it with the
    // SPONSORPAY_ERR_NETWORK constant defined in SPOfferWallViewController.h
}

- (void)brandEngageClient:(SPBrandEngageClient *)brandEngageClient
          didChangeStatus:(SPBrandEngageClientStatus)newStatus
{
    NSLog(@"SPBrandEngageClient-->%u",newStatus);
    
    switch (newStatus) {
        case STARTED:
            // Your user just started watching the engagement
            break;
        case CLOSE_FINISHED:
            // This is it! Your user finished watching the video
            break;
        case CLOSE_ABORTED:
            // Engagement was cancelled
            break;
        case ERROR:
            // Something prevented the engagement from working correctly
            break;
    }
}

/*
- (void)processEntryMethodServerResponse:(NSDictionary *)results {
 
    //First thing first, check if the disctionary has objects in it
    if([results count] > 0)
    {
 
        //Has objects
        vwEntryOptions.clipsToBounds = YES;
        [self.view addSubview:vwEntryOptions];
        
        //Hide the logo
        ivSponsorLogo.hidden = YES;
        
        //Also at this point initiate the logo fetch process
        //[mc getEntryMethodsFor:userid sweepid:selectedsweepid selector:@selector(processEntryMethodServerResponse:)];
        [mc getLogoFor:selectedsweepid userid:userid selector:@selector(processLogoResponse:)];
        
        
        //Some variables to be used in this function locally
        UIImage *image, *imageLabel;
        
        //Associate methods with the actions
        UITapGestureRecognizer *actionTap1 = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapForAction1)] autorelease];
        [ivAction1 addGestureRecognizer:actionTap1];
        
        UITapGestureRecognizer *actionTap2 = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapForAction2)] autorelease];
        [ivAction2 addGestureRecognizer:actionTap2];
        
        UITapGestureRecognizer *letsGoTapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(letsGo)] autorelease];
        [ivLetsGo addGestureRecognizer:letsGoTapGesture];
        
        //Inititalize some globals variables related to the entry methods
        tappedTaskId = 0;
        tappedTaskType = @"";
        tappedSubscriptionLink = @"";
                
        //This is where we get the data for Entry methods and process it and Update UI
        NSLog(@"THE ENTRY METHOD REPONSE -> %@", results);
        actionListDictionary = results;
        int i = 0;
        //Loop through the NSDictionary object
        for(id key in actionListDictionary)
        {
            //Further breaking it down in a dictionary object
            NSDictionary *eachEntryMethod = [key valueForKey:@"Task"];
            //NSString *taskTitle = [eachEntryMethod valueForKey:@"task_title"];
            
            NSString *taskType = [eachEntryMethod valueForKey:@"task_type"];
            //Decide what sort of an action
            if([[[eachEntryMethod valueForKey:@"applied_with"] stringValue] isEqualToString:@"0"])
            {
                //Can apply with, check with task type etc and set appro graphics
                
                if([taskType isEqualToString:@"App"])
                {
                    image = [UIImage imageNamed: @"install_app_action.png"];
                    imageLabel = [UIImage imageNamed: @"install_app_label.png"];
                }
                else if([taskType isEqualToString:@"Video"])
                {
                    image = [UIImage imageNamed: @"watch_video_action.png"];
                    imageLabel = [UIImage imageNamed: @"watch_video_label.png"];
                }
                else if([taskType isEqualToString:@"Subscription"])
                {
                    image = [UIImage imageNamed: @"subscribe_action.png"];
                    imageLabel = [UIImage imageNamed: @"subscribe_label.png"];
                }
                
                
            }
            else{
                //Already applied, show thumps up
                //NSLog(@"Already applied with");
                
                //All actions would have thumbs up image
                image = [UIImage imageNamed: @"action_completed.png"];
                
                if([taskType isEqualToString:@"App"])
                {
                    imageLabel = [UIImage imageNamed: @"install_app_label.png"];
                }
                else if([taskType isEqualToString:@"Video"])
                {
                    imageLabel = [UIImage imageNamed: @"watch_video_label.png"];
                }
                else if([taskType isEqualToString:@"Subscription"])
                {
                    imageLabel = [UIImage imageNamed: @"subscribe_label.png"];
                }
            }
            
            //if i == 0 then the first action
            if(i == 0)
            {
                //Came till here
                //set visible to the action icon 1
                [ivAction1 setImage:image];
                ivAction1.hidden = NO;
                
                [ivActionLabel1 setImage:imageLabel];
                ivActionLabel1.hidden = NO;
            }
            else{
                //The second action, similar to the second one
                //set visible to the action icon 2
                [ivAction2 setImage:image];
                ivAction2.hidden = NO;
                
                [ivActionLabel2 setImage:imageLabel];
                ivActionLabel2.hidden = NO;
            }
            
            //Increment the counter
            i++;
        }
        
        //Retain the list object
        [actionListDictionary retain];
    }
    else{
        [self showAlertWithText:@"There are no options available right now." withTitle:@""];
    }
    
    
}

- (void) processLogoResponse:(NSDictionary *)logoResult {
    //NSLog(@"The logo response is -> %@", logoResult);
    for(id key in logoResult)
    {
        //Further breaking it down in a dictionary object
        NSDictionary *theLogoNode = [key valueForKey:@"Task"];
        //The logo file leaf
        NSString *logoFile = [theLogoNode valueForKey:@"logo_filename"];
        if(![logoFile isEqualToString:@""])
        {
            NSString *logoPath = [[NSString alloc] initWithFormat:@"%@files/logos/%@", IMGPATH, logoFile];
            //NSLog(@"The logo path -> %@", logoPath);
            //Set the logo
            NSURL *url = [NSURL URLWithString:logoPath];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [[UIImage alloc] initWithData:data];
            ivSponsorLogo.hidden = NO;
            [ivSponsorLogo setImage:img];
        }
        
    }
}


 This method hides all the action controls from the screen
 
- (void) hideAllActionControls {
    ivAction1.hidden = YES;
    ivActionLabel1.hidden = YES;
    ivAction2.hidden = YES;
    ivActionLabel2.hidden = YES;
}
*/
/**
 The Tap of the entry actions
 
- (void) handleTapForAction1 {
    //NSLog(@"Action button 1 is tapped");
    [self actionButtonTapResponse:0];
}

- (void) handleTapForAction2 {
    //NSLog(@"Action button 2 is tapped");
    [self actionButtonTapResponse:1];
}

- (void) actionButtonTapResponse: (int) index {
    
    
    UIImage *image, *imageLabel;
    int i = 0;
    
    for(id key in actionListDictionary)
    {
        //Further breaking it down in a dictionary object
        NSDictionary *eachEntryMethod = [key valueForKey:@"Task"];
        //NSString *taskTitle = [eachEntryMethod valueForKey:@"task_title"];
        
        NSString *taskType = [eachEntryMethod valueForKey:@"task_type"];
        int taskId = [[eachEntryMethod valueForKey:@"id"] integerValue];
        NSString *taskLink = [eachEntryMethod valueForKey:@"task_link"];
        
        //Decide what sort of an action
        if([[[eachEntryMethod valueForKey:@"applied_with"] stringValue] isEqualToString:@"0"])
        {
            //Can apply with, check with task type etc and set appro graphics
            if(i == index)
            {
                //Selected or active Case
                if([taskType isEqualToString:@"App"])
                {
                    image = [UIImage imageNamed: @"install_app_action_active.png"];
                    imageLabel = [UIImage imageNamed: @"install_app_label_active.png"];
                }
                else if([taskType isEqualToString:@"Video"])
                {
                    image = [UIImage imageNamed: @"watch_video_action_active.png"];
                    imageLabel = [UIImage imageNamed: @"watch_video_label_active.png"];
                }
                else if([taskType isEqualToString:@"Subscription"])
                {
                    image = [UIImage imageNamed: @"subscribe_action_active.png"];
                    imageLabel = [UIImage imageNamed: @"subscribe_label_active.png"];
                }
                
                //Store up the task type and the id in the variable
                tappedTaskType = taskType;
                tappedTaskId = taskId;
                tappedSubscriptionLink = taskLink;
            }
            else
            {
                //The not selected case
                if([taskType isEqualToString:@"App"])
                {
                    image = [UIImage imageNamed: @"install_app_action.png"];
                    imageLabel = [UIImage imageNamed: @"install_app_label.png"];
                }
                else if([taskType isEqualToString:@"Video"])
                {
                    image = [UIImage imageNamed: @"watch_video_action.png"];
                    imageLabel = [UIImage imageNamed: @"watch_video_label.png"];
                }
                else if([taskType isEqualToString:@"Subscription"])
                {
                    image = [UIImage imageNamed: @"subscribe_action.png"];
                    imageLabel = [UIImage imageNamed: @"subscribe_label.png"];
                }
                
                
            }
        }
        else{
            //Already applied, show thumps up
            //NSLog(@"Already applied with");
            
            //All actions would have thumbs up image
            image = [UIImage imageNamed: @"action_completed.png"];
            
            if([taskType isEqualToString:@"App"])
            {
                imageLabel = [UIImage imageNamed: @"install_app_label.png"];
            }
            else if([taskType isEqualToString:@"Video"])
            {
                imageLabel = [UIImage imageNamed: @"watch_video_label.png"];
            }
            else if([taskType isEqualToString:@"Subscription"])
            {
                imageLabel = [UIImage imageNamed: @"subscribe_action_label.png"];
            }
            
            //Reset the tracker variables
            tappedTaskType = @"";
            tappedTaskId = 0;
            tappedSubscriptionLink = @"";
        }
        
        //if i == 0 then the first action
        if(i == 0)
        {
            //Came till here
            //set visible to the action icon 1
            [ivAction1 setImage:image];
            ivAction1.hidden = NO;
            
            [ivActionLabel1 setImage:imageLabel];
            ivActionLabel1.hidden = NO;
        }
        else{
            //The second action, similar to the second one
            //set visible to the action icon 2
            [ivAction2 setImage:image];
            ivAction2.hidden = NO;
            
            [ivActionLabel2 setImage:imageLabel];
            ivActionLabel2.hidden = NO;
        }
        
        //Increment the counter
        i++;
    }
}


 The tap of the lets go button
 
- (void)letsGo{
    //Check if there is some task selected
    if(tappedTaskId != 0)
    {
        //Some task is selected, check for it's task type
        if([tappedTaskType isEqualToString:@"App"])
        {
            //This is the app case
            if(tappedTaskId > 0)
            {
                //One of our House Ads, open it on App store
                [self showAlertWithText:@"House install apps are pending" withTitle:@""];
            }
            else
            {
                //One of the ads from the Ad network
                [self showAlertWithText:@"We are holding App installs from ad networks right now" withTitle:@""];
            }
        }
        else if([tappedTaskType isEqualToString:@"Video"])
        {
            if(tappedTaskId > 0)
            {
                //One of our House Videos, play it
                [self showAlertWithText:@"House video ads are pending" withTitle:@""];
            }
            else
            {
                //One of the ads from the Ad network
                //Ad Colony Ad has to be served, toggle the variable
                isWatchingAdColonyVideo = YES;
                
                //Then unload the entry options view
                [vwEntryOptions removeFromSuperview];
                
                //Now play the video
                [AdColony playVideoAdForZone:@"vz5ef8111716944b97b66681" withDelegate:self withV4VCPrePopup:YES andV4VCPostPopup:YES];
                //[AdColony playVideoAdForZone:@"vzcddb829ff2aa4665abaf93"];
            }
        }
        else if([tappedTaskType isEqualToString:@"Subscription"])
        {
            //Resign the entry methos dialog
            [vwEntryOptions removeFromSuperview];
            //Then the subscrition view to the current view
            [self.view addSubview:vwSubscriptionViewer];
            
            //Open the URL
            //Create a URL object.
            //NSLog(@"The user id is %@, and tappedTask id is %d", userid, tappedTaskId);
            NSURL *url = [NSURL URLWithString:tappedSubscriptionLink];
            //URL Requst Object
            NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            //Load the request in the UIWebView.
            [wvSubscription loadRequest:requestObj];
        }
    }
    else{
        //Nothing is selected, let the user know about it!
        [self showAlertWithText:@"Please select a task to continue." withTitle:@""];
    }
}

- (void)enterSweepsTakesResponse:(NSDictionary *)results{
    //For the time being let's do nothing in here
}
*/
/**
 Shows a custom popou method with dynamic text and title
 */
-(void)showAlertWithText:(NSString*)theText withTitle:(NSString*)theTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:theTitle
                                                    message:theText
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


- (void)imagegalary{
    GalaryViewController *gogalary = [[GalaryViewController alloc]initWithNibName:@"GalaryViewController" bundle:nil];
    gogalary.imgarr =[[NSMutableArray alloc]initWithArray:imagearray];
    [self.navigationController pushViewController:gogalary animated:YES];
   
}
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)confirmbtn:(id)sender {
    if (timer1 != nil) 
        [timer1 invalidate];
    timer1 = nil;
    minbtn.userInteractionEnabled = YES;
    plubtn.userInteractionEnabled = YES;
    
    if ([ticketlb.text intValue]>0) 
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Do you want to apply %d Tickets?",[ticketlb.text intValue]*[creditneed intValue]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alert show];
        [alert release];
    
    }
    

}

-(void)applypointres:(NSDictionary *)results{
    
    NSString *resulttt = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
  //  NSLog(@"%@",results);
    if([resulttt isEqualToString:@"true"])
    {
        NSLog(@"%@",[results valueForKey:@"entrycount"]);
        
        
        //costlb.text =[NSString stringWithFormat:@"%@ Entries",[results valueForKey:@"entrycount"] ];
        //entries = [[NSString alloc]initWithFormat:@"%@",[results valueForKey:@"entrycount"]];
        successview.hidden = NO;
        
       // [self.view bringSubviewToFront:successview];
       //   NSLog(@"Here-->%@",costlb.text);
        
        
        /*
        notifylb.text = [NSString stringWithFormat:@"We will notify the winner via email and push notification by %@.",[[results valueForKey:@"SweepUser"]valueForKey:@"date"]];
        view3.clipsToBounds = YES;
        [self.view addSubview:view3];
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        
        CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
        CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
        CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
        CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
        
        NSArray *frameValues = [NSArray arrayWithObjects:
                                [NSValue valueWithCATransform3D:scale1],
                                [NSValue valueWithCATransform3D:scale2],
                                [NSValue valueWithCATransform3D:scale3],
                                [NSValue valueWithCATransform3D:scale4],
                                nil];
        [animation setValues:frameValues];
        
        NSArray *frameTimes = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.0],
                               [NSNumber numberWithFloat:0.5],
                               [NSNumber numberWithFloat:0.9],
                               [NSNumber numberWithFloat:1.0],
                               nil];
        
        [animation setKeyTimes:frameTimes];
        
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        animation.duration = .3;
        [secondwhiteview.layer addAnimation:animation forKey:@"popup"];
       
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open]; 
        
        BOOL success = [db executeUpdateWithFormat:@"UPDATE login_master SET credits=%@ where userid=%d",[[results valueForKey:@"SweepUser"]valueForKey:@"credits"],[userid intValue]];
        if (!success)
        {
            NSLog(@"update failed login table!!");
        }
        else 
        {
            NSLog(@"successfully updated logintable");
            credit.text = [NSString stringWithFormat:@"%@",[[results valueForKey:@"SweepUser"]valueForKey:@"credits"]];
            CGSize textSize = [credit.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
            x= textSize.width;
           
            if (plus) {
                CGRect frame = CGRectMake(268-x,5,10,20);
                plus.frame = frame;
            }
            if (creditst) {
                CGRect frame1 = CGRectMake(277,13,40,20);
                creditst.frame = frame1;
            }
        }
        NSLog(@" update Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        */
    } 
    else if([[results valueForKey:@"message"]isEqualToString:@"User Does Not Exists"]){
        
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open];
        
        BOOL d= [db executeUpdate:@ "Delete from login_master"];
        if (!d)
        {
            NSLog(@"delete failed login_master!!");
        }
        else {
            NSLog(@"successfully delete login_master");
            
        }
        NSLog(@"Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:[results valueForKey:@"message"] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
         [dc deleteData];
//        credit.text = @"0"; 
//        CGSize textSize = [credit.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
//        x= textSize.width;
//        CGRect frame = CGRectMake(268-x,5,10,20);
//        plus.frame = frame;
//        CGRect frame1 = CGRectMake(277,13,40,20);
//        creditst.frame = frame1;
    }
    else {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:[results valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
        
    }

}


- (IBAction)tweetplus:(id)sender {
    [SCTwitter initWithConsumerKey:[NSString stringWithFormat:@"%@",Twiiter_ConsumerKey] consumerSecret:[NSString stringWithFormat:@"%@",Twiiter_ConsumerSecretKey]];
    
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.8];
    UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingView addSubview:aiView];
    [aiView startAnimating];
    aiView.center =  CGPointMake(160, 187);
    [aiView release];
    [self.view addSubview:loadingView];
   
   
    [SCTwitter loginViewControler:self callback:^(BOOL success)
    
     {
         
         if (success)
         {
             FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
             [db open]; 
            BOOL success = [db executeUpdate:@"UPDATE setting SET twitter='YES' where isettingid=1"];
                 
                 if (!success)
                 {
                     NSLog(@"update failed twitter!!");
                 }
                 else 
                 {
                     NSLog(@"successfully updated twiiter");
                 }
             
             NSLog(@"Login is Success -  %i", success);
                                 
             [SCTwitter postWithMessage:@"Try the \"Sweepstakes App\" for the chance to win amazing prizes! Download the app today on your Android or iOS device! http://bit.ly/T5OKLg" callback:^(BOOL success, id result)
              {
                if (success) 
                  {
                      NSLog(@"Message send -  %i \n%@", success, result); 
                      if (DELEGATE.isHostAvailable) 
                      {
                          
                        [mc increasepoint:userid sweepid:selectedsweepid sharetype:@"T" selector:@selector(increasepointrestweet:)];
                          
                      }
                      else 
                      {
                          UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                          [alert show];
                          [alert release];
                      }   

                      
                  }
                  else
                  {
                      NSLog(@"error");
                      //  Alert(@"Alert", @"Not Login");  
                      Alert(@"", @"Message cant posted successfully.");  
                  }
                  loadingView.hidden = YES;
              }];

                       
         }
     }];
    loadingView.hidden = YES;

}

- (IBAction)fbplus:(id)sender {
   
    NSString *client_id = [[NSString alloc]initWithFormat:@"%@",Facebook_id];
	//alloc and initalize our FbGraph instance
	self.fbGraph = [[FbGraph alloc] initWithFbClientID:client_id];
    [fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:) andExtendedPermissions:@"user_about_me,email,publish_stream"];
}

- (IBAction)googleshare:(id)sender {
    NSString *kClientID = [[NSString alloc]initWithFormat:@"%@",GoogleShareid];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    share =[[[GooglePlusShare alloc] initWithClientID:kClientID] autorelease];
    share.delegate = self;
    appDelegate.share = share;
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open]; 
    
    BOOL success = [db executeUpdate:@"UPDATE setting SET google='YES' where isettingi=1"];
    if (!success)
    {
        NSLog(@"update failed google!!");
    }
    else 
    {
        NSLog(@"successfully updated google");
    }
    [db close];

    [[[[share shareDialog]
       setURLToShare:[NSURL URLWithString:@"http://bit.ly/T5OKLg"]]
      setPrefillText:@"Try the \"Sweepstakes App\" for the chance to win amazing prizes! Download the app today on your Android or iOS device!"] open];
 //   [[share shareDialog] open];

    

}
- (void)finishedSharing: (BOOL)shared {
    // Display success message, or ignore.
    NSString *text = shared ? @"YES" : @"NO";
 
    if ([text isEqualToString:@"YES"]) {
        
        if (DELEGATE.isHostAvailable) 
        {
            
            [mc increasepoint:userid sweepid:selectedsweepid sharetype:@"G" selector:@selector(increasepointresgoogle:)];
            
        }
        else 
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }   

        
        
    }else {
        Alert(@"", @"Message cant posted successfully.");
    }
    
   
}



- (void)fbGraphCallback:(id)sender {
	
	if ( (fbGraph.accessToken == nil) || ([fbGraph.accessToken length] == 0) ) 
    {
		
		NSLog(@"You pressed the 'cancel' or 'Dont Allow' button, you are NOT logged into Facebook...I require you to be logged in & approve access before you can do anything useful....");
		
		//restart the authentication process.....
		[fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:) 
							 andExtendedPermissions:@"user_about_me,email,publish_stream"];
		
	} 
    else {
		//pop a message letting them know most of the info will be dumped in the log
		//www.thesweepsapp.com
	//	NSLog(@"------------>CONGRATULATIONS<------------, You're logged into Facebook...  Your oAuth token is:  %@", fbGraph.accessToken);
       
        NSMutableDictionary *variables = [NSMutableDictionary dictionaryWithCapacity:3];
        
       // [variables setObject:[NSString stringWithString:@""] forKey:@"message"];
        [variables setObject:@"http://bit.ly/T5OKLg" forKey:@"link"];
        [variables setObject:@"Sweepstakes App" forKey:@"name"];
        [variables setObject:@"Check out the \"Sweepstakes App\" on Android and iOS. Every day you have a chance of winning vacations, electronics, money and many more prizes!" forKey:@"description"];
        
        FbGraphResponse *fb_graph_response = [fbGraph doGraphPost:@"me/feed" withPostVars:variables];
      
        
        
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *facebook_response = [parser objectWithString:fb_graph_response.htmlResponse error:nil];	
       
        [parser release];
        
        //let's save the 'id' Facebook gives us so we can delete it if the user presses the 'delete /me/feed button'
        self.feedPostId = (NSString *)[facebook_response objectForKey:@"id"];
       
        if (feedPostId.length >0) {
          
            if (DELEGATE.isHostAvailable) 
            {
                [mc increasepoint:userid sweepid:selectedsweepid sharetype:@"F" selector:@selector(increasepointres:)];                
            }
            else 
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }   

            
           
            
            FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
            [db open]; 
            
            BOOL success = [db executeUpdate:@"UPDATE setting SET facebook='YES' where isettingid=1"];
            if (!success)
            {
                NSLog(@"update failed facebook!!");
            }
            else 
            {
                NSLog(@"successfully updated facebook");
            }
            [db close];
        }
        else {
             NSLog(@"Unsuccess");
        }
    


    }
}
-(void)increasepointres:(NSDictionary *)results{
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
  
    
    if([result isEqualToString:@"true"]){
        fbbtn.enabled = NO;
        /*
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open]; 
        
        BOOL success = [db executeUpdateWithFormat:@"UPDATE login_master SET credits=%@ where userid=%d",[results valueForKey:@"credits"],[userid intValue]];
        
        if (!success)
        {
            NSLog(@"update failed login table!!");
        }
        else 
        {
            Alert(@"", @"Thanks for sharing!");
            NSLog(@"successfully updated logintable");
            credit.text = [NSString stringWithFormat:@"%@",[results valueForKey:@"credits"]];
            CGSize textSize = [credit.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
            x= textSize.width;
            
            if (plus) {
                CGRect frame = CGRectMake(268-x,5,10,20);
                plus.frame = frame;
            }
            if (creditst) 
            {
                CGRect frame1 = CGRectMake(277,13,40,20);
                creditst.frame = frame1;
            }
        }
        NSLog(@" update Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
         */
    } else if([[results valueForKey:@"message"]isEqualToString:@"User Does Not Exists"]){
        
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open];
        
        BOOL d= [db executeUpdate:@ "Delete from login_master"];
        if (!d)
        {
            NSLog(@"delete failed login_master!!");
        }
        else {
            NSLog(@"successfully delete login_master");
            
        }
        NSLog(@"Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:[results valueForKey:@"message"] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
         [dc deleteData];
//        credit.text = @"0"; 
//        CGSize textSize = [credit.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
//        x= textSize.width;
//        CGRect frame = CGRectMake(268-x,5,10,20);
//        plus.frame = frame;
//        CGRect frame1 = CGRectMake(277,13,40,20);
//        creditst.frame = frame1;
    }
    else {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:[results valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
        
    }


}
-(void)increasepointrestweet:(NSDictionary *)results{
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
  
    
    if([result isEqualToString:@"true"]){
        tweetbtn.enabled = NO;
        /*
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open]; 
        
        BOOL success = [db executeUpdateWithFormat:@"UPDATE login_master SET credits=%@ where userid=%d",[results valueForKey:@"credits"],[userid intValue]];
        
        if (!success)
        {
            NSLog(@"update failed login table!!");
        }
        else 
        {
            Alert(@"", @"Thanks for sharing!");
            NSLog(@"successfully updated logintable");
            
            credit.text = [NSString stringWithFormat:@"%@",[results valueForKey:@"credits"]];
            CGSize textSize = [credit.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
            x= textSize.width;
            
            if (plus) {
                CGRect frame = CGRectMake(268-x,5,10,20);
                plus.frame = frame;
            }
            if (creditst) 
            {
                CGRect frame1 = CGRectMake(277,13,40,20);
                creditst.frame = frame1;
            }
        }
        NSLog(@" update Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
         */
    } else if([[results valueForKey:@"message"]isEqualToString:@"User Does Not Exists"]){
        
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open];
        
        BOOL d= [db executeUpdate:@ "Delete from login_master"];
        if (!d)
        {
            NSLog(@"delete failed login_master!!");
        }
        else {
            NSLog(@"successfully delete login_master");
            
        }
        NSLog(@"Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:[results valueForKey:@"message"] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
         [dc deleteData];
//        credit.text = @"0"; 
//        CGSize textSize = [credit.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
//        x= textSize.width;
//        CGRect frame = CGRectMake(268-x,5,10,20);
//        plus.frame = frame;
//        CGRect frame1 = CGRectMake(277,13,40,20);
//        creditst.frame = frame1;
    }
    else {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:[results valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
        
    }

    
}
-(void)increasepointresgoogle:(NSDictionary *)results{
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
  
    
    if([result isEqualToString:@"true"]){
        googlebtn.enabled = NO;
        /*
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open]; 
        
        BOOL success = [db executeUpdateWithFormat:@"UPDATE login_master SET credits=%@ where userid=%d",[results valueForKey:@"credits"],[userid intValue]];
        
        if (!success)
        {
            NSLog(@"update failed login table!!");
        }
        else 
        {
            Alert(@"", @"Thanks for sharing!");
            NSLog(@"successfully updated logintable");
            credit.text = [NSString stringWithFormat:@"%@",[results valueForKey:@"credits"]];
            CGSize textSize = [credit.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
            x= textSize.width;
            
            if (plus) {
                CGRect frame = CGRectMake(268-x,5,10,20);
                plus.frame = frame;
            }
            if (creditst) 
            {
                CGRect frame1 = CGRectMake(277,13,40,20);
                creditst.frame = frame1;
            }
        }
        NSLog(@" update Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
         */
    } else if([[results valueForKey:@"message"]isEqualToString:@"User Does Not Exists"]){
        
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open];
        
        BOOL d= [db executeUpdate:@ "Delete from login_master"];
        if (!d)
        {
            NSLog(@"delete failed login_master!!");
        }
        else {
            NSLog(@"successfully delete login_master");
            
        }
        NSLog(@"Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:[results valueForKey:@"message"] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
         [dc deleteData];
//        credit.text = @"0"; 
//        CGSize textSize = [credit.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
//        x= textSize.width;
//        CGRect frame = CGRectMake(268-x,5,10,20);
//        plus.frame = frame;
//        CGRect frame1 = CGRectMake(277,13,40,20);
//        creditst.frame = frame1;
    }
    else {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:[results valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
        
    }

    
}


- (IBAction)minus:(id)sender {
    timer1 = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(minusvalue:) userInfo:nil repeats:YES];
    plubtn.userInteractionEnabled = NO;   
    
}

-(void)minusvalue:(id)sender {
    slider.value = [ticketlb.text intValue]-1;
    ticketlb.text = [NSString stringWithFormat:@"%d",(int)slider.value ];
    plubtn.userInteractionEnabled = NO;
}

- (IBAction)minusbtndrag:(id)sender {
    if (timer1 != nil) 
        [timer1 invalidate];
    timer1 = nil;
     plubtn.userInteractionEnabled = YES;  

}

- (IBAction)minusbtn:(id)sender {
    slider.value = [ticketlb.text intValue]-1;
    ticketlb.text = [NSString stringWithFormat:@"%d",(int)slider.value ];
    if (timer1 != nil) 
        [timer1 invalidate];
    timer1 = nil;
    plubtn.userInteractionEnabled = YES;
       
}


- (IBAction)plus:(id)sender {
    timer1 = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(plusvalue:) userInfo:nil repeats:YES];
    minbtn.userInteractionEnabled = NO;
}

-(void)plusvalue:(id)sender {
    slider.value = [ticketlb.text intValue]+1;
    ticketlb.text = [NSString stringWithFormat:@"%d",(int)slider.value ];
    minbtn.userInteractionEnabled = NO;
}
- (IBAction)plusbtn:(id)sender {
    
    slider.value = [ticketlb.text intValue]+1;
    ticketlb.text = [NSString stringWithFormat:@"%d",(int)slider.value ];
    if (timer1 != nil) 
        [timer1 invalidate];
    timer1 = nil;
    minbtn.userInteractionEnabled = YES;
}
- (IBAction)plusbtndrag:(id)sender {
    if (timer1 != nil) 
        [timer1 invalidate];
    timer1 = nil;
     minbtn.userInteractionEnabled = YES;
}




/*

- (IBAction)minusbtn:(id)sender {
    
    slider.value = [ticketlb.text intValue]-1;
    ticketlb.text = [NSString stringWithFormat:@"%d",(int)slider.value ];
   
    
}

- (IBAction)plusbtn:(id)sender {
    
    slider.value = [ticketlb.text intValue]+1;
    ticketlb.text = [NSString stringWithFormat:@"%d",(int)slider.value ];

}
 */
- (IBAction)expandweb:(id)sender {
    if (IS_IPHONE_5) {
        [view4 setFrame:CGRectMake(0, 32, 320, 468)];
    }
    else{
        [view4 setFrame:CGRectMake(0, 32, 320, 379)];
    }

    [self.view addSubview:view4];
    [view4 setFrame:CGRectMake(0, 267, 320, 141)];
    [view4 setBounds:CGRectMake(0, 0, 320, 141)];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
   
    if (IS_IPHONE_5) {
    [view4 setFrame:CGRectMake(0, 32, 320, 468)];
    }
    else{
     [view4 setFrame:CGRectMake(0, 32, 320, 379)];
    }
    [UIView commitAnimations];

    
}

- (IBAction)closewebview:(id)sender {
    [view4 removeFromSuperview];
}
/*
- (IBAction)closeSubscriptionView:(id)sender {
    //Close the subscription view
    [vwSubscriptionViewer removeFromSuperview];
    
    //At this point make a call to the server to enter the user in the Sweepstakes
    [mc enterUser:userid inSweepstakes:selectedsweepid forTask:[NSString stringWithFormat:@"%i", tappedTaskId] selector:@selector(enterSweepsTakesResponse:)];
    
    //Show the entry confirmation dialog
    [self showEntryConfirmationDialog];
}

- (void) showEntryConfirmationDialog{
    //Show the confirmation dialog
    [self.view addSubview:vwEntryConfirm];
    
    //Associate the unloading function with tyhis gray area
    //Associate methods with the actions
    UITapGestureRecognizer *entryGrayAreaTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(unloadConfDiagTapDelegate1)] autorelease];
    [ivEntryConfirmDarkArea addGestureRecognizer:entryGrayAreaTap];
    
    //For the close button
    UITapGestureRecognizer *closeButtonConfDialogTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(unloadConfDiagTapDelegate2)] autorelease];
    [ivCloseConfirmationDialog addGestureRecognizer:closeButtonConfDialogTap];
    
    //For the enter again tap
    UITapGestureRecognizer *enterAgainTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterAgainInThisST)] autorelease];
    [ivEnterAgain addGestureRecognizer:enterAgainTap];
    
    //Set the text for thanks label
    lblThanksForEntering.text = [[NSString alloc] initWithFormat:@"Thanks for entering the %@ sweepstakes.", headerlb.text];
    lblThanksForEntering.textAlignment = UITextAlignmentCenter;
    lblThanksForEntering.font = [UIFont fontWithName:@"Calibri" size:16];
}


 The unloading method of the gray area
- (void)unloadConfDiagTapDelegate1{
    //[self unloadEntryConfirmationDialog];
    [vwEntryConfirm removeFromSuperview];
}
- (void)unloadConfDiagTapDelegate2{
    //[self unloadEntryConfirmationDialog];
    [vwEntryConfirm removeFromSuperview];
}
- (void)unloadEntryConfirmationDialog {
    [vwEntryConfirm removeFromSuperview];
}
*/
/**
 Enter again method
 */
/*
- (void)enterAgainInThisST {
    //First unload the entry confirmation view
    [vwEntryConfirm removeFromSuperview];
    
    //Then load the entry options view again
    //Make server call to fetch task details
    [mc getEntryMethodsFor:userid sweepid:selectedsweepid selector:@selector(processEntryMethodServerResponse:)];
}
*/

//****************AD COLONY RELATED METHODS FOLLOW*****************//

/**
 Returns the ad colony ID
 */

-(NSString*)adColonyApplicationID{
    return @"app835402282cbd495485145d";
    
}

-(NSDictionary*)adColonyAdZoneNumberAssociation{
    //return [NSDictionary dictionaryWithObjectsAndKeys:@"vzcddb829ff2aa4665abaf93",[NSNumber numberWithInt:1],nil];
    return [NSDictionary dictionaryWithObjectsAndKeys:@"vz5ef8111716944b97b66681",[NSNumber numberWithInt:1],nil];            //This is the LIVE ZONE ID
    
    //return [NSDictionary dictionaryWithObjectsAndKeys:@"vz086efa28e79548649ccf9a",[NSNumber numberWithInt:1],nil];
    
}

-(NSString*) stringToSha1:(NSString*)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}

-(NSString *) hashStringtoSHA1:(NSString *) strToHash
{
    // **************
    const char digest[CC_SHA1_DIGEST_LENGTH];
    NSData *stringBytes = [strToHash dataUsingEncoding: NSUTF8StringEncoding]; /* or some other encoding */
    if (CC_SHA1([stringBytes bytes], [stringBytes length], digest)) {
        /* SHA-1 hash has been calculated and stored in 'digest'. */
    
    }
    //return digest;
    //return [NSString stringWithCString:digest encoding:NSUTF8StringEncoding];
    //return [NSString stringWithFormat:@"%s", digest];
    return [NSString stringWithUTF8String:digest];
    // *************
}


-(NSString*)getIP
{
    NSUInteger  an_Integer;
    NSArray * ipItemsArray;
    NSString *externalIP;
    
    NSURL *iPURL = [NSURL URLWithString:@"http://www.dyndns.org/cgi-bin/check_ip.cgi"];
    
    if (iPURL) {
        NSError *error = nil;
        NSString *theIpHtml = [NSString stringWithContentsOfURL:iPURL encoding:NSUTF8StringEncoding error:&error];
        if (!error) {
            NSScanner *theScanner;
            NSString *text = nil;
            
            theScanner = [NSScanner scannerWithString:theIpHtml];
            
            while ([theScanner isAtEnd] == NO) {
                
                // find start of tag
                [theScanner scanUpToString:@"<" intoString:NULL] ;
                
                // find end of tag
                [theScanner scanUpToString:@">" intoString:&text] ;
                
                // replace the found tag with a space
                //(you can filter multi-spaces out later if you wish)
                theIpHtml = [theIpHtml stringByReplacingOccurrencesOfString:
                             [ NSString stringWithFormat:@"%@>", text]
                                                                 withString:@" "] ;
                ipItemsArray =[theIpHtml  componentsSeparatedByString:@" "];
                an_Integer=[ipItemsArray indexOfObject:@"Address:"];
                externalIP =[ipItemsArray objectAtIndex:  ++an_Integer];
            }
            NSLog(@"%@",externalIP);
        } else {
            NSLog(@"Oops... g %d, %@", [error code], [error localizedDescription]);
        }
    }
    return externalIP;
}
-(NSString *)SponsorPay_offerapi
{
    
    NSLog(@"SponsorPay_offerapi");
    //NSString  *appid =@"10628";       //Just tried with the Android version :)
    //NSString  *appid =@"5588";          //From the previous developer
    NSString  *appid =@"10780";         //Received this one from Ben on 4th Apr, 2013
    NSString  *uid = userid;
    //NSString  *ip =[NSString stringWithFormat:@"%@",[self getIP]];
    NSString  *locale =@"en";
    //UIDevice  *myDevice=[UIDevice currentDevice];
    //NSString  *device_id =[[myDevice identifierForVendor] UUIDString];
    //NSString  *ps_time =@ "";
    NSString  *os_version =[[UIDevice currentDevice] systemVersion];
    NSString  *hashkey=@"";
    //NSString  *page =@"";
    NSString  *timestamp =@"";
    //NSString  *pub0 =@"";
    NSTimeInterval  rightNow = [[NSDate date] timeIntervalSince1970];
    timestamp = [NSString stringWithFormat:@"%.0f", rightNow];
    
    
     
     
    //NSString *str=[NSString stringWithFormat:@"appid=%@&device_id=%@&ip=%@&locale=%@&page=%@&ps_time=%@&pub0=%@&timestamp=%@&uid=%@",appid,device_id,ip,locale,page,ps_time,pub0,timestamp,uid];
    NSString *str = [NSString stringWithFormat:@"appid=%@&format=json&locale=%@&offer_types=101&os_version=%@&timestamp=%@&uid=%@", appid, locale, os_version, timestamp, uid];
    NSString *strToHash = [NSString stringWithFormat:@"appid=%@&format=json&locale=%@&offer_types=101&os_version=%@&timestamp=%@&uid=%@&%@", appid, locale, os_version, timestamp, uid, SPONSORPAY_API_KEY];
    
     
    //hashkey=[NSString stringWithString:[self stringToSha1:str]];
    //hashkey = [self hashStringtoSHA1:str];
    hashkey = [self stringToSha1:strToHash];
 
     
    NSMutableString *URL;
    //URL = [NSString stringWithFormat:@"http://api.sponsorpay.com/feed/v1/offers.json?appid=%@&device_id=%@&ip=%@&locale=%@&os_version=%@&page=%@&ps_time=%@&pub0=%@&uid=%@&timestamp=%@&hashkey=%@",appid,device_id,ip,locale,os_version,page,ps_time,pub0,uid,timestamp,hashkey];
    
    URL = [NSString stringWithFormat:@"http://api.sponsorpay.com/feed/v1/offers.json?%@&hashkey=%@", str, hashkey];
     
    //	URL = [NSString stringWithFormat:@"http://api.sponsorpay.com/feed/v1/offers.json?appid=%@&device_id=%@&ip=%@&locale=%@&os_version=%@&uid=%@&timestamp=%@&hashkey=%@",appid,device_id,ip,locale,os_version,uid,timestamp,hashkey]
     
    // URL=[NSString stringWithFormat:@"%@",@"http://api.sponsorpay.com/feed/v1/offers.json?appid=5588&device_id=79cc1e36a3325328ab10024a2d9e54e700000000&ip=122.169.48.168&locale=en&os_version=6.0&uid=25632&timestamp=1353558966&hashkey=ecbbd1f9013fc303080b303bec2f8312a0ad9523"];
    
    NSLog(@"THE SPONSORPAY URL IS --> :%@",URL);
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[URL stringByReplacingOccurrencesOfString:@" " withString:@"%20"]]];
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    NSString *returnString = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"THE SPONSORPAY RESPONSE  --> :%@",returnString);
    
    return returnString;
    
}






- (IBAction)entertowin:(id)sender {
    
    //Hide all controls first
    // [self hideAllActionControls];
    
    //Make server call to fetch task details
    //  [mc getEntryMethodsFor:userid sweepid:selectedsweepid selector:@selector(processEntryMethodServerResponse:)];
    
    // [self adColonyVirtualCurrencyAwardedByZone:@"vz5ef8111716944b97b66681" currencyName:@"Entry" currencyAmount:1];
    
    // Call Adcolony To Play Video
    
    
    /*
     if ([FlurryAds adReadyForSpace:@"Sweeps_Entry"]) {
     [FlurryAds displayAdForSpace:@"Sweeps_Entry" onView:self.view]; }
     else {
     //[FlurryAds fetchAdForSpace:@"Video Zone" frame:self.view.frame size:FULLSCREEN];
     [FlurryAds fetchAndDisplayAdForSpace:@"Sweeps_Entry" view:self.view size:FULLSCREEN];
     }
     */
    
    //[DELEGATE.cardCounter setValue:[NSNumber numberWithInt:[[DELEGATE.cardCounter valueForKey:selectedsweepid] integerValue]+1] forKey:selectedsweepid];
    
    
    /*
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    [DELEGATE setCardCounter:[[NSMutableDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithContentsOfFile:[[paths objectAtIndex:0]stringByAppendingPathComponent:@"myPlistFile.plist"]]]];
    
    NSLog(@"%@",[DELEGATE cardCounter]);
    
    if ([[DELEGATE.cardCounter valueForKey:selectedsweepid] integerValue]==6) {
    
        [DELEGATE.cardCounter setValue:[NSNumber numberWithInt:0] forKey:selectedsweepid];
         [DELEGATE.cardCounter writeToFile:[[paths objectAtIndex:0]stringByAppendingPathComponent:@"myPlistFile.plist"] atomically:YES];
        //[self showPopup1];
    }
    else{
        show =  YES;
     
    }*/
    show =  YES;
    [AdColony playVideoAdForZone:@"vz5ef8111716944b97b66681" withDelegate:self withV4VCPrePopup:YES andV4VCPostPopup:YES];
    
}

-(void) showVideoConfirmationDialog{
    
    //Load up the number of entries the user is seeing the generic dialog from UserDefaults
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    int entry_count_in_row = [[prefs valueForKey:@"entryCountInRow"] intValue];
    //[prefs setObject:godetail.selectedsweepid forKey:@"currentSweepsid"];
    
    
    
    //check if the entry count is more than or equal to 5
    NSLog(@"CONF DIALOG SHOULD BE POPPING UP NOW");
    /*if(entry_count_in_row >= 2)
    {
        //Show the sponsorpay dialog, but before that check if Sponsor Pay is returning anything
        SBJsonParser *parser;
        parser = [[SBJsonParser alloc] init];
        NSDictionary *results = [parser objectWithString:[self SponsorPay_offerapi] error:nil];
    
        //Count of offers
        int offerCount = [[results valueForKey:@"count"] intValue];
        NSLog(@"OFFER COUNT IS --> %d", offerCount);
    
        //Check if results have offers in it
        if(offerCount > 0)
        {
            [self.view addSubview:MainPopup1];
            //[self.view bringSubviewToFront:MainPopup1];
            [self getRandomSponsorPayOffer:results];
            //Reset the view counter
            [prefs setObject:@"0" forKey:@"entryCountInRow"];
        }
        else
        {
            //Show normal dialog
            [self.view addSubview:vwGenericConfDialog];
        }
    
        //NSLog(@"THE APP DOWNLOAD CONF DIALOG SHOULD SHOW UP");
    
        
    }
    else{*/
        
        //Let's load up the generic confirmation dialog
        [self.view addSubview:vwGenericConfDialog];
        //Increment entry counter and save in userdefaults
        entry_count_in_row++;
        [prefs setObject:[NSString stringWithFormat:@"%d", entry_count_in_row] forKey:@"entryCountInRow"];
    //}
    
    //Increase the current entries for the user
    //Also increment the total number of entries for this sweepstakes for this user
    int finalTotEntries = [costlb.text intValue] + 1;
    //Then set to the label again
    costlb.text = [NSString stringWithFormat:@"%d", finalTotEntries];
    entries = [NSString stringWithFormat:@"%d", finalTotEntries];
}

-(NSDictionary *) getRandomSponsorPayOffer: (NSDictionary *) entireSet
{
    NSArray *offers = [entireSet objectForKey:@"offers"];
    NSString *min = @"0"; //Get the current text from your minimum and maximum textfields.
    NSString *max = [offers count] - 1;
    int randNum = rand() % ([max intValue] - [min intValue] + 1) + [min intValue];

    
    NSString *title = [[offers objectAtIndex:randNum] valueForKey:@"title"];
    NSLog(@"THE RANDOM TITLE %@", title);
    mainlbl1.text = [NSString stringWithFormat:@"You have earned a special offer! Download \"%@\" and open the app to earn 5 entries", title];
    
    
    /*
    //Get the app icon
    NSString *iconStr = [[[offers objectAtIndex:randNum] objectForKey:@"thumbnail"] valueForKey:@"hires"];
    //NSLog(@"THE ICON STR IS %@", iconStr);
    NSURL *url = [NSURL URLWithString:iconStr];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    [ivSPOfferIcon setImage:image];
     */
    
    //NExt store up the URL in the variable
    spAppURL = [[offers objectAtIndex:randNum] valueForKey:@"link"];
    
    
    //mainlbl1.text = ;
    /*
    for (id key in offers) {
        NSString *strTitle = [offers valueForKey:@"title"];
        NSLog(@"The Title is --> %@", strTitle);
    }
    */
}

//************ALL VUNGLE RELATED CALLBACK FOLLOWS*****************


-(void)didvungleMoviePlayed:(NSDictionary*)dict{

    NSLog(@"CUSTOM: VUNGLE RESULT HANDLER -->%@",dict);
    
    if ([dict valueForKey:@"successfull"]) {
       
        
        if (DELEGATE.isHostAvailable)
        {
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSString *currentSweepsID = [prefs valueForKey:@"currentSweepsid"];
            [mc getNumberOfEntriesForUser:userid forSweepstakes:currentSweepsID selector:@selector(userentrieres:)];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
        
        //Show the confirmation dialog here
        //[self showVideoConfirmationDialog];
    }

}




-(void)vungleMoviePlayed:(VGPlayData*)playData{
    
    if ([playData playedFull]) {
        NSLog(@"vungleMoviePlayed;-->%@",playData);
        vungleMoviePlayed=YES;
        [drk hide];
        //[mc vungleMoviePlayed:userid sweepstakeid:selectedsweepid Taskid:@"0" Otherentryoptions:@"vungle_vid" selector:@selector(didvungleMoviePlayed:)];
    }
    
}
-(void)vungleStatusUpdate:(VGStatusData*)statusData{
    NSLog(@"vungleStatusUpdate-->%@",statusData);
}
-(void)vungleViewDidDisappear:(UIViewController*)viewController{
    //NSLog(@"VUNGLE VIEW DID DISSAPEAR --> %@", viewController);
    NSLog(@"vungleViewDidDisappear: %f", [NSDate timeIntervalSinceReferenceDate]);
    [drk hide];
    if (vungleMoviePlayed) {
        [mc setDelegate:viewController.parentViewController];
        [mc vungleMoviePlayed:userid sweepstakeid:selectedsweepid Taskid:@"0" Otherentryoptions:@"vungle_vid" selector:@selector(didvungleMoviePlayed:)];
        [self showVideoConfirmationDialog];
        
    }
   
}
-(void)vungleViewWillAppear:(UIViewController*)viewController{
    NSLog(@"vungleViewWillAppear");
}


//-(void)adColonyVideoAdsNotReadyInZone:(NSString *)zone{
//  // [self.view makeToast:@"AdColony videos temporarily unavailable in your zone" duration:1.0 position:@"bottom"];
//    
//    // If ads are not ready than display flurry ads.
//
//    if (show == YES) {
//        show = NO;
//        [drk showWithMessage:nil];
//            NSLog(@"AdColony: videos temporarily unavailable in zone: %@", zone);
//        
//        if ([VGVunglePub adIsAvailable]) {
//            [VGVunglePub setDelegate:self];
//            [VGVunglePub playModalAd:self animated:YES];
//            
//        }
//        else{
//            
//            if ([FlurryAds adReadyForSpace:@"Sweeps_Entry"]) {
//                [FlurryAds displayAdForSpace:@"Sweeps_Entry" onView:self.view]; }
//            else {
//                //[FlurryAds fetchAdForSpace:@"Video Zone" frame:self.view.frame size:FULLSCREEN];
//                [FlurryAds fetchAndDisplayAdForSpace:@"Sweeps_Entry" view:self.view size:FULLSCREEN];
//            }
//        }
//
//        
//        
//      
//    }
//}
- (void) adColonyVideoAdNotServedForZone:(NSString *)zone {
   //  [self.view makeToast:@"AdColony didn't serve a video for your zone" duration:1.0 position:@"bottom"];
    
    NSLog(@"adColonyVideoAdNotServedForZone:AdColony did not serve a video for zone %@", zone);
    
    // If ads are not ready than display flurry ads.
    if (show == YES) {
        
        show = NO;
        [drk showWithMessage:nil];
        if ([VGVunglePub adIsAvailable]) {
         
            [VGVunglePub setDelegate:self];
            [VGVunglePub playModalAd:self animated:YES];
            
        }
        else{
              
            if ([FlurryAds adReadyForSpace:@"Sweeps_Entry"]) {
                [FlurryAds displayAdForSpace:@"Sweeps_Entry" onView:self.view]; }
            else {
                //[FlurryAds fetchAdForSpace:@"Video Zone" frame:self.view.frame size:FULLSCREEN];
                [FlurryAds fetchAndDisplayAdForSpace:@"Sweeps_Entry" view:self.view size:FULLSCREEN];
            }
        }
    }

  
    
}

- (void) adColonyTakeoverEndedForZone:(NSString *)zone
                               withVC:(BOOL)withVirtualCurrencyAward {
    if(withVirtualCurrencyAward == TRUE)
    {
        
        // *******AT THIS POINT GET THE SWEEPS ID FROM THE USERDEFAULTS********* //
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *currentSweepsID = [prefs valueForKey:@"currentSweepsid"];
        // ********************************************************************* //
        
        NSLog(@"The SWEEPS ID at this point is --> %@ || and the current variable is --> %@", selectedsweepid, currentSweepsID);
        //Call server to enter this user in the sweepstakes
        // [mc enterSTForAdColonyUser:userid inSweepstakes:selectedsweepid selector:@selector(processAdColonyEntryResponse:)];
        
        NSDictionary *args = [[NSDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userid,currentSweepsID,[NSString stringWithFormat:@"%d",1],@"Adcolony", nil] forKeys:[NSArray arrayWithObjects:@"userid",@"sweepstakeid",@"entry",@"type", nil]]];
        [Apsalar event:@"Enter To Win" withArgs:args];
        
        // Call server to increase 1 entry of user
        if (DELEGATE.isHostAvailable)
        {
            
            //[mc applypoint:userid sweepid:selectedsweepid credits:[NSString stringWithFormat:@"%d",amount] selector:@selector(applypointres:)];
            //[mc enterSTForAdColonyUser:userid inSweepstakes:selectedsweepid  selector:@selector(processAdColonyEntryResponse:)];
            [mc enterSTForAdNetworkUser:userid inSweepstakes:currentSweepsID forNetwork:@"adcolony_video" selector:@selector(processAdColonyEntryResponse:)];
            DELEGATE.applied = YES;
            
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
        
        [self showVideoConfirmationDialog];
    }

    
}

- (void)adColonyVirtualCurrencyAwardedByZone:(NSString *)zone currencyName:(NSString*)name currencyAmount:(int)amount {
    
    
    NSLog(@" = = = = = The AD COLONY callback is hit = = = = = =");
    
   
    
    
}

-(void)processAdColonyEntryResponse:(NSDictionary *)results{
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
    NSLog(@"The success key is -> %@", result);
    if([result isEqualToString:@"1"]){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        
        /*
        [DELEGATE setCardCounter:[[NSMutableDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithContentsOfFile:[[paths objectAtIndex:0]stringByAppendingPathComponent:@"myPlistFile.plist"]]]];
        [DELEGATE.cardCounter setValue:[NSNumber numberWithInt:[[DELEGATE.cardCounter valueForKey:selectedsweepid] integerValue]+1] forKey:selectedsweepid];
        [DELEGATE.cardCounter writeToFile:[[paths objectAtIndex:0]stringByAppendingPathComponent:@"myPlistFile.plist"] atomically:YES];
         */
   
        NSLog(@"Network entry method CALLBACK, successview state is --> %c", successview.hidden);
        
        
        /*
        //Show the entry confirmation dialog
        successview.hidden = NO;
        [self.view bringSubviewToFront:successview];
         */
        
        
        //[self showAlertWithText:@"You will be entered in the sweepstakes" withTitle:@"Sweepstakes App"];
    }
}
 
//****************FLURRY RELATED METHODS*****************//
-(void)spaceWillDismiss:(NSString *)adSpace interstitial:(BOOL)interstitial{
    NSLog(@"-->spaceWillDismiss");
 
}
-(void)spaceDidDismiss:(NSString *)adSpace interstitial:(BOOL)interstitial{
    NSLog(@"-->spaceDidDismiss");
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] performSelector:NSSelectorFromString(@"setOrientation:") withObject:(id)UIInterfaceOrientationPortrait];
    
   // Check Users current Entry for This sweepstake
    if (DELEGATE.isHostAvailable)
    {
        
      // [mc getuserentries:userid sweepstakeid:selectedsweepid selector:@selector(userentrieres:)];
        
        [mc enterSTForAdNetworkUser:userid inSweepstakes:selectedsweepid forNetwork:@"flurry_video" selector:@selector(processAdColonyEntryResponse:)];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *currentSweepsID = [prefs valueForKey:@"currentSweepsid"];
        //[mc getNumberOfEntriesForUser:userid forSweepstakes:currentSweepsID selector:@selector(userentrieres:)];
        //Show video confirmation dialog
        [self showVideoConfirmationDialog];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
    
}
-(void)spaceDidReceiveAd:(NSString *)adSpace{
    
    [drk hide];
    
}
- (void) spaceDidFailToReceiveAd:(NSString*)adSpace error:(NSError *)error{
    
    [drk hide];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"we are currently not accepting new sweepstakes entries. Please come back tomorrow to enter." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
  //  [self.view makeToast:@"No ads found." duration:0.7 position:@"bottom"];
    
}
-(void)userentrieres:(NSDictionary *)results{
       NSLog(@"results-->>%@",results);
        // Check user's entry is increase or not. If it increase than display success view
        if (entries.intValue != [[results valueForKey:@"entries"]intValue]) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask, YES);
            [DELEGATE setCardCounter:[[NSMutableDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithContentsOfFile:[[paths objectAtIndex:0]stringByAppendingPathComponent:@"myPlistFile.plist"]]]];
            [DELEGATE.cardCounter setValue:[NSNumber numberWithInt:[[DELEGATE.cardCounter valueForKey:selectedsweepid] integerValue]+1] forKey:selectedsweepid];
            [DELEGATE.cardCounter writeToFile:[[paths objectAtIndex:0]stringByAppendingPathComponent:@"myPlistFile.plist"] atomically:YES];
            NSLog(@"-->%@",DELEGATE.cardCounter);
            DELEGATE.applied = YES;
            costlb.text =[NSString stringWithFormat:@"%@",[results valueForKey:@"entries"]];
            entries = [[NSString alloc]initWithFormat:@"%@",[results valueForKey:@"entries"]];
            successview.hidden = NO;
            [self.view bringSubviewToFront:successview];
            NSDictionary *args = [[NSDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userid,selectedsweepid,[NSString stringWithFormat:@"%@",@"1"],@"Flurry", nil] forKeys:[NSArray arrayWithObjects:@"userid",@"sweepstakeid",@"entry",@"type", nil]]];
            [Apsalar event:@"Enter To Win" withArgs:args];
        
        }
    
}
//****************END OF AD COLONY RELATED METHODS*****************//

- (IBAction)closesucess:(id)sender {
    successview.hidden = YES;
}

- (IBAction)closeGenericConfDialog:(id)sender {
    //This is the action of the done button tap of the generic confirmation dialog
    [vwGenericConfDialog removeFromSuperview];
}

- (IBAction)closeGenericConfDialogFromCross:(id)sender {
    //This is the action of the done button tap of the generic confirmation dialog
    [vwGenericConfDialog removeFromSuperview];
}

@end
