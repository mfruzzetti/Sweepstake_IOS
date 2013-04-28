//
//  MyprofileViewController.m
//  Sweepstakes
//
//  Created by Peerbits Solution on 03/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "MyprofileViewController.h"
#import "Parse/Parse.h"

@interface MyprofileViewController ()

@end

@implementation MyprofileViewController
@synthesize socialback;
@synthesize scview;
@synthesize scrollview;
@synthesize creditslb;
@synthesize mysweepstakelb;
@synthesize socilasettinglb;
@synthesize loadmorelb;
@synthesize namelb;
@synthesize placelb;
@synthesize profileimgview;
@synthesize tokennumlb;
@synthesize sweepnumlb;
@synthesize fblbl;
@synthesize twilbl;
@synthesize googlelbl;
@synthesize pushlbl,fbGraph;
@synthesize loadmoreimgview,userid;


int i ;
float x;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)LoadMyEntries{
     NSLog(@"LoadMyEntries");
    sweepstaletableview.tag=2;
    [sweepstaletableview reloadData];
}

-(void)LoadMySweepstake{
    NSLog(@"LoadMySweepstake");
    sweepstaletableview.tag=1;
    [sweepstaletableview reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    refrallb.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:15];
    
    namelb.font =[UIFont fontWithName:@"MyriadPro-Regular" size:17];
    placelb.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:15];
    sweepnumlb.font = [UIFont fontWithName:@"MyriadPro-Bold" size:15];
    tokennumlb.font = [UIFont fontWithName:@"MyriadPro-Bold" size:15];
    loadmorelb.font = [UIFont fontWithName:@"Calibri" size:17];
    mysweepstakelb.font = [UIFont fontWithName:@"Calibri" size:17];
    socilasettinglb.font = [UIFont fontWithName:@"Calibri" size:17];
    fblbl.font = [UIFont fontWithName:@"Calibri-BoldItalic" size:17];
    twilbl.font = [UIFont fontWithName:@"Calibri-BoldItalic" size:17];
    googlelbl.font = [UIFont fontWithName:@"Calibri-BoldItalic" size:17];
    pushlbl.font = [UIFont fontWithName:@"Calibri-BoldItalic" size:17];
    creditslb.font = [UIFont fontWithName:@"Calibri-BoldItalic" size:18];
    [self.scrollview setContentSize:CGSizeMake(320, 450)];
     dc = [[LLDataControll alloc]init];
    
    UITapGestureRecognizer *TapmyEntries = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LoadMyEntries)] ;
    
    //[self.my_entriesImg addGestureRecognizer:TapmyEntries];
    
    
    UITapGestureRecognizer *TapmySweepstake = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LoadMySweepstake)] ;
    
    [self.my_sweepImg addGestureRecognizer:TapmySweepstake];
    
    
    UITapGestureRecognizer *Tapmore = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Taptoloadmore)] autorelease];
    
    [loadmoreimgview addGestureRecognizer:Tapmore];
    mc = [[ModelClass alloc]init];
    [mc setDelegate:self];
     DELEGATE.menuController.delegate = self;
//    _menuController = [[DDMenuController alloc] initWithRootViewController:self.navigationController];
//    [_menuController setDelegate:self];
//    MenuViewController *leftController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
//    _menuController.leftViewController = leftController;
//    
//    
//    //  DELEGATE.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    DELEGATE.window.rootViewController = _menuController;
//    [DELEGATE.window makeKeyAndVisible];

    if (DELEGATE.isHostAvailable) {
        [mc Userinfo:userid start:@"0" selector:@selector(userinforesponse:)];
    }else 
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    sweepstaletableview.scrollEnabled = YES;
    
    //13 March 13 KB
//    UITapGestureRecognizer *captureImageViewTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(captureMyImage)] autorelease];
//    [btnProfilePhoto addGestureRecognizer:captureImageViewTap];
//    //[captureImageViewTap release];
//    UISwipeGestureRecognizer *recognizer;
//    
//    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft)];
//    [[self view] addGestureRecognizer:recognizer];
//    [recognizer addTarget:self action:@selector(handleSwipeFrom:)];
//    [recognizer release];
    
    sweepstaletableview.backgroundColor = [UIColor whiteColor];
    
    [btnProfilePhoto addTarget:self action:@selector(captureMyImage) forControlEvents:UIControlEventTouchUpInside];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    //[locationManager startUpdatingLocation];

}

// this delegate is called when the app successfully finds your current location
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
 
   // CLLocation *LocationAtual = [[CLLocation alloc] initWithLatitude:23.0333  longitude:72.6167];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        
        NSLog(@"%@ %@ %@ %@ %@ %@ %@ %@", placemark.country, placemark.ISOcountryCode, placemark.postalCode, placemark.administrativeArea, placemark.locality, placemark.subLocality, placemark.thoroughfare, placemark.subThoroughfare);
        
        NSString* strLocation = @"";
        if([placemark.locality length] > 0)
            strLocation = [NSString stringWithFormat:@"%@",placemark.locality];
        
        if([placemark.administrativeArea length] > 0){
        
            if([placemark.locality length] > 0)
                strLocation = [strLocation stringByAppendingFormat:@", %@",placemark.administrativeArea];
            else
                strLocation = [strLocation stringByAppendingFormat:@"%@",placemark.administrativeArea];
        }
        lblLocation.text = strLocation;
        
        //Let's make a server call to update the location in the server
        [mc updateUserLocationFor:userid withCity:placemark.locality withState:placemark.administrativeArea];
        
        //subscribe location channel on parse
        if ([placemark.country length] > 0) {
            [self performSelector:@selector(subscribeChannelOnParse:) withObject:placemark.country];
        }
        
         [geocoder release];
    }];

    //this creates a MKReverseGeocoder to find a placemark using the found coordinates
