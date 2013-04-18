//
//  SignMoreViewController.m
//  Sweepstakes
//
//  Created by Kuldeep Bhatt on 3/13/13.
//  Copyright (c) 2013 peerbits@gmail.com. All rights reserved.
//

#import "SignMoreViewController.h"

@interface SignMoreViewController ()

@end

@implementation SignMoreViewController
@synthesize firstNameStr, lastNameStr, emailStr, passwordStr, dobStr;
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
    
    dateOfBirth.enabled = NO;

    mc = [[ModelClass alloc]init];
    [mc setDelegate:self];

    // Do any additional setup after loading the view from its nib.
    
    //[btfemale setBackgroundImage:[UIImage imageNamed:@"femaleunselect.png"] forState:UIControlStateNormal];
    //[btmale setBackgroundImage:[UIImage imageNamed:@"maleunselect.png"] forState:UIControlStateNormal];
    gender = [[NSString alloc]initWithString:@""];
    [centreDotImgv setImage:[UIImage imageNamed:@"dot.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - sign up methods - KB
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)femalebtn:(id)sender {
    
//    [btfemale setBackgroundImage:[UIImage imageNamed:@"femaleselect.png"] forState:UIControlStateNormal];
//    [btmale setBackgroundImage:[UIImage imageNamed:@"maleunselect.png"] forState:UIControlStateNormal];
    [selectionDotImgvF setImage:[UIImage imageNamed:@"dot.png"]];
    [selectionDotImgvM setImage:[UIImage imageNamed:@""]];
    [centreDotImgv setImage:[UIImage imageNamed:@""]];
    btfemale.userInteractionEnabled = NO;
    btmale.userInteractionEnabled = YES;
    gender = [[NSString alloc]initWithString:@"F"];
    
}

- (IBAction)malebtn:(id)sender {
    
//    [btfemale setBackgroundImage:[UIImage imageNamed:@"femaleunselect.png"] forState:UIControlStateNormal];
//    [btmale setBackgroundImage:[UIImage imageNamed:@"maleselect.png"] forState:UIControlStateNormal];
    btmale.userInteractionEnabled = NO;
    btfemale.userInteractionEnabled = YES;
    [selectionDotImgvM setImage:[UIImage imageNamed:@"dot.png"]];
    [selectionDotImgvF setImage:[UIImage imageNamed:@""]];
    [centreDotImgv setImage:[UIImage imageNamed:@""]];
    gender = [[NSString alloc]initWithString:@"M"];
    
}
- (IBAction)createaccountbtn:(id)sender {
    if(([dateOfBirth.text length] > 0 && actionSheetView.bBirthDatePickerValueChanged) && gender.length != 0)
    {
        if (DELEGATE.isHostAvailable) {
            //Get the dob in mysql format
            self.dobStr = [self returnDateInMySQLFormat:dateOfBirth.text];
            [mc signUpEmail:self.emailStr password:self.passwordStr firstname:self.firstNameStr lastname:self.lastNameStr gender:gender refcode:referralCodeField.text fbuserid:@"" photo:@"" devietype:@"I" devicetoken:DELEGATE.tokenstring dob:self.dobStr selector:@selector(signupresponse_more:)];
        }else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
        }

    }
    else
    {
        if (dateOfBirth.text.length == 0) {
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select date of birth" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [al show];
            [al release];
        }
        else if(!actionSheetView.bBirthDatePickerValueChanged){
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"Current date cannot be date of birth" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [al show];
            [al release];
        }
        else if(gender.length == 0){
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"Plese select your gender!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [al show];
            [al release];

        }
    }
}

- (NSString *)returnDateInMySQLFormat: (NSString *) dobStrAsPasses {
    NSString *finalResult = NULL;
    //The incoming string is in the format mm/dd/yyyy
    //The outpt string is required to be in yyyy/mm/dd
    NSArray *strDateParts = [dobStrAsPasses componentsSeparatedByString:@"/"];
    //Compose the final return string
    finalResult = [NSString stringWithFormat:@"%@-%@-%@", [strDateParts objectAtIndex:2], [strDateParts objectAtIndex:0], [strDateParts objectAtIndex:1]];
    return finalResult;
}

- (IBAction)dateOfBirthClicked:(id)sender {
    actionSheetView = [[ActionSheetDatePicker alloc] initWithTarget:self withSelector:@selector(timeSelectedInPicker:) withsetTime:nil];
	[actionSheetView ShowActionPickerInView:self];
}
- (IBAction)referralCodeEntered:(id)sender {
    
    if (referralCodeField.text.length >0) {
        referralCodeImgv.image = [UIImage imageNamed:@"right-sign.png"];
    }
    else {
        referralCodeImgv.image = [UIImage imageNamed:@"Wrong-sign.png"];
        
    }
    
}
- (IBAction)referralCodeEntryStart:(id)sender {
    
    if (referralCodeField.text.length >0) {
        referralCodeImgv.image = [UIImage imageNamed:@"right-sign.png"];
    }
    else {
        referralCodeImgv.image = [UIImage imageNamed:@"Wrong-sign.png"];
        
    }
    
}

