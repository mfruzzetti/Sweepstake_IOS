//
//  ViewController.m
//  Sweepstakes
//
//  Created by Peerbits Solution on 03/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import "Flurry.h"
#import "FlurryAds.h"
#define IS_IPHONE_5 ( [ [ UIScreen mainScreen ] bounds ].size.height == 568 )
@interface ViewController ()

@end

@implementation ViewController
@synthesize TearmImageView;
@synthesize detaillb;
@synthesize creditlable;
@synthesize sweepstakesimgview;
@synthesize earncreditimgview;
@synthesize winnerslistimgview;
@synthesize myprofileimgview;
@synthesize view2;
@synthesize TearmsConditions;
float x;

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    //[AdColony initAdColonyWithDelegate:self];
    drk = [[DarckWaitView alloc] initWithDelegate:nil andInterval:0.1 andMathod:nil];
    dc= [[LLDataControll alloc] init];
    view2.hidden = YES;
    
    if (![dc  getDataFromFile:@"isAccepted"]) {
        
        [Acceptbtn setEnabled:NO];
        [Acceptbtn setAlpha:0.5f];
        [self.view addSubview:TearmsConditions];
        tickmark.tag = 0;
        TearmImageView.layer.cornerRadius = 10.5f;
        TearmImageView.clipsToBounds = YES;
    }
    
    detaillb.font = [UIFont fontWithName:@"Calibri-Italic" size:15];
    creditlable.font = [UIFont fontWithName:@"Calibri-BoldItalic" size:18];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(someMethod:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *Tapsweepstake = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tapsweepstack)] autorelease];
    [sweepstakesimgview addGestureRecognizer:Tapsweepstake];
    
    UITapGestureRecognizer *Tapmyprofile = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Taptomyprofile)] autorelease];
    
    [myprofileimgview addGestureRecognizer:Tapmyprofile];
    
    UITapGestureRecognizer *Tapwinnerlist = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Taptowinnerlist)] autorelease];
    
    [winnerslistimgview addGestureRecognizer:Tapwinnerlist];
    
    UITapGestureRecognizer *Tapsearncredit = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tapearncredit)] autorelease];
    [earncreditimgview addGestureRecognizer:Tapsearncredit];
    

    
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results=[db executeQuery:@"SELECT * FROM login_master where rowid=1"];
    while ([results next]) 
    {
        userid = [[NSString alloc]initWithString:[results stringForColumn:@"userid"]];
          }
    [results close];
    [db close];
    
    if ([userid intValue] >0)
    {
        [FlurryAds setAdDelegate:self];
        NSDictionary *cookies =[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithString:userid], // Parameter Value
                                @"userid", nil];
        [FlurryAds setUserCookies:cookies];
        [Flurry setUserID:userid];

        
        mc = [[ModelClass alloc]init];
        [mc setDelegate:self];
        
        if (DELEGATE.isHostAvailable) 
        {
            
            [mc getpoint:userid selector:@selector(getpointresponse:)];
        }
        else 
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
        }
    }
    
    else {
        creditlable.text = @"0";
    }
   

    
}

-(void)viewWillAppear:(BOOL)animated{
    
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open]; 
    FMResultSet *results=[db executeQuery:@"SELECT * FROM login_master where rowid=1"];
    while ([results next]) 
    {
        
    creditlable.text = [NSString stringWithFormat:@"%@",[results stringForColumn:@"credits"]];
        
    }
    CGSize textSize = [creditlable.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
    x= textSize.width;
    if (plus) {
        CGRect frame = CGRectMake(268-x,5,10,20);
        plus.frame = frame;
    }else {
        plus = [[UILabel alloc]initWithFrame:CGRectMake(268-x,4,10,20)];
        [plus setTextColor:[UIColor colorWithRed:28.0/255.0 green:107.0/255.0 blue:130.0/255.0 alpha:1.0]];
        [plus setBackgroundColor:[UIColor clearColor]];
        plus.textAlignment = UITextAlignmentRight;
        plus.font=[UIFont fontWithName:@"Calibri-BoldItalic" size:12];
        plus.text = @"+";
        [self.view addSubview:plus];
        [plus release];

        
    }if (credit) {
        CGRect frame1 = CGRectMake(277,13,40,20);
        credit.frame = frame1; 
    }else {
        credit = [[UILabel alloc]initWithFrame:CGRectMake(277,13,40,20)];
        [credit setTextColor:[UIColor colorWithRed:28.0/255.0 green:107.0/255.0 blue:130.0/255.0 alpha:1.0]];
        [credit setBackgroundColor:[UIColor clearColor]];
        credit.textAlignment = UITextAlignmentLeft;
        credit.font=[UIFont fontWithName:@"Calibri-BoldItalic" size:11];
        credit.text = @"Tickets";
        [self.view addSubview:credit];
        [credit release];
        
    }
}