//        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    
//        [geocoder reverseGeocodeLocation:newLocation // You can pass aLocation here instead
//                       completionHandler:^(NSArray *placemarks, NSError *error) {
//    
//                           dispatch_async(dispatch_get_main_queue(),^ {
//                               // do stuff with placemarks on the main thread
//    
//                              if (placemarks.count == 1) {
//    
//                                   CLPlacemark *place = [placemarks objectAtIndex:0];
//                                   NSString *zipString = [place.addressDictionary valueForKey:@"ZIP"];
//                                  NSString* city = [place.addressDictionary valueForKey:@"City"];
//                                  NSString* street = [place.addressDictionary valueForKey:@"Street"];
//                                  NSLog(street);
//                                  NSLog(city);
//                                  NSLog(zipString);
//
//                              }
//    
//                          });
//    
//                    }];
}

// this delegate method is called if an error occurs in locating your current location
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"locationManager:%@ didFailWithError:%@", manager, error);
}

#pragma subscribe location channel on parse
-(void)subscribeChannelOnParse :(NSString *)location{
    
    //subscribe the channel
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceToken:DELEGATE.tokenstring];
    NSMutableArray *channelsArr = [currentInstallation.channels mutableCopy];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    if ([channelsArr count] == 0) {
        [tempArray addObject:location];
    }else{
    
        [channelsArr addObject:location];
        [currentInstallation removeObjectForKey:@"channels"];
       
        for (id item in channelsArr){
            if (![tempArray containsObject:item])
                [tempArray addObject:item];
        }
    }
    
    NSLog(@"channels with location :- %@",tempArray);
    
    [currentInstallation addObjectsFromArray:tempArray forKey:@"channels"];
    [currentInstallation saveInBackground];
    
}

// this delegate is called when the reverseGeocoder finds a placemark
 
- (void)viewWillAppear:(BOOL)animated {
    DELEGATE.nCurrentListItem = CURRENT_LIST_ITEM_MY_PROFILE;
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight)
    {
        //click code on top left button
        CGRect frame = _backbtn.frame;
        frame.size.width = 41;
        _backbtn.frame = frame;

        [_backbtn setImage:[UIImage imageNamed:@"menu_open.png"] forState:UIControlStateNormal];
        [DELEGATE.menuController showLeftController:YES];
    }
    else
    {
        
    }
    NSLog(@"Swipe received.");
}
#pragma mark -
#pragma mark TapGesture Recognizer - to open camera - KB
-(void)captureMyImage
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Profile Photo" message:@"Please select your profile photo" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Capture Photo",@"Choose Photo",nil];
    [alert show];
    [alert release];

//    UIImagePickerController *UIPicker;
//    UIPicker = [[UIImagePickerController alloc] init];
//    UIPicker.allowsEditing = YES;
//	UIPicker.delegate = self;
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//		UIPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//		[self presentModalViewController:UIPicker animated:YES];
//        
//	}
//	else {
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sweepstakes"
//                                                        message:@"Your device has not camera facility available."
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//		[alert show];
//		[alert release];
//	}
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [profileimgview setImage:image];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *imageName = [NSString stringWithFormat:@"profilepic.png"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:YES];
    
    
    
    
   // [profileimgview setNeedsLayout];
    // iOS5 changes.
    [self dismissModalViewControllerAnimated:YES];
    
    [self uploadImage:image];
}