-(void)timeSelectedInPicker:(NSDate*)date
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"MM/dd/yyyy"];
    
    dateOfBirth.text = [formater stringFromDate:date];
    dateOfBirth.enabled = NO;
    
    if([dateOfBirth.text length] > 0)
    {
        dateOfBirthTickImgv.image = [UIImage imageNamed:@"right-sign.png"];
        [dateOfBirth setTextColor:[UIColor blackColor]];
    }
    else {
        dateOfBirthTickImgv.image = [UIImage imageNamed:@"Wrong-sign.png"];
        //[dateOfBirth setText:@"Date of Birth"];
        
    }
}

#pragma mark - Sign up response
-(void)signupresponse_more:(NSDictionary *)results{
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
    
  
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == referralCodeField)
    {
        [referralCodeField becomeFirstResponder];
    }
    
    [textField resignFirstResponder];
    return YES;
}
@end



#pragma mark
#pragma mark ActionSheetDatePicker

@implementation ActionSheetDatePicker
@synthesize actionSheet,target ,action;
@synthesize bBirthDatePickerValueChanged;
#define PICKERVIEW_HEIGHT 216

-(id)initWithTarget:(id)target_ withSelector:(SEL)selector_  withsetTime:(NSString *)time_
{
	if ((self = [super init])) {
		self.target = target_;
		self.action = selector_;
		setTime = nil;
		if (time_ != nil) {
			setTime = [NSString stringWithString:time_];
		}
        
	}
	return self;
}



-(void)ShowActionPickerInView:(UIViewController*)inViewController
{
	[inViewController.navigationController setToolbarHidden:YES];
	
    bBirthDatePickerValueChanged = NO;
 

	self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	[self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	[self.actionSheet setDelegate:self];
	
	
	//Done button at right side.
	UISegmentedControl *DoneSegmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
	DoneSegmentedControl.momentary = YES;
	DoneSegmentedControl.frame = CGRectMake(265, 7, 50, 30);
	DoneSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	DoneSegmentedControl.tintColor = [UIColor blackColor];
	[DoneSegmentedControl addTarget:self action:@selector(actionPickerDone) forControlEvents:UIControlEventValueChanged];
	[self.actionSheet addSubview:DoneSegmentedControl];
	[DoneSegmentedControl release];
	
	
	//Cancel button at left side.
	UISegmentedControl *CancelSegmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Cancel"]];
	CancelSegmentedControl.momentary = YES;
	CancelSegmentedControl.frame = CGRectMake(2, 7, 55, 30);
	CancelSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	CancelSegmentedControl.tintColor = [UIColor blackColor];
	[CancelSegmentedControl addTarget:self action:@selector(actionPickerCancel) forControlEvents:UIControlEventValueChanged];
	[self.actionSheet addSubview:CancelSegmentedControl];
	[CancelSegmentedControl release];
	
	
	
	//UIPIckerView Added in action sheet.
	CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
	UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:pickerFrame];
	datePicker.tag = 55555;
	datePicker.datePickerMode  = UIDatePickerModeDate;
    NSLocale *        enUSPOSIXLocale;
    enUSPOSIXLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease];
    [datePicker setLocale:enUSPOSIXLocale];
	datePicker.minuteInterval = 15;
	[datePicker addTarget:self
				   action:@selector(datePickerChanged:)
		 forControlEvents:UIControlEventValueChanged];
	NSDate *FinalSetDate= [NSDate date];
	NSCalendar *calendar = [NSCalendar currentCalendar];
    [datePicker setTimeZone:[NSTimeZone defaultTimeZone]];
    [calendar setLocale:enUSPOSIXLocale];

    
	// Set the selected date in the fraction of 15 min
	// i.e. if current time is 6:35 PM , we have to set it 6:30 PM.
	NSDateComponents *fractionComponents = [calendar components:(NSMinuteCalendarUnit)
													   fromDate:FinalSetDate];
	
	int fraction = [fractionComponents minute] % 15;
	FinalSetDate = [FinalSetDate dateByAddingTimeInterval:fraction*(-60)];
	datePicker.date = FinalSetDate;
	[self.actionSheet addSubview:datePicker];
	[datePicker release];
	
	
	
	[self.actionSheet showInView:inViewController.view];
	[self.actionSheet setFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-PICKERVIEW_HEIGHT - 60, inViewController.view.frame.size.width, PICKERVIEW_HEIGHT)]; //iPhone 5
    //[self.actionSheet setFrame:CGRectMake(0, topcontroller.view.frame.size.height/2, topcontroller.view.frame.size.width, 216)];
    
}



#pragma mark
#pragma mark SegmentedControl Methods
- (void)actionPickerCancel
{
	[self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
	//[self.target performSelector:self.action withObject:pickerDate];
}
- (void)actionPickerDone {
	
	UIDatePicker *dtPicker = (UIDatePicker *)[self.actionSheet viewWithTag:55555];
    NSDate* pickerDate = dtPicker.date;
	[self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
	[self.target performSelector:self.action withObject:pickerDate];
}
-(void)datePickerChanged:(id)sender
{
    bBirthDatePickerValueChanged = YES;
}

-(void) dealloc
{
	[actionSheet release];
	[super dealloc];
}

@end
