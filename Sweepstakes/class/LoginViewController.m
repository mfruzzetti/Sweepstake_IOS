//
//  LoginViewController.m
//  Sweepstakes
//
//  Created by Peerbits Solution on 03/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "LoginViewController.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#define MY_BUZZCITY_APPLICATION_ID "fkylkq9958b4hocrok61j8hqf"
#import <CommonCrypto/CommonDigest.h>
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize scrollview;
@synthesize forgotpasslb;
@synthesize emailtextfield;
@synthesize passwordtextfield;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *)ODIN1 {
    // Step 1: Get MAC address
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        return nil;
    }
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        return nil;
    }
    if ((buf = malloc(len)) == NULL) {
        return nil;
    }
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        return nil;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    
    // Step 2: Take the SHA-1 of the MAC address
    CFDataRef data = CFDataCreate(NULL, (uint8_t*)ptr, 6);
    unsigned char messageDigest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(CFDataGetBytePtr((CFDataRef)data), CFDataGetLength((CFDataRef)data), messageDigest);
    CFMutableStringRef string = CFStringCreateMutable(NULL, 40);
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        CFStringAppendFormat(string, NULL, (CFStringRef)@"%02X", messageDigest[i]);
    }
    CFStringLowercase(string, CFLocaleGetSystem());
    free(buf);
    NSString *odinstring = [[NSString alloc] initWithString:( NSString*)string];
    CFRelease(data);
    CFRelease(string);
    return odinstring;
}

-(void) webViewDidFinishLoad:(UIWebView *)webView
{
    
    NSLog(@"webViewDidFinishLoad");
    [webView removeFromSuperview];
    //Has fully loaded, do whatever you want here
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //------------------ Buzz City--APP TRACKING CODE----------------------
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL appTrackingStatus = [defaults boolForKey:@"BuzzCity_AppTracking_Prefs_key"];
    
    
    if (!appTrackingStatus) {
        //Compute UDID
        NSString *udid = [self ODIN1];
        NSLog(@"udid-->%@",udid);
        //Update apptracking status
        [defaults setBool:YES forKey:@"BuzzCity_AppTracking_Prefs_key"];
        [defaults synchronize];
        
        //Launch Browser
        NSString *url = [NSString stringWithFormat:@"http://ads.buzzcity.net/apptracking.php?appid=%s&udid=%@", MY_BUZZCITY_APPLICATION_ID, udid];
        
        if (DELEGATE.isHostAvailable)
        {
            UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320,480)];
            [webview setAlpha:0];
            [webview setDelegate:self];
            NSURL *nsurl=[NSURL URLWithString:url];
            NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
            [webview loadRequest:nsrequest];
            [self.view addSubview:webview];
        }
       // NSLog(@"url-->%@",url);
        //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
    //----------------Buzz City--END OF APP TRACKING CODE-------------------- }
    
    
    
    
    mc = [[ModelClass alloc]init];
    [mc setDelegate:self];
    UITapGestureRecognizer *forgot = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tapforgot)] autorelease];
    [forgotpasslb addGestureRecognizer:forgot];
    dc= [[LLDataControll alloc] init];
    
    // If already Login Than go To Sweep Listing
    if ([dc getData]) {
       
                DELEGATE.nCurrentListItem = CURRENT_LIST_ITEM_SWEEP_STAKES_LIST;
        SweepListViewController *gotosweeplist = [[SweepListViewController alloc]initWithNibName:@"SweepListViewController" bundle:nil];
        gotosweeplist.usrid = [[dc getData]objectAtIndex:0];
        [self.navigationController pushViewController:gotosweeplist animated:YES];
        
    }

    
    // Do any additional setup after loading the view from its nib.
}