//Uploads an image to the server
-(void) uploadImage:(UIImage *) theImage {
    
    NSData *imageData = UIImageJPEGRepresentation(theImage, 40);
	// setting up the URL to post to
	NSString *urlString = [NSString stringWithFormat:@"%@/users/uploadUserImage", API_PATH];
	
	// setting up the request object now
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
	
	/*
	 add some header info now
	 we always need a boundary when we post a file
	 also we need to set the content type
	 
	 You might want to generate a random boundary.. this is just the same
	 as my output from wireshark on a valid html post
     */
	NSString *boundary = @"---------------------------14737809831466499882746641449";
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
	[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
	
	/*
	 now lets create the body of the post
     */
	NSMutableData *body = [NSMutableData data];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name='userfile'; filename='profile_%@_img.jpg'\r\n", userid] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[NSData dataWithData:imageData]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	// setting the body of the post to the reqeust
	[request setHTTPBody:body];
	
	// now lets make the connection to the web
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	
	NSLog(returnString);
    
    
    
     
    NSLog(@"UPLOAD FUNCTION CALLED");

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // iOS5 changes.
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - other methods
-(void)menuController:(DDMenuController *)controller willShowViewController:(UIViewController *)controllerr{
    
    if (controllerr == controller.leftViewController) {
        CGRect frame = _backbtn.frame;
        frame.size.width = 41;
        _backbtn.frame = frame;

        [_backbtn setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    }
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    /*
    FMResultSet *results=[db executeQuery:@"SELECT * FROM login_master where rowid=1"];
    while ([results next]) 
    {
        
        creditslb.text = [NSString stringWithFormat:@"%@",[results stringForColumn:@"credits"]];
        
    }
*/
    FMResultSet *resultss=[db executeQuery:@"SELECT * FROM setting where isettingid=1"];
    while ([resultss next]) 
    {
        
      
       
        if ([[resultss stringForColumn:@"facebook"]isEqualToString:@"NO"]) {
           fbbtn.tag = 0;
        [fbbtn setBackgroundImage:[UIImage imageNamed:@"offbtn.png"] forState:UIControlStateNormal];
            fbbtn.userInteractionEnabled = NO;
        }
        else {
            fbbtn.tag = 1;
            [fbbtn setBackgroundImage:[UIImage imageNamed:@"onbtn.png"] forState:UIControlStateNormal];
            fbbtn.userInteractionEnabled = YES;
        }
        if ([[resultss stringForColumn:@"twitter"]isEqualToString:@"NO"]) {
            twitterbtn.tag = 0;
            [twitterbtn setBackgroundImage:[UIImage imageNamed:@"offbtn.png"] forState:UIControlStateNormal];
            twitterbtn.userInteractionEnabled = NO;
        }
        else {
            twitterbtn.tag = 1;
            [twitterbtn setBackgroundImage:[UIImage imageNamed:@"onbtn.png"] forState:UIControlStateNormal];
            twitterbtn.userInteractionEnabled = YES;
        }
        if ([[resultss stringForColumn:@"google"]isEqualToString:@"NO"]) {
            googlebtn.tag = 0;
            [googlebtn setBackgroundImage:[UIImage imageNamed:@"offbtn.png"] forState:UIControlStateNormal];
          //  googlebtn.userInteractionEnabled = NO;
        }
        else {
            googlebtn.tag = 1;
            [googlebtn setBackgroundImage:[UIImage imageNamed:@"onbtn.png"] forState:UIControlStateNormal];
            // googlebtn.userInteractionEnabled = YES;
        }
        
        if ([[resultss stringForColumn:@"pushnoti"]isEqualToString:@"NO"]) {
            pushnotibtn.tag = 0;
            [pushnotibtn setBackgroundImage:[UIImage imageNamed:@"offbtn.png"] forState:UIControlStateNormal];
        }
        else {
            pushnotibtn.tag = 1;
            [pushnotibtn setBackgroundImage:[UIImage imageNamed:@"onbtn.png"] forState:UIControlStateNormal];
        }
        
    }
    [db close];
     /*
    CGSize textSize = [creditslb.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
    x= textSize.width;
    if (plus) {
        CGRect frame = CGRectMake(268-x,5,10,20);
        plus.frame = frame;
    }
    else 
    {
        plus = [[UILabel alloc]initWithFrame:CGRectMake(268-x,5,10,20)];
        [plus setTextColor:[UIColor colorWithRed:28.0/255.0 green:107.0/255.0 blue:130.0/255.0 alpha:1.0]];
        [plus setBackgroundColor:[UIColor clearColor]];
        plus.textAlignment = UITextAlignmentRight;
        plus.font=[UIFont fontWithName:@"Calibri-BoldItalic" size:12];
        plus.text = @"+";
        [self.view addSubview:plus];
        [plus release];
    }
    if (credit) {
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
        [credit release];    } */

}
- (void)imageDidLoad: (DTLazyImageView *) lazyImageView
{
    
}

-(void)userinforesponse:(NSDictionary *)results{
    NSLog(@"THE USER INFO -->%@",results);
    
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
 
    
    if([result isEqualToString:@"true"]){
        refrallb.text=[NSString stringWithFormat:@"%@",[[results valueForKey:@"User"]valueForKey:@"referral_id"]];
        namelb.text = [NSString stringWithFormat:@"%@ %@",[[results valueForKey:@"User"]valueForKey:@"first_name"],[[results valueForKey:@"User"]valueForKey:@"last_name"]];
        tokennumlb.text= [NSString stringWithFormat:@"%@",[[results valueForKey:@"User"]valueForKey:@"credits"]];
        creditslb.text = [NSString stringWithFormat:@"%@",[[results valueForKey:@"User"]valueForKey:@"credits"]];
        sweepnumlb.text = [NSString stringWithFormat:@"%@",[results valueForKey:@"mysweep"]];
        //Location from database
        NSString *strCity, *strState;
        strCity = [[results valueForKey:@"User"]valueForKey:@"city"];
        strState = [[results valueForKey:@"User"]valueForKey:@"state"];
        //NSLog(@"City and State are %@ and %@", strCity, strState);
        if(!strCity.length == 0 && !strState.length == 0)
        {
            //City and state available from server, let's set it
            lblLocation.text = [NSString stringWithFormat:@"%@, %@", strCity, strState];
            [locationManager stopUpdatingLocation];
        }
        else{
            [locationManager startUpdatingLocation];
        }
        
        proimage = [[DTLazyImageView alloc] initWithFrame:CGRectMake(0,0,59,71)];
        proimage.delegate = self;
    //  lazyImageView.contentMode = UIViewContentModeScaleAspectFill;
    
        NSString *imageURL = [NSString stringWithFormat:@"%@img/uploads/users/%@", IMGPATH, [[results valueForKey:@"User"]valueForKey:@"image"]];
        proimage.url = [NSURL URLWithString:imageURL];
        proimage.backgroundColor= [UIColor clearColor];
    //[profileimgview addSubview:proimage];
        if (!proimage.image)
        {
            [proimage startLoading];
            proimage.actv.frame = CGRectMake(15.0,20.0, 30.0, 30.0);
        
        }
        
                
        
        
        is_livearray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"Sweep"]valueForKey:@"is_live"]];
        prizearray =[[NSMutableArray alloc]initWithArray:[[results valueForKey:@"Sweep"]valueForKey:@"prize"]];
        titlearray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"Sweep"]valueForKey:@"title"]];
        iswinnerarray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"Sweep"]valueForKey:@"is_winner"]];
        winnernamearray = [[NSMutableArray alloc]initWithArray: [[results valueForKey:@"Sweep"]valueForKey:@"winner_name"]];
        timearray = [[NSMutableArray alloc]initWithArray: [[results valueForKey:@"Sweep"]valueForKey:@"time"]];
        entry_countarray=[[NSMutableArray alloc]initWithArray:[[results valueForKey:@"Sweep"]valueForKey:@"entry_count"]];
        sweepidarray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"Sweep"]valueForKey:@"sweepstakes_id"]];
       
        NSString *imageName = [NSString stringWithFormat:@"profilepic.png"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
        
      //  NSLog(@"pathToFile-->%@",fullPathToFile);
        if ([fileManager fileExistsAtPath:fullPathToFile]) {
       
            [profileimgview setImage:[UIImage imageWithContentsOfFile:fullPathToFile]];
        }
        else{
            //The following works greatr but takes freezes the main thread
            //[profileimgview setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]]];
            
            //Asynchronous approach
            NSURL *url = [NSURL URLWithString:imageURL];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            //NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
            
            //NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            
            [NSURLConnection
                        sendAsynchronousRequest:request
                        queue:[[NSOperationQueue alloc] init]
                        completionHandler:^(NSURLResponse *response,
                                 NSData *data,
                                 NSError *error)
             {
                 
                 if ([data length] >0 && error == nil)
                 {
                     
                     // Write the data to file and use it
                     //At this point the image data is in responseData, have to write that to local file
                     
                     NSString *imageName = [NSString stringWithFormat:@"profilepic.png"];
                     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                     NSString *documentsDirectory = [paths objectAtIndex:0];
                     NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
                     [data writeToFile:fullPathToFile atomically:YES];
                     //Set image to the image view
                     [profileimgview setImage:[UIImage imageWithContentsOfFile:fullPathToFile]];
                     
                     
                 }
                 else if ([data length] == 0 && error == nil)
                 {
                     NSLog(@"Nothing was downloaded.");
                 }
                 else if (error != nil){
                     NSLog(@"FILE DOWNLOAD ERROR = %@", error);
                 }
                 
             }];
            
            
            
            //[responseData writeToFile:[NSString stringWithFormat:@"%@/%@",documentsDirectory,imageName] atomically:NO];
            //[obj setValue:[NSNumber numberWithBool:YES] forKey:@"imageDownloaded"];
            
            
        }
        
        if ([[[results valueForKey:@"Sweep"]valueForKey:@"is_live"]count]==0)
        {
          
            if(!IS_IPHONE_5)
                [sweepstaletableview setFrame:CGRectMake(0, 232, 320,228)];
            else
                [sweepstaletableview setFrame:CGRectMake(0, 232, 320,316)];
            [scview setFrame:CGRectMake(0, 71, 320,210 )];
            [scrollview setContentSize:CGSizeMake(320, 280)];
                        
        }
        
        if ([[[results valueForKey:@"Sweep"]valueForKey:@"is_live"]count]==1)
        {
           
            if(!IS_IPHONE_5)
                [sweepstaletableview setFrame:CGRectMake(0, 232, 320,228)];
            else
                [sweepstaletableview setFrame:CGRectMake(0, 232, 320,316)];
            [scview setFrame:CGRectMake(0, 71, 320,210 )];
            [scrollview setContentSize:CGSizeMake(320, 280)];

        }
        
        if ([[[results valueForKey:@"Sweep"]valueForKey:@"is_live"]count]==2)
        {
           
            
            if(!IS_IPHONE_5)
                [sweepstaletableview setFrame:CGRectMake(0, 232, 320,228)];
            else
                [sweepstaletableview setFrame:CGRectMake(0, 232, 320,316)];
            [scview setFrame:CGRectMake(0, 112, 320,210 )];
            [scrollview setContentSize:CGSizeMake(320, 360)];
        }
      
        if ([[[results valueForKey:@"Sweep"]valueForKey:@"is_live"]count]==3)
        {
           
            
            if(!IS_IPHONE_5)
                [sweepstaletableview setFrame:CGRectMake(0, 232, 320,228)];
            else
                [sweepstaletableview setFrame:CGRectMake(0, 232, 320,316)];
            [scview setFrame:CGRectMake(0, 153, 320,210 )];
            [scrollview setContentSize:CGSizeMake(320, 400)];
        }
        if ([[[results valueForKey:@"Sweep"]valueForKey:@"is_live"]count]==4)
        {
          
            
            if(!IS_IPHONE_5)
                [sweepstaletableview setFrame:CGRectMake(0, 232, 320,228)];
            else
                [sweepstaletableview setFrame:CGRectMake(0, 232, 320,316)];
            [scview setFrame:CGRectMake(0, 194, 320,210 )];
            [scrollview setContentSize:CGSizeMake(320, 440)];
            
        }
        if(!IS_IPHONE_5)
            [sweepstaletableview setFrame:CGRectMake(0, 232, 320,228)];
        else
            [sweepstaletableview setFrame:CGRectMake(0, 232, 320,316)];



        [sweepstaletableview reloadData];
        
    }else if([[results valueForKey:@"message"]isEqualToString:@"User Does Not Exists"])
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
       // creditslb.text = @"0";
       
    }
    else {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:[results valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
        
        if(!IS_IPHONE_5)
            [sweepstaletableview setFrame:CGRectMake(0, 232, 320,228)];
        else
            [sweepstaletableview setFrame:CGRectMake(0, 232, 320,316)];
        [scview setFrame:CGRectMake(0, 71, 320,210 )];
        [scrollview setContentSize:CGSizeMake(320, 280)];

    }
/*
    CGSize textSize = [creditslb.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
    x= textSize.width;
        CGRect frame = CGRectMake(268-x,5,10,20);
        plus.frame = frame;
   
        CGRect frame1 = CGRectMake(277,13,40,20);
        credit.frame = frame1;
     */
//    if(!([titlearray count] > 0))
//        loadmorelb.hidden = TRUE;         //KB - Load More Label Hidden logic
//    else
//        loadmorelb.hidden = FALSE;
}

