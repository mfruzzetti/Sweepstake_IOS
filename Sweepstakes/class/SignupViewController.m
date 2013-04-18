//
//  SignupViewController.m
//  Sweepstakes
//
//  Created by Peerbits Solution on 03/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "SignupViewController.h"
#import "SignMoreViewController.h"


@interface SignupViewController ()

@end

@implementation SignupViewController
@synthesize firstnametickimgview;
@synthesize lastnametickimgview;
@synthesize emailtickimgview;
@synthesize passtickimgview;
@synthesize conpasstickimgview;
@synthesize reffcodetickimgview;
@synthesize firstnametextfield;
@synthesize lastnametextfield;
@synthesize emailtextfield;
@synthesize passwordtextfield;
@synthesize confpasstextfield;
@synthesize reffcodetextfield;
@synthesize scrollview;
@synthesize fbGraph,feedPostId;
bool email = NO;
bool password= NO;
bool confpass = NO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mc = [[ModelClass alloc]init];
    [mc setDelegate:self];
     [btfemale setBackgroundImage:[UIImage imageNamed:@"femaleunselect.png"] forState:UIControlStateNormal];
     [btmale setBackgroundImage:[UIImage imageNamed:@"maleunselect.png"] forState:UIControlStateNormal];
     gender = [[NSString alloc]initWithString:@""];
    
   
    [self.scrollview setContentSize:CGSizeMake(320, 685)];
    
    
}

- (void)viewDidUnload
{
    [self setEmailtextfield:nil];
    [self setPasswordtextfield:nil];
    [self setConfpasstextfield:nil];
    [self setReffcodetextfield:nil];
    [self setEmailtickimgview:nil];
    [self setPasstickimgview:nil];
    [self setConpasstickimgview:nil];
    [self setReffcodetickimgview:nil];
    [self setScrollview:nil];
    [btfemale release];
    btfemale = nil;
    [btmale release];
    btmale = nil;
    [self setFirstnametickimgview:nil];
    [self setLastnametickimgview:nil];
    [self setFirstnametextfield:nil];
    [self setLastnametextfield:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)firstnametypedone:(id)sender {

    if (firstnametextfield.text.length >0) {
        firstnametickimgview.image = [UIImage imageNamed:@"right-sign.png"];
    }
    else {
        firstnametickimgview.image = [UIImage imageNamed:@"Wrong-sign.png"];
        
    }
}

- (IBAction)lastnametypedone:(id)sender {

    if (lastnametextfield.text.length >0) {
        lastnametickimgview.image = [UIImage imageNamed:@"right-sign.png"];
    }
    else {
        lastnametickimgview.image = [UIImage imageNamed:@"Wrong-sign.png"];
        
    }

}


- (IBAction)emailtypestart:(id)sender {
    [self.scrollview setContentOffset:CGPointMake(0, 120) animated:YES];
}

- (IBAction)eamiltypedone:(id)sender {

    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL b = [emailTest evaluateWithObject:emailtextfield.text];
    
    if (b==NO) 
    {
        emailtickimgview.image = [UIImage imageNamed:@"Wrong-sign.png"];
        email = NO;
     
    }
    else {
        emailtickimgview.image = [UIImage imageNamed:@"right-sign.png"];
        email = YES;
    
    }

}
- (IBAction)passtypestart:(id)sender {
    [self.scrollview setContentOffset:CGPointMake(0,170) animated:YES];
}



- (IBAction)passtypedone:(id)sender {

    if (passwordtextfield.text.length>3) {
        passtickimgview.image = [UIImage imageNamed:@"right-sign.png"];
        password = YES;
    }
    else {
        passtickimgview.image = [UIImage imageNamed:@"Wrong-sign.png"]; 
        password = NO;
    }
}
- (IBAction)conpasstypestart:(id)sender {
    
    [self.scrollview setContentOffset:CGPointMake(0,222) animated:YES];
}

- (IBAction)conpasstypedone:(id)sender {

    if (confpasstextfield.text.length>0) 
    {
        if ([passwordtextfield.text isEqualToString: confpasstextfield.text]) 
        { 
        conpasstickimgview.image = [UIImage imageNamed:@"right-sign.png"];
            confpass = YES;
        
        }
        else {
         
        conpasstickimgview.image = [UIImage imageNamed:@"Wrong-sign.png"];
            confpass = NO;
        
    } 
    }else {
        
        conpasstickimgview.image = [UIImage imageNamed:@"Wrong-sign.png"];
        confpass = NO;
    }

}
- (IBAction)reffcodetypestart:(id)sender {
    
    
    [self.scrollview setContentOffset:CGPointMake(0, 250) animated:YES];
    
}
- (IBAction)reffcodetypedone:(id)sender {
    
    [self.scrollview setContentOffset:CGPointMake(0, 170) animated:YES];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == firstnametextfield) 
    {
        [lastnametextfield becomeFirstResponder];
    }
    else if(textField == lastnametextfield) 
    {
        [emailtextfield becomeFirstResponder];
    }else if(textField == emailtextfield) 
    {
        [passwordtextfield becomeFirstResponder];
    }else if(textField == passwordtextfield){
        [confpasstextfield becomeFirstResponder];
    }else if(textField == confpasstextfield){
        [self.scrollview setContentOffset:CGPointMake(0,0) animated:YES];
    }
    
    [textField resignFirstResponder];
    return YES;
    
}