-(void)getpointresponse:(NSDictionary *)results{
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
 
    if([result isEqualToString:@"true"]){
        
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open]; 
       
        BOOL success = [db executeUpdateWithFormat:@"UPDATE login_master SET credits=%@ where userid=%d",[results valueForKey:@"credits"],[userid intValue]];
        
        if (!success)
        {
            NSLog(@"update failed login table!!");
        }
        else 
        {
            
            NSLog(@"successfully updated login table");
            creditlable.text = [NSString stringWithFormat:@"%@",[results valueForKey:@"credits"]];
           
        }
                   
    }else if([[results valueForKey:@"message"]isEqualToString:@"User Does Not Exists"]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:[results valueForKey:@"message"] message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
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
        creditlable.text = @"0";
       
    }
    CGSize textSize = [creditlable.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
    x= textSize.width;
    CGRect frame = CGRectMake(268-x,5,10,20);
    plus.frame = frame;
    CGRect frame1 = CGRectMake(277,13,40,20);
    credit.frame = frame1;
    }

-(void)Tapsweepstack{
    if ([userid intValue] >0) {
     
    SweepListViewController *gotosweeplist = [[SweepListViewController alloc]initWithNibName:@"SweepListViewController" bundle:nil];
        gotosweeplist.usrid = userid;
        [self.navigationController pushViewController:gotosweeplist animated:YES];
        
    }else {
        
    LoginViewController *gotologin = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:gotologin animated:YES];
    }

}
-(void)Taptomyprofile{
    
    if ([userid intValue]>0) 
    {
        
        MyprofileViewController *gotoprofile = [[MyprofileViewController alloc]initWithNibName:@"MyprofileViewController" bundle:nil];
        gotoprofile.userid = userid;
        [self.navigationController pushViewController:gotoprofile animated:YES];
        
    }else {
        
        LoginViewController *gotologin = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:gotologin animated:YES];
    
    }

}
-(void)Tapearncredit{
    if ([userid intValue]>0) 
    {
        view2.hidden = NO;
              
    }else {
        
        LoginViewController *gotologin = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:gotologin animated:YES];
        
    }
}

-(void)Taptowinnerlist{

    if ([userid intValue] >0) 
    {
       
        WinnerlistViewController *gotowinner = [[WinnerlistViewController alloc]initWithNibName:@"WinnerlistViewController" bundle:nil];
        gotowinner.userid = userid;
        [self.navigationController pushViewController:gotowinner animated:YES];
        
    }else {
        
        LoginViewController *gotologin = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:gotologin animated:YES];
        
    }

}



-(void)spaceDidDismiss:(NSString *)adSpace interstitial:(BOOL)interstitial{
 NSLog(@"-->spaceDidDismiss");
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] performSelector:NSSelectorFromString(@"setOrientation:") withObject:(id)UIInterfaceOrientationPortrait];
     [mc getpoint:userid selector:@selector(getpointresponse:)];
    

}
-(void)spaceDidReceiveAd:(NSString *)adSpace{
    
    [drk hide];

}
- (void) spaceDidFailToReceiveAd:(NSString*)adSpace error:(NSError *)error{

    [drk hide];
    [self.view makeToast:@"No ads found." duration:0.7 position:@"bottom"];

}