-(void)Taptoloadmore
{
    
    if (DELEGATE.isHostAvailable) {
        
      [mc Userinfosweeps:userid start:[NSString stringWithFormat:@"%d",[titlearray count]] selector:@selector(sweeploadres:)];
    }
    else 
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }

}

-(void)sweeploadres:(NSDictionary *)results{
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];

    
    if([result isEqualToString:@"true"]){
      
        [is_livearray addObjectsFromArray:[[results valueForKey:@"Sweep"]valueForKey:@"is_live"]];
        [prizearray addObjectsFromArray:[[results valueForKey:@"Sweep"]valueForKey:@"prize"]];
        [titlearray addObjectsFromArray:[[results valueForKey:@"Sweep"]valueForKey:@"title"]];
        [iswinnerarray addObjectsFromArray:[[results valueForKey:@"Sweep"]valueForKey:@"is_winner"]];
        [winnernamearray  addObjectsFromArray: [[results valueForKey:@"Sweep"]valueForKey:@"winner_name"]];
        [timearray addObjectsFromArray:[[results valueForKey:@"Sweep"]valueForKey:@"time"]];
        
      
       
        if ([[[results valueForKey:@"Sweep"]valueForKey:@"is_live"]count]==1) 
        {
          
          
            [sweepstaletableview setFrame:CGRectMake(0, 232, 320,((sweepstaletableview.frame.size.height)+42))];
            [scview setFrame:CGRectMake(0, ((scview.frame.origin.y)+42), 320,210 )];
            [scrollview setContentSize:CGSizeMake(320, (scrollview.contentSize.height+42))];
          
        }
        if ([[[results valueForKey:@"Sweep"]valueForKey:@"is_live"]count]==2) 
        {
           
            
            [sweepstaletableview setFrame:CGRectMake(0, 232, 320,((sweepstaletableview.frame.size.height)+84))];
            [scview setFrame:CGRectMake(0, ((scview.frame.origin.y)+84), 320,210 )];
            [scrollview setContentSize:CGSizeMake(320, (scrollview.contentSize.height+84))];
            
        }
        if ([[[results valueForKey:@"Sweep"]valueForKey:@"is_live"]count]==3) 
        {
           
            
            [sweepstaletableview setFrame:CGRectMake(0, 232, 320,((sweepstaletableview.frame.size.height)+126))];
            [scview setFrame:CGRectMake(0, ((scview.frame.origin.y)+126), 320,210 )];
            [scrollview setContentSize:CGSizeMake(320, (scrollview.contentSize.height+126))];
            
        }
        if ([[[results valueForKey:@"Sweep"]valueForKey:@"is_live"]count]==4) 
        {
           
            
            [sweepstaletableview setFrame:CGRectMake(0, 232, 320,((sweepstaletableview.frame.size.height)+168))];
            [scview setFrame:CGRectMake(0, ((scview.frame.origin.y)+168), 320,210 )];
            [scrollview setContentSize:CGSizeMake(320, (scrollview.contentSize.height+168))];
            
        }

        
        [sweepstaletableview reloadData];
                 
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
        /*
        creditslb.text = @"0"; 
        CGSize textSize = [creditslb.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
        x= textSize.width;
        CGRect frame = CGRectMake(268-x,5,10,20);
        plus.frame = frame;
        CGRect frame1 = CGRectMake(277,13,40,20);
        credit.frame = frame1;
         */
    }

    else {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:[results valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
        
    }

}