- (IBAction)facebookregester:(id)sender {
   
    
    NSString *client_id = [[NSString alloc]initWithFormat:@"%@",Facebook_id];
    
	//alloc and initalize our FbGraph instance
	self.fbGraph = [[FbGraph alloc] initWithFbClientID:client_id];
	 [fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:) andExtendedPermissions:@"user_about_me,email,publish_stream"];
	//begin the authentication process.....
    	
   //email,user_about_me,user_interests,user_location,publish_stream,read_stream,offline_access,publish_checkins - login permissions

}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
                
                [mc signUpEmail:fb_email password:@"" firstname:fb_firstname lastname:fb_lastname gender:fb_gender refcode:@"" fbuserid:fb_uid photo:fb_proimageurl devietype:@"I" devicetoken:DELEGATE.tokenstring dob:@"" selector:@selector(signupresponse:)];
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
/*
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqual:@"OK"])
	{
        ViewController *gotorootview = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
        [self.navigationController pushViewController:gotorootview animated:YES];
        [gotorootview release];
        
	}
}*/    


- (void)dealloc {
    [emailtextfield release];
    [passwordtextfield release];
    [confpasstextfield release];
    [reffcodetextfield release];
    [emailtickimgview release];
    [passtickimgview release];
    [conpasstickimgview release];
    [reffcodetickimgview release];
    [scrollview release];
    [btfemale release];
    [btmale release];
    [firstnametickimgview release];
    [lastnametickimgview release];
    [firstnametextfield release];
    [lastnametextfield release];
    [super dealloc];
}
- (IBAction)femalebtn:(id)sender {
    
    [btfemale setBackgroundImage:[UIImage imageNamed:@"femaleselect.png"] forState:UIControlStateNormal];
     [btmale setBackgroundImage:[UIImage imageNamed:@"maleunselect.png"] forState:UIControlStateNormal];
    btfemale.userInteractionEnabled = NO;
    btmale.userInteractionEnabled = YES;
    gender = [[NSString alloc]initWithString:@"F"];
    
}

- (IBAction)malebtn:(id)sender {
    
    [btfemale setBackgroundImage:[UIImage imageNamed:@"femaleunselect.png"] forState:UIControlStateNormal];
    [btmale setBackgroundImage:[UIImage imageNamed:@"maleselect.png"] forState:UIControlStateNormal];
    btmale.userInteractionEnabled = NO;
    btfemale.userInteractionEnabled = YES;
    gender = [[NSString alloc]initWithString:@"M"];

}

- (IBAction)createaccountbtn:(id)sender {
    if (email == YES && password ==YES && confpass == YES && firstnametextfield.text.length !=0 && lastnametextfield.text.length!=0 ) {
        if (DELEGATE.isHostAvailable) {
            
             /*[mc signUpEmail:emailtextfield.text password:passwordtextfield.text firstname:firstnametextfield.text lastname:lastnametextfield.text gender:gender refcode:reffcodetextfield.text fbuserid:@"" photo:@"" devietype:@"I" devicetoken:DELEGATE.tokenstring selector:@selector(signupresponse:)];*/
            SignMoreViewController *moresignUpOptions = [[SignMoreViewController alloc]initWithNibName:@"SignMoreViewController" bundle:nil];
            moresignUpOptions.firstNameStr = [firstnametextfield text];
            moresignUpOptions.lastNameStr = [lastnametextfield text];
            moresignUpOptions.passwordStr = [passwordtextfield text];
            [moresignUpOptions setEmailStr:[emailtextfield text]];
            [self.navigationController pushViewController:moresignUpOptions animated:YES];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
        }
      
    }else {
     
        if (firstnametextfield.text.length == 0) {
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Your First Name!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [al show];
            [al release];
        }else if (lastnametextfield.text.length == 0)
        {
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Your Last Name!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [al show];
            [al release];
        
        }else if (email == NO){
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Valid Email Address!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [al show];
            [al release];
        
        }else if (passwordtextfield.text.length < 4 || confpasstextfield.text.length < 4  ){
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"Plese enter minimum 4 digit Password!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [al show];
            [al release];
        
        }else if (password == NO || confpass == NO){
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"Plese enter Valid Password and Confirm Password!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [al show];
            [al release];
            
        }
        else if (gender.length == 0){
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"Plese select your gender!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [al show];
            [al release];
            
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
@end