- (void)viewDidUnload
{
    [self setDetaillb:nil];
    [self setSweepstakesimgview:nil];
    [self setEarncreditimgview:nil];
    [self setWinnerslistimgview:nil];
    [self setMyprofileimgview:nil];
    [self setCreditlable:nil];
    [self setView2:nil];
  //  [FlurryAds removeAdFromSpace:@"Sweepstakes iOS - Offerwall"];
 //   [FlurryAds setAdDelegate:nil];
   
    [self setTearmsConditions:nil];
    [Acceptbtn release];
    Acceptbtn = nil;
    [tickmark release];
    tickmark = nil;
    [self setTearmImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);

}
- (void)dealloc {
    [detaillb release];
    [sweepstakesimgview release];
    [earncreditimgview release];
    [winnerslistimgview release];
    [myprofileimgview release];
    [creditlable release];
    [view2 release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [TearmsConditions release];
    [Acceptbtn release];
    [tickmark release];
    [TearmImageView release];
    [super dealloc];
}
- (IBAction)gotick:(id)sender {
    if (tickmark.tag == 0) {
        tickmark.tag = 1;
        [tickmark setImage:[UIImage imageNamed:@"checkButtonPressed.png"] forState:UIControlStateNormal];
        Acceptbtn.enabled = YES;
        [Acceptbtn setAlpha:1.0f];
    }else {
        tickmark.tag = 0;
        [tickmark setImage:[UIImage imageNamed:@"checkButtonUnpressed.png"] forState:UIControlStateNormal];
        Acceptbtn.enabled = NO;
        [Acceptbtn setAlpha:0.5f];

    }
}

- (IBAction)Accept:(id)sender {
    [dc saveData:@"isAccepted" toFile:@"isAccepted"];
    [TearmsConditions removeFromSuperview];
}

- (IBAction)closebtn:(id)sender {
    view2.hidden = YES;
    
}
- (IBAction)appsfortickete:(id)sender {
    
    [drk showWithMessage:nil];
    [FlurryAds fetchAndDisplayAdForSpace:@"Sweepstakes iOS - Offerwall" view:self.view size:FULLSCREEN];
    
}

- (IBAction)videoforticketes:(id)sender {
  
    
 //[AdColony playVideoAdForZone:@"vzcddb829ff2aa4665abaf93" withDelegate:self withV4VCPrePopup:YES andV4VCPostPopup:YES];


  
}

/*
- (void) adColonyTakeoverEndedForZone:(NSString *)zone
                               withVC:(BOOL)withVirtualCurrencyAward {
    NSLog(@"AdColony video ad finished for zone %@", zone);
   
   
}


- (void) adColonyVideoAdNotServedForZone:(NSString *)zone {
    NSLog(@"AdColony did not serve a video for zone %@", zone);
    [self.view makeToast:@"AdColony didn't serve a video for your zone" duration:1.0 position:@"bottom"];
   
}
-(void)adColonyVideoAdsNotReadyInZone:(NSString *)zone{
    NSLog(@"AdColony: videos temporarily unavailable in zone: %@", zone);
    [self.view makeToast:@"AdColony videos temporarily unavailable in your zone" duration:1.0 position:@"bottom"];
}
-(NSString*)adColonyApplicationID{
    
 return @"app835402282cbd495485145d";
 
   
}

-(NSDictionary*)adColonyAdZoneNumberAssociation{
return [NSDictionary dictionaryWithObjectsAndKeys:@"vzcddb829ff2aa4665abaf93",[NSNumber numberWithInt:1],nil];
    
}

-(void)adColonyVirtualCurrencyAwardedByZone:(NSString *)zone currencyName:(NSString *)name
                             currencyAmount:(int)amount {
    
    
    NSLog(@"zone-->%@",zone);
    NSLog(@"name-->%@",name);
    NSLog(@"amount-->%d",amount);
    
    if (DELEGATE.isHostAvailable)
    {
        NSLog(@"Credited");
        [mc increaseadcolonyticket:[NSString stringWithFormat:@"%d",amount] userid:userid selector:@selector(getadpointresponse:)];

    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    //Update virtual currency balance by contacting the game server here
    //NOTE: The currency award transaction will be complete at this point
    //NOTE: This callback can be executed by AdColony at any time
    //NOTE: This is the ideal place for an alert about the successful reward
}
-(void)adColonyVirtualCurrencyNotAwardedByZone:(NSString *)zone
                                  currencyName:(NSString *)name currencyAmount:(int)amount reason:(NSString *)reason{
    //Update the user interface after calling virtualCurrencyAwardAvailable here
    
    NSLog(@"zone-->%@",zone);
    NSLog(@"name-->%@",name);
    NSLog(@"amount-->%d",amount);
    NSLog(@"reason-->%@",reason);
    
}*/


- (void)someMethod:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  
    if ([userid intValue]>0) 
    {
        
        if (DELEGATE.isHostAvailable) 
        {
            
            [mc getpoint:userid selector:@selector(getpointresponse:)];
        }
        else 
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
        }

    }
}
-(void)getadpointresponse:(NSDictionary *)results{
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
    
    if([result isEqualToString:@"true"]){
        
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open];
        
        BOOL success = [db executeUpdateWithFormat:@"UPDATE login_master SET credits=%@ where userid=%d",[results valueForKey:@"credits"],[userid intValue]];
        
        if (!success)
        {
            NSLog(@"update failed login table!!");
        }
        else
        {
            
            NSLog(@"successfully updated login table");
            creditlable.text = [NSString stringWithFormat:@"%@",[results valueForKey:@"credits"]];
            
        }
        
    }else if([[results valueForKey:@"message"]isEqualToString:@"User Does Not Exists"]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:[results valueForKey:@"message"] message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
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
        creditlable.text = @"0";
        
    }
    CGSize textSize = [creditlable.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
    x= textSize.width;
    CGRect frame = CGRectMake(268-x,5,10,20);
    plus.frame = frame;
    CGRect frame1 = CGRectMake(277,13,40,20);
    credit.frame = frame1;
    
    ViewController *goview = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    [self.navigationController pushViewController:goview animated:NO];
     
     
}


/*
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
    if ([[alertView title] isEqualToString:@"User Does Not Exists"])
	{
      //  LoginViewController *gotologin = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
       //  [self.navigationController pushViewController:gotologin animated:YES];      
	}
}    
*/
@end