-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    return [titlearray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    // add a placeholder cell while waiting on table data
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    } 
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    
    UIView *uview=[[UIView alloc]initWithFrame:CGRectMake(1,0,319,60)];
    uview.layer.masksToBounds=YES;
    
    
    //The arrow head would be shown only when the sweepstakes is still alive
    //Depending on if the sweepstakes is live, set the color of the text
    if([[is_livearray objectAtIndex:indexPath.row]isEqualToString:@"Y"])
    {
        //Over
        UIImageView *cellarrow =[[UIImageView alloc] initWithFrame:CGRectMake(295,18,11,18)];
        cellarrow.image=[[UIImage alloc]init];
        cellarrow.image = [UIImage imageNamed:@"arrowhead.png"];
        [uview addSubview:cellarrow];
        [cellarrow release];
    }
    
    
    UIImageView *verticalLine =[[UIImageView alloc] initWithFrame:CGRectMake(54,15,1,30)];
    verticalLine.image=[[UIImage alloc]init];
    verticalLine.image = [UIImage imageNamed:@"standingline.png"];
    [uview addSubview:verticalLine];
    [verticalLine release];

    UIImageView *imgEntryBG =[[UIImageView alloc] initWithFrame:CGRectMake(10,14,31,31)];
    imgEntryBG.image=[[UIImage alloc]init];
    imgEntryBG.image = [UIImage imageNamed:@"entries.png"];
    [uview addSubview:imgEntryBG];
    [imgEntryBG release];
    
    //The UI Label to set the number of entries
    NSString *thisRowNoOfCounts = [NSString stringWithFormat:@"%@",[entry_countarray objectAtIndex:indexPath.row]];
    //Init the label
    UILabel *lblNoOfEntries = nil;
    //Depending on the lenght of the string, we would place the label
    if([thisRowNoOfCounts length] == 1)
    {
        lblNoOfEntries = [[UILabel alloc]initWithFrame:CGRectMake(22,19,28,28)];
    }
    else
    {
        lblNoOfEntries = [[UILabel alloc]initWithFrame:CGRectMake(18,19,28,28)];
    }
    
    //Depending on if the sweepstakes is live, set the color of the text
    if([[is_livearray objectAtIndex:indexPath.row]isEqualToString:@"N"])
    {
        //Over
        [lblNoOfEntries setTextColor:[UIColor colorWithRed:142.0/255.0 green:183.0/255.0 blue:195.0/255.0 alpha:1.0]];
    }
    else{
        //Still live
        [lblNoOfEntries setTextColor:[UIColor colorWithRed:243.0/255.0 green:111.0/255.0 blue:56.0/255.0 alpha:1.0]];
    }
    [lblNoOfEntries setBackgroundColor:[UIColor clearColor]];
    lblNoOfEntries.font=[UIFont fontWithName:@"Calibri-Bold" size:15];
    lblNoOfEntries.text = thisRowNoOfCounts;
    [uview addSubview:lblNoOfEntries];
    
    

    UIImageView *status =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,39,39)];
    status.image=[[UIImage alloc]init];
    if ([[is_livearray objectAtIndex:indexPath.row]isEqualToString:@"N"]) 
    {
       status.image = [UIImage imageNamed:@"Ended-label"]; 
    }
    else 
    {
        status.image = nil; //[UIImage imageNamed:@"live.png"];
    }
    [uview addSubview:status];
    [status release];
    
    
    UILabel *mainlb = [[UILabel alloc]initWithFrame:CGRectMake(70,12,224,20)];
    [mainlb setTextColor:[UIColor colorWithRed:95.0/255.0 green:95.0/255.0 blue:95.0/255.0 alpha:1.0]];
    [mainlb setBackgroundColor:[UIColor clearColor]];
    mainlb.textAlignment = UITextAlignmentLeft;
    mainlb.font=[UIFont fontWithName:@"Calibri-BoldItalic" size:15];
    mainlb.text = [NSString stringWithFormat:@"$%@ %@",[prizearray objectAtIndex:indexPath.row],[titlearray objectAtIndex:indexPath.row]];
    [uview addSubview:mainlb];
    [mainlb release];
    
        if (tableView.tag==1) {
        UILabel *detaillb = [[UILabel alloc]initWithFrame:CGRectMake(70,28,250,25)];
        [detaillb setTextColor:[UIColor colorWithRed:149.0/255.0 green:149.0/255.0 blue:149.0/255.0 alpha:1.0]];
        [detaillb setBackgroundColor:[UIColor clearColor]];
        detaillb.textAlignment = UITextAlignmentLeft;
        detaillb.font=[UIFont fontWithName:@"MyriadPro-Regular" size:13];
        if ([[is_livearray objectAtIndex:indexPath.row]isEqualToString:@"Y"]) {
            detaillb.text = [NSString stringWithFormat:@"Ends: %@",[timearray objectAtIndex:indexPath.row]];
        }
        else if([[iswinnerarray objectAtIndex:indexPath.row]isEqualToString:@"Y"]){
            detaillb.text = [NSString stringWithFormat:@"Winner: %@",[winnernamearray objectAtIndex:indexPath.row]];
        }
        else {
            detaillb.text =[NSString stringWithFormat:@""];
        }
        [uview addSubview:detaillb];
        [detaillb release];
    }
    else{
        UILabel *detaillb = [[UILabel alloc]initWithFrame:CGRectMake(70,28,250,25)];
        [detaillb setTextColor:[UIColor colorWithRed:149.0/255.0 green:149.0/255.0 blue:149.0/255.0 alpha:1.0]];
        [detaillb setBackgroundColor:[UIColor clearColor]];
        detaillb.textAlignment = UITextAlignmentLeft;
        detaillb.font=[UIFont fontWithName:@"MyriadPro-Regular" size:13];
        detaillb.text = [NSString stringWithFormat:@"No of entries: %@",[entry_countarray objectAtIndex:indexPath.row]];
        [uview addSubview:detaillb];
        [detaillb release];
    }

    

    
    
    
