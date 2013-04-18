//
//  AccountLoginVC.m
//  Sweepstakes
//
//  Created by Kuldeep Bhatt on 3/13/13.
//  Copyright (c) 2013 peerbits@gmail.com. All rights reserved.
//

#import "AccountLoginVC.h"
#import "SweepListViewController.h"


@interface AccountLoginVC ()

@end

@implementation AccountLoginVC
@synthesize forgotpasslb,scrollview,passwordtextfield,emailtextfield;
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
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *forgot = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tapforgot)] autorelease];
    [self.forgotpasslb addGestureRecognizer:forgot];
    dc= [[LLDataControll alloc] init];
    mc = [[ModelClass alloc]init];
    [mc setDelegate:self];
    
    // If already Login Than go To Sweep Listing
    if ([dc getData]) {
        
        DELEGATE.nCurrentListItem = CURRENT_LIST_ITEM_SWEEP_STAKES_LIST;
        SweepListViewController *gotosweeplist = [[SweepListViewController alloc]initWithNibName:@"SweepListViewController" bundle:nil];
        gotosweeplist.usrid = [[dc getData]objectAtIndex:0];
        [self.navigationController pushViewController:gotosweeplist animated:YES];
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods
-(void)Tapforgot{
    
    UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:@"Enter Your Email Address" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
    [dialog setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [dialog textFieldAtIndex:0].keyboardType=UIKeyboardTypeEmailAddress;
    
    [dialog show];
    [dialog release];   
    
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
    
    if (emailtextfield.text.length && passwordtextfield.text.length > 0)
    {
        
        if (DELEGATE.isHostAvailable) {
            //Added on 6th Feb, 2013 as DELEGATE.tokenstring was always null
            //LEts get the device id
            // UIDevice *device = [UIDevice currentDevice];
            //  NSString *deviceId = [device uniqueIdentifier];
            //  NSLog(@"%@",DELEGATE.tokenstring);
            [mc signIn:emailtextfield.text password:passwordtextfield.text deviceid:DELEGATE.tokenstring  selector:@selector(emailresponse:)];
            //[mc signIn:emailtextfield.text password:passwordtextfield.text deviceid:DELEGATE.tokenstring selector:@selector(emailresponse:)];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
        }
    }
    else {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Login Details!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
        
    }
}
-(void)emailresponse:(NSDictionary *)results{
    
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
    // NSLog(@"Login response is -> %@", result);
    
    if([result isEqualToString:@"true"]){
        
        // Store User Details and push to Sweep Listing
        NSArray* myArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[[results valueForKey:@"User"]valueForKey:@"userid"]],[NSString stringWithFormat:@"%@",[[results valueForKey:@"User"]valueForKey:@"credits"]],[[results valueForKey:@"User"]valueForKey:@"username"],[[results valueForKey:@"User"]valueForKey:@"ref_id"], nil];
        [dc setData:[NSMutableArray arrayWithArray:myArray]];
        //[dc setData:[NSMutableArray arrayWithArray:myArray]];
        
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
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIAlertView Delegate
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

@end