-(void)Tapforgot{

    UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:@"Enter Your Email Address" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil]; 
    [dialog setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [dialog textFieldAtIndex:0].keyboardType=UIKeyboardTypeEmailAddress;
    
    [dialog show];
    [dialog release];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
   
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL b = [emailTest evaluateWithObject:[[alertView textFieldAtIndex:0]text]];
    
    if (b==NO) {
        
        UIAlertView  *messageBox = [[UIAlertView alloc]initWithTitle:@""message:@"Invalid Email Address" delegate:nil cancelButtonTitle:@"Ok"otherButtonTitles:nil];
        [messageBox show];
        [messageBox release];
       
    }
    else {
        [mc forgetpass:[[alertView textFieldAtIndex:0]text] selector:@selector(forgetpassresponse:)];
    
    }
        
    }
}
-(void)forgetpassresponse:(NSDictionary *)results{
    
    
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
   
    
    if([result isEqualToString:@"true"]){
        
        UIAlertView  *messageBox = [[UIAlertView alloc]initWithTitle:@""message:@"Your password is mailed to you." delegate:nil cancelButtonTitle:@"Ok"otherButtonTitles:nil];
        [messageBox show];
        [messageBox release];

    }
    else {
        UIAlertView  *messageBox = [[UIAlertView alloc]initWithTitle:@""message:@"Invalid Email Address" delegate:nil cancelButtonTitle:@"Ok"otherButtonTitles:nil];
        [messageBox show];
        [messageBox release];
    }
}
- (void)viewDidUnload
{
    [self setEmailtextfield:nil];
    [self setPasswordtextfield:nil];
    [self setScrollview:nil];
    [self setForgotpasslb:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
	if(textField == emailtextfield) 
    {
        [passwordtextfield becomeFirstResponder];
    }
    [textField resignFirstResponder];
    return YES;
    
}
- (IBAction)emailtypestart:(id)sender {
    [self.scrollview setContentSize:CGSizeMake(320, 300)];

    [self.scrollview setContentOffset:CGPointMake(0, 85) animated:YES]; 
}
- (IBAction)emailtypedone:(id)sender {
  //  [self.scrollview setContentSize:CGSizeMake(320, 440)];

}
- (IBAction)passwordtypestart:(id)sender {
   [self.scrollview setContentSize:CGSizeMake(320, 300)];
    
    [self.scrollview setContentOffset:CGPointMake(0, 85) animated:YES]; 
}
- (IBAction)passwordtypedone:(id)sender {
    [self.scrollview setContentSize:CGSizeMake(320, 405)];

}



- (void)dealloc {
    [emailtextfield release];
    [passwordtextfield release];
    [scrollview release];
    [forgotpasslb release];
    [super dealloc];
}
- (IBAction)login:(id)sender {
    
    [self startLoginProcess];
}
-(void)emailresponse:(NSDictionary *)results{
  
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
   // NSLog(@"Login response is -> %@", result);
    
    if([result isEqualToString:@"true"]){
        
        // Store User Details and push to Sweep Listing
        NSArray* myArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[[results valueForKey:@"User"]valueForKey:@"userid"]],[NSString stringWithFormat:@"%@",[[results valueForKey:@"User"]valueForKey:@"credits"]],[[results valueForKey:@"User"]valueForKey:@"username"],[[results valueForKey:@"User"]valueForKey:@"ref_id"], nil];
        [dc setData:[NSMutableArray arrayWithArray:myArray]];
      
                DELEGATE.nCurrentListItem = CURRENT_LIST_ITEM_SWEEP_STAKES_LIST;
        SweepListViewController *gotosweeplist = [[SweepListViewController alloc]initWithNibName:@"SweepListViewController" bundle:nil];
        gotosweeplist.usrid = [[dc getData]objectAtIndex:0];
        [self.navigationController pushViewController:gotosweeplist animated:YES];
        
    }else {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:[results valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
    }

}
   /*
        sqlite3_stmt *stmt;
        int x;
        char *update = "insert into login_master values(?,?,?,?);";
        x = sqlite3_prepare_v2(database, update, -1, &stmt, nil);
      
        
        if (x == SQLITE_OK) 
        { 
     
        sqlite3_bind_text(stmt, 1,[[NSString stringWithFormat:@"%@",[[results valueForKey:@"User"]valueForKey:@"userid"]] UTF8String] ,-1, NULL);

        sqlite3_bind_text(stmt, 2, [[NSString stringWithFormat:@"%@",[[results valueForKey:@"User"]valueForKey:@"credits"]] UTF8String],-1, NULL);
        sqlite3_bind_text(stmt, 3, [[[results valueForKey:@"User"]valueForKey:@"username"] UTF8String],-1, NULL);
        sqlite3_bind_text(stmt, 4, [[[results valueForKey:@"User"]valueForKey:@"ref_id"] UTF8String],-1, NULL);
    
            
        }		
        if (sqlite3_step(stmt) != SQLITE_DONE){
             sqlite3_finalize(stmt);
        }
        else {
            sqlite3_finalize(stmt);
            ViewController *gotorootview = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
            [gotorootview.view makeToast:@"Successfully Login." duration:1.0 position:@"bottom"];
            [self.navigationController pushViewController:gotorootview animated:YES];
        }
       

    }
    else {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:[results valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
    }
}
*/


        
	   