//    UILabel *detaillb = [[UILabel alloc]initWithFrame:CGRectMake(70,28,250,25)];
//    [detaillb setTextColor:[UIColor colorWithRed:149.0/255.0 green:149.0/255.0 blue:149.0/255.0 alpha:1.0]];
//    [detaillb setBackgroundColor:[UIColor clearColor]];
//    detaillb.textAlignment = UITextAlignmentLeft;
//    detaillb.font=[UIFont fontWithName:@"MyriadPro-Regular" size:13];
//    if ([[is_livearray objectAtIndex:indexPath.row]isEqualToString:@"Y"]) {
//        detaillb.text = [NSString stringWithFormat:@"Ends: %@ | Entries: %@",[timearray objectAtIndex:indexPath.row],[entry_countarray objectAtIndex:indexPath.row]];
//    }
//    else if([[iswinnerarray objectAtIndex:indexPath.row]isEqualToString:@"Y"]){
//        detaillb.text = [NSString stringWithFormat:@"Winner: %@ | Entries: %@",[winnernamearray objectAtIndex:indexPath.row],[entry_countarray objectAtIndex:indexPath.row]];
//    }
//    else {
//        detaillb.text =[NSString stringWithFormat:@"Entries: %@",[entry_countarray objectAtIndex:indexPath.row]];
//    }
//    [uview addSubview:detaillb];
//    [detaillb release];

    
    [cell addSubview:uview];
    [uview release];

    return cell;
    
}
/*
- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated{
 
    [sweepstaletableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];

}
*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{   
    [sweepstaletableview deselectRowAtIndexPath:indexPath animated:YES];
    
    //Check if it's stil live
    if([[is_livearray objectAtIndex:[indexPath row]]isEqualToString:@"Y"])
    {
        SweepDetailViewController *godetail = [[SweepDetailViewController alloc]initWithNibName:@"SweepDetailViewController" bundle:nil];
        godetail.selectedsweepid =[sweepidarray objectAtIndex:[indexPath row]];
        godetail.userid = userid;
        [self.navigationController pushViewController:godetail animated:YES];
        
        DELEGATE.tempNav = self.navigationController;
    }
    
}


- (void)viewDidUnload
{
    [sweepstaletableview release];
    sweepstaletableview = nil;
    [self setMysweepstakelb:nil];
    [self setSocilasettinglb:nil];
    [self setLoadmorelb:nil];
    [self setNamelb:nil];
    [self setPlacelb:nil];
    [self setProfileimgview:nil];
    [self setTokennumlb:nil];
    [self setSweepnumlb:nil];
    [self setFblbl:nil];
    [self setTwilbl:nil];
    [self setGooglelbl:nil];
    [self setPushlbl:nil];
    
   
    [self setCreditslb:nil];
    [self setLoadmoreimgview:nil];
    [fbbtn release];
    fbbtn = nil;
    [twitterbtn release];
    twitterbtn = nil;
    [googlebtn release];
    googlebtn = nil;
    [pushnotibtn release];
    pushnotibtn = nil;
    [self setScrollview:nil];
    [self setSocialback:nil];
    [self setScview:nil];
    
    [refrallb release];
    refrallb = nil;
    [my_sweepImg release];
    my_sweepImg = nil;
    [my_entriesImg release];
    my_entriesImg = nil;
    [self setMy_entriesImg:nil];
    [self setMy_sweepImg:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [sweepstaletableview release];
    [mysweepstakelb release];
    [socilasettinglb release];
    [loadmorelb release];
    [namelb release];
    [placelb release];
    [profileimgview release];
    [tokennumlb release];
    [sweepnumlb release];
    [fblbl release];
    [twilbl release];
    [googlelbl release];
    [pushlbl release];
    
    [creditslb release];
    [loadmoreimgview release];
    [fbbtn release];
    [twitterbtn release];
    [googlebtn release];
    [pushnotibtn release];
    [scrollview release];
    [socialback release];
   
    [scview release];
    [_backbtn release];
    [refrallb release];
    [my_sweepImg release];
    [my_entriesImg release];
    [_my_entriesImg release];
    [_my_sweepImg release];
    [super dealloc];
}
- (IBAction)goback:(id)sender {
    // Display Slide Menu View
    [DELEGATE.menuController showLeftController:YES];
    CGRect frame = _backbtn.frame;
    frame.size.width = 41;
    _backbtn.frame = frame;
    [_backbtn setImage:[UIImage imageNamed:@"menu_open.png"] forState:UIControlStateNormal];
    //[_menuController showLeftController:YES];
  //  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)fbonoff:(id)sender {
   
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open]; 
    
        
    if (fbbtn.tag == 0) 
    {
        BOOL success = [db executeUpdate:@"UPDATE setting SET facebook='YES' where isettingid=1"];
        
        if (!success)
        {
            NSLog(@"update failed facebook!!");
        }
        else 
        {
            NSLog(@"successfully updated facebook");
            [fbbtn setBackgroundImage:[UIImage imageNamed:@"onbtn.png"] forState:UIControlStateNormal];
            NSDictionary *args = [[NSDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userid,@"ON", nil] forKeys:[NSArray arrayWithObjects:@"userid",@"status", nil]]];
            [Apsalar event:@"Facebook Button" withArgs:args];
            fbbtn.tag =1;
        }
    }
    else 
    {
        BOOL success = [db executeUpdate:@"UPDATE setting SET facebook='NO' where isettingid=1"];
        
        if (!success)
        {
            NSLog(@"update failed facebook!!");
        }
        else 
        {
            NSLog(@"successfully updated facebook");
            NSDictionary *args = [[NSDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userid,@"OFF", nil] forKeys:[NSArray arrayWithObjects:@"userid",@"status", nil]]];
            [Apsalar event:@"Facebook Button" withArgs:args];
            [fbbtn setBackgroundImage:[UIImage imageNamed:@"offbtn.png"] forState:UIControlStateNormal];
            fbbtn.tag = 0;
            fbbtn.userInteractionEnabled = NO;
            fbGraph.accessToken = nil;
            NSHTTPCookie *cookie;
            NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            for (cookie in [storage cookies])
            {
                NSString* domainName = [cookie domain];
                NSRange domainRange = [domainName rangeOfString:@"facebook"];
                if(domainRange.length > 0)
                {
                    [storage deleteCookie:cookie];
                }
            }


        }
       
    }
    NSLog(@" update Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    [db close];
}

- (IBAction)tweetonoff:(id)sender {
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open]; 

    if (twitterbtn.tag == 0)
    {
        
        BOOL success = [db executeUpdate:@"UPDATE setting SET twitter='YES' where isettingid=1"];
        
        if (!success)
        {
            NSLog(@"update failed twitter!!");
        }
        else 
        {
            NSLog(@"successfully updated twiiter");
        [twitterbtn setBackgroundImage:[UIImage imageNamed:@"onbtn.png"] forState:UIControlStateNormal];
        twitterbtn.tag =1;
            NSDictionary *args = [[NSDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userid,@"ON", nil] forKeys:[NSArray arrayWithObjects:@"userid",@"status", nil]]];
            [Apsalar event:@"Twitter Button" withArgs:args];
        }
        
    }else 
    {
        BOOL success = [db executeUpdate:@"UPDATE setting SET twitter='NO' where isettingid=1"];
        
        if (!success)
        {
            NSLog(@"update failed twitter!!");
        }
        else 
        {
            NSLog(@"successfully updated twiiter");
        
        [twitterbtn setBackgroundImage:[UIImage imageNamed:@"offbtn.png"] forState:UIControlStateNormal];
        twitterbtn.tag = 0;
            NSDictionary *args = [[NSDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userid,@"OFF", nil] forKeys:[NSArray arrayWithObjects:@"userid",@"status", nil]]];
            [Apsalar event:@"Twitter Button" withArgs:args];
            twitterbtn.userInteractionEnabled = NO;
            [SCTwitter logoutCallback:^(BOOL success)
             {
                 if (success) {
                     NSLog(@"logout success");
                    NSString *APIDomain = @"twitter.com";
                     NSString *urlString = [NSString stringWithFormat:@"%@://%@", 
                                            (YES) ? @"https" : @"http", 
                                            APIDomain];
                     NSURL *url = [NSURL URLWithString:urlString];

                     NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                     NSEnumerator *enumerator = [[cookieStorage cookiesForURL:url] objectEnumerator];
                     NSHTTPCookie *cookie = nil;
                     while (cookie = [enumerator nextObject]) {
                         [cookieStorage deleteCookie:cookie];
                     }

                     
                 } 
                 else {
                      NSLog(@"logout Unsuccess");
                 }
             }];
        }
    }
    
     NSLog(@" update Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    [db close];
}

- (IBAction)goggleonoff:(id)sender {
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open]; 
    
    if (googlebtn.tag == 0) {
        BOOL success = [db executeUpdate:@"UPDATE setting SET google='YES' where isettingid=1"];
        
        if (!success)
        {
            NSLog(@"update failed google!!");
        }
        else 
        {
            NSLog(@"successfully updated google");
        [googlebtn setBackgroundImage:[UIImage imageNamed:@"onbtn.png"] forState:UIControlStateNormal];
        googlebtn.tag =1;
            NSDictionary *args = [[NSDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userid,@"ON", nil] forKeys:[NSArray arrayWithObjects:@"userid",@"status", nil]]];
            [Apsalar event:@"Google Button" withArgs:args];
        }
        
    }else 
    {
        BOOL success = [db executeUpdate:@"UPDATE setting SET google='NO' where isettingid=1"];
        
        if (!success)
        {
            NSLog(@"update failed google!!");
        }
        else 
        {
            NSLog(@"successfully updated google");
                       [googlebtn setBackgroundImage:[UIImage imageNamed:@"offbtn.png"] forState:UIControlStateNormal];
            googlebtn.tag = 0;
            NSDictionary *args = [[NSDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userid,@"OFF", nil] forKeys:[NSArray arrayWithObjects:@"userid",@"status", nil]]];
            [Apsalar event:@"Google Button" withArgs:args];
        }
    }
    NSLog(@" update Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    [db close];

}


- (IBAction)pushonoff:(id)sender {
  
    if (pushnotibtn.tag == 0) 
    {
        
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Push!" message:@"Do you want to enable push notification?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
        [al show];
        [al release];

    }
    else 
    {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Push!" message:@"Do you want to disable push notification?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
        [al show];
        [al release];
            }
    }
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
    if ([[alertView title] isEqualToString:@"User Does Not Exists"])
	{ 
        LoginViewController *gotorootview = [[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil]autorelease];
        [self.navigationController pushViewController:gotorootview animated:YES];
	}

    if ([[alertView title] isEqualToString:@"Push!"])
    { 
        if (buttonIndex == 0) {
            
        
        if(pushnotibtn.tag ==0 )
        {
         
            
                [mc pushonoff:userid push:@"Y" selector:@selector(pushres:)];
            
          
        }
        else 
        {
                [mc pushonoff:userid push:@"N" selector:@selector(pushres:)];
            
           
        }
      
    }
    }

    if ([[alertView title] isEqualToString:@"Profile Photo"]){
        
        
        UIImagePickerController *UIPicker;
        UIPicker = [[UIImagePickerController alloc] init];
        UIPicker.allowsEditing = YES;
        UIPicker.delegate = self;
        
        if(buttonIndex == 1){
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentModalViewController:UIPicker animated:YES];
                
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sweepstakes"
                                                                message:@"Your device has not camera facility available."
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
            }

        }
        else if(buttonIndex == 2){
            UIPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentModalViewController:UIPicker animated:YES];

        }
        

    }

}
-(void)pushres:(NSDictionary *)results{
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
  
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];   
    if ([result isEqualToString:@"true"]) 
    {
       
        if(pushnotibtn.tag ==0 )
        {
            
            BOOL success = [db executeUpdate:@"UPDATE setting SET pushnoti='YES' where isettingid=1"];
            
            if (!success)
            {
                NSLog(@"update failed push!!");
            }
            else 
            {
                NSLog(@"successfully updated push");
                [pushnotibtn setBackgroundImage:[UIImage imageNamed:@"onbtn.png"] forState:UIControlStateNormal];
                pushnotibtn.tag =1;
                NSDictionary *args = [[NSDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userid,@"ON", nil] forKeys:[NSArray arrayWithObjects:@"userid",@"status", nil]]];
                [Apsalar event:@"Push Notification Button" withArgs:args];
            }

        }
        else {
            
            BOOL success = [db executeUpdate:@"UPDATE setting SET pushnoti='NO' where isettingid=1"];
            
            if (!success)
            {
                NSLog(@"update failed push!!");
            }
            else 
            {
                NSLog(@"successfully updated push");
                [pushnotibtn setBackgroundImage:[UIImage imageNamed:@"offbtn.png"] forState:UIControlStateNormal];
                pushnotibtn.tag = 0;
                NSDictionary *args = [[NSDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userid,@"OFF", nil] forKeys:[NSArray arrayWithObjects:@"userid",@"status", nil]]];
                [Apsalar event:@"Push Notification Button" withArgs:args];
            }
        }
        NSLog(@" update Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        [db close];
    }
    else if([[results valueForKey:@"message"]isEqualToString:@"User Does Not Exists"]){
        
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
//        creditslb.text = @"0"; 
//        CGSize textSize = [creditslb.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
//        x= textSize.width;
//        CGRect frame = CGRectMake(268-x,5,10,20);
//        plus.frame = frame;
//        CGRect frame1 = CGRectMake(277,13,40,20);
//        credit.frame = frame1;
    }
    
    else {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:[results valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
        
    }
    
  

    
    
    
}

@end