- (IBAction)signup:(id)sender {
    SignupViewController *gotosignup = [[SignupViewController alloc]initWithNibName:@"SignupViewController" bundle:nil];
    [self.navigationController pushViewController:gotosignup animated:YES];
    
}
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UI Enhancements Methods - KB 13 March-13
-(void)connectWithFacebook
{
    NSString *client_id = [[NSString alloc]initWithFormat:@"%@",Facebook_id];
    
	//alloc and initalize our FbGraph instance
	fbGraph = [[FbGraph alloc] initWithFbClientID:client_id];
    [fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:) andExtendedPermissions:@"email,user_about_me,user_interests,user_location,publish_stream,read_stream,offline_access,publish_checkins"];
	//begin the authentication process.....
    
    //email,user_about_me,user_interests,user_location,publish_stream,read_stream,offline_access,publish_checkins - login permissions
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
		
		NSLog(@"------------>CONGRATULATIONS<------------, You're logged into Facebook...  Your oAuth token is:  %@", fbGraph.accessToken);
        FbGraphResponse *fb_graph_response = [fbGraph doGraphGet:@"me" withGetVars:nil];
        
        
        parser = [[SBJsonParser alloc]init];
        NSDictionary *results = [parser objectWithString:[NSString stringWithFormat:@"%@",fb_graph_response.htmlResponse] error:nil];
        
        fb_firstname = [results valueForKey:@"first_name"];
        fb_email = [results valueForKey:@"email"];
        fb_lastname = [results valueForKey:@"last_name"];
        fb_uid = [results valueForKey:@"id"];
        fb_gender = [results valueForKey:@"gender"];
        fb_proimageurl = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large",fb_uid];
        
        
        // record the event with Apsalar
        NSDictionary *args = [[NSDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@ %@",fb_firstname,fb_lastname],fb_email,fb_uid,fb_gender,fb_proimageurl, nil] forKeys:[NSArray arrayWithObjects:@"name",@"email address",@"facebok id",@"gender",@"imageurl", nil]]];
        [Apsalar event:@"Register With Facebook" withArgs:args];
        // record the event with Google Analytics
        
        if ([fb_gender isEqualToString:@"male"]) {
            fb_gender =@"M";
        }
        else {
            fb_gender = @"F";
        }
        if (fb_uid.length >0)
        {
            if (DELEGATE.isHostAvailable) {
                
                [mc signUpEmail:fb_email password:@"" firstname:fb_firstname lastname:fb_lastname gender:fb_gender refcode:@"" fbuserid:fb_uid photo:fb_proimageurl devietype:@"I" devicetoken:DELEGATE.tokenstring selector:@selector(signupresponse:)];
            }else
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
        
    }
    
	
}


-(void)signupresponse:(NSDictionary *)results{
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
    dc = [[LLDataControll alloc]init];
    if([result isEqualToString:@"true"])
    {
        // Store User Details
        NSArray* myArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[[results valueForKey:@"User"]valueForKey:@"userid"]],[NSString stringWithFormat:@"%@",[[results valueForKey:@"User"]valueForKey:@"credits"]],[[results valueForKey:@"User"]valueForKey:@"username"],[[results valueForKey:@"User"]valueForKey:@"ref_id"], nil];
        NSLog(@"%@",myArray);
        [dc setData:[NSMutableArray arrayWithArray:myArray]];
                DELEGATE.nCurrentListItem = CURRENT_LIST_ITEM_SWEEP_STAKES_LIST;
        SweepListViewController *gotosweeplist = [[SweepListViewController alloc]initWithNibName:@"SweepListViewController" bundle:nil];
        gotosweeplist.usrid = [[dc getData]objectAtIndex:0];
        
        [self.navigationController pushViewController:gotosweeplist animated:YES];
    }else {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:[results valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
    }
    
    
    //        sqlite3_stmt *stmt;
    //        int x;
    //        char *update = "insert into login_master values(?,?,?,?);";
    //        x = sqlite3_prepare_v2(database, update, -1, &stmt, nil);
    //
    //        if (x == SQLITE_OK)
    //        {
    //            sqlite3_bind_text(stmt, 1,[[NSString stringWithFormat:@"%@",[[results valueForKey:@"User"]valueForKey:@"userid"]] UTF8String] ,-1, NULL);
    //            sqlite3_bind_text(stmt, 2, [[NSString stringWithFormat:@"%@",[[results valueForKey:@"User"]valueForKey:@"credits"]] UTF8String],-1, NULL);
    //            sqlite3_bind_text(stmt, 3, [[[results valueForKey:@"User"]valueForKey:@"username"] UTF8String],-1, NULL);
    //            sqlite3_bind_text(stmt, 4, [[[results valueForKey:@"User"]valueForKey:@"ref_id"] UTF8String],-1, NULL);
    //        }
    //        if (sqlite3_step(stmt) != SQLITE_DONE){
    //            sqlite3_finalize(stmt);
    //        }
    //        else {
    //            sqlite3_finalize(stmt);
    //            ViewController *gotorootview = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    //             [gotorootview.view makeToast:@"Successfully Login." duration:1.0 position:@"bottom"];
    //            [self.navigationController pushViewController:gotorootview animated:YES];
    //        }
    //
    //
    //    }
    //    else {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[results valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //
    //    }
}

-(void)startLoginProcess
{
    AccountLoginVC *goToLogin = [[[AccountLoginVC alloc]initWithNibName:@"AccountLoginVC" bundle:nil] autorelease];
    [self.navigationController pushViewController:goToLogin animated:YES];
}
//Added by KB 13 March-13
-(IBAction)buttonDidClicked:(id)sender
{
    UIButton *clickedBtn = (UIButton*)sender;
    switch (clickedBtn.tag) {
        case 1://Connect to FB
            [self connectWithFacebook];
            break;
            
        case 2://Sign up
        {
            SignupViewController *gotosignup = [[SignupViewController alloc]initWithNibName:@"SignupViewController" bundle:nil];
            [self.navigationController pushViewController:gotosignup animated:YES];
        }
            break;
            
        case 3://Sign in
            [self startLoginProcess];
            break;
            
        default:
            break;
    }
}
@end
