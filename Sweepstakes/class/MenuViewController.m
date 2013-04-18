//
//  MenuViewController.m
//  Sweepstakes
//
//  Created by macmini3 on 19/02/13.
//  Copyright (c) 2013 peerbits@gmail.com. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

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
     dc= [[LLDataControll alloc] init];
   _namelbl.font = [UIFont fontWithName:@"Calibri-BoldItalic" size:18];
    _entrilbl.font = [UIFont fontWithName:@"Calibri-Italic" size:17];
   _sweeplbl.font = [UIFont fontWithName:@"Calibri-Bold" size:19];
    _winnerlbl.font = [UIFont fontWithName:@"Calibri-Bold" size:19];
    _howlbl.font = [UIFont fontWithName:@"Calibri-Bold" size:19];
     _myprofilelbl.font = [UIFont fontWithName:@"Calibri-Bold" size:19];
    mc = [[ModelClass alloc]init];
    [mc setDelegate:self];
    if (DELEGATE.isHostAvailable)
    {
        NSLog(@"THE USER ID TO BE PASSED is --> %@", [[dc getData]objectAtIndex:0]);
        [mc menuuserdetail:[[dc getData]objectAtIndex:0] selector:@selector(menures:)];
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }

    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection: UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:recognizer];
    [recognizer addTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer release];

    // Do any additional setup after loading the view from its nib.
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    if(DELEGATE.nCurrentListItem == CURRENT_LIST_ITEM_SWEEP_STAKES_LIST){
        [self gosweeps:nil];
    }
    if(DELEGATE.nCurrentListItem == CURRENT_LIST_ITEM_HOW_IT_WORKS){
        [self gohowworks:nil];
    }
    if(DELEGATE.nCurrentListItem == CURRENT_LIST_ITEM_MY_PROFILE){
        [self gomyprofile:nil];
    }
    if(DELEGATE.nCurrentListItem == CURRENT_LIST_ITEM_WINNERS_LIST){
        [self gowinnerlist:nil];
    }
    if(DELEGATE.nCurrentListItem == CURRENT_LIST_ITEM_SWEEP_STAKES_DETAIL){
        [DELEGATE.menuController showRootController:YES];
    }


}

-(void)viewWillAppear:(BOOL)animated{
    
    
    NSString *imageName = [NSString stringWithFormat:@"profilepic.png"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    
    if ([fileManager fileExistsAtPath:fullPathToFile]) {
        
        UIImage * noImageImage;// = [UIImage imageNamed: @"noimg.png"];
        noImageImage = [self imageWithImage:[UIImage imageNamed: @"noimg.png"] scaledToSize:CGSizeMake(40, 45)];
        //UIImageView *noImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,20,40,45)];
        UIImageView *noImageView = [UIImageView alloc];
        
        //noImageView.contentMode = UIViewContentModeScaleAspectFit;
        noImageView = [[UIImageView alloc] initWithImage: [UIImage imageWithContentsOfFile:fullPathToFile]];
        noImageView.layer.cornerRadius = 5.0;
        [self.view addSubview:noImageView];
        noImageView.frame = CGRectMake(5, 10, 45, 50);
        
        
    }
    
    
    
    if(DELEGATE.applied == YES){
        DELEGATE.applied = NO;
        // User Detail in Menu View
        if (DELEGATE.isHostAvailable)
        {
            
            [mc menuuserdetail:[[dc getData]objectAtIndex:0] selector:@selector(menures:)];
            
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }

    
    }
}
-(void)menures:(NSDictionary *)results{
    //NSLog(@"MENU RESPONSE function is called");
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
    //_namelbl.text = @"API FAILED";
    if([result isEqualToString:@"true"]){
    
        _namelbl.text = [NSString stringWithFormat:@"%@ %@",[[results valueForKey:@"User"]valueForKey:@"firstname"],[[results valueForKey:@"User"]valueForKey:@"lastname"]];
        
        
        if ([[[results valueForKey:@"User"]valueForKey:@"entrycount"]intValue]>1) {
            _entrilbl.text = [NSString stringWithFormat:@"%@ Entries",[[results valueForKey:@"User"]valueForKey:@"entrycount"]];
        }else{
        _entrilbl.text = [NSString stringWithFormat:@"%@ Entry",[[results valueForKey:@"User"]valueForKey:@"entrycount"]];
        }
        
        
        NSString *imageName = [NSString stringWithFormat:@"profilepic.png"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
     
        if ([fileManager fileExistsAtPath:fullPathToFile]) {
        
            UIImage * noImageImage;// = [UIImage imageNamed: @"noimg.png"];
            noImageImage = [self imageWithImage:[UIImage imageNamed: @"noimg.png"] scaledToSize:CGSizeMake(40, 45)];
            //UIImageView *noImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,20,40,45)];
            UIImageView *noImageView = [UIImageView alloc];
            
            //noImageView.contentMode = UIViewContentModeScaleAspectFit;
            noImageView = [[UIImageView alloc] initWithImage: [UIImage imageWithContentsOfFile:fullPathToFile]];
            [self.view addSubview:noImageView];
            noImageView.frame = CGRectMake(10, 10, 40, 45);
            
            
        }
        else{
            if (![[[results valueForKey:@"User"]valueForKey:@"image"]isEqualToString:@""]) {
                DTLazyImageView  *lazyImageView = [[DTLazyImageView alloc] initWithFrame:CGRectMake(5,10,45,50)];
                lazyImageView.delegate = self;
                lazyImageView.tag = 0;
                lazyImageView.layer.masksToBounds=YES;
                lazyImageView.layer.cornerRadius = 5.0;
                lazyImageView.contentMode = UIViewContentModeScaleAspectFill;
                //NSLog(@"IMAGE DATA IS ---> %@", [[results valueForKey:@"User"] valueForKey:@"image"]);
                lazyImageView.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[results valueForKey:@"User"] valueForKey:@"image"]]];
                [self.view addSubview:lazyImageView];
                
                if (! lazyImageView.image) {
                    [lazyImageView startLoading];
                    lazyImageView.actv.hidden = YES;
                }
                
            }
            else{
                //When no image is obtained from the server, the No Image available image should be displayed
                UIImage * noImageImage;// = [UIImage imageNamed: @"noimg.png"];
                noImageImage = [self imageWithImage:[UIImage imageNamed: @"noimg.png"] scaledToSize:CGSizeMake(40, 45)];
                //UIImageView *noImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,20,40,45)];
                UIImageView *noImageView = [UIImageView alloc];
                
                //noImageView.contentMode = UIViewContentModeScaleAspectFit;
                noImageView = [[UIImageView alloc] initWithImage: noImageImage];
                [self.view addSubview:noImageView];
                noImageView.frame = CGRectMake(10, 10, 40, 45);
            }
        }
        
    
    }

}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)imageDidLoad:(DTLazyImageView *)lazyImageView{

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_namelbl release];
    [_entrilbl release];
    [_sweeplbl release];
    [_winnerlbl release];
    [_myprofilelbl release];
    [_howlbl release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setNamelbl:nil];
    [self setEntrilbl:nil];
    [self setSweeplbl:nil];
    [self setWinnerlbl:nil];
    [self setMyprofilelbl:nil];
    [self setHowlbl:nil];
    
    [super viewDidUnload];
}
- (IBAction)gosweeps:(id)sender {
 
    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    SweepListViewController *gotosweeplist = [[[SweepListViewController alloc]initWithNibName:@"SweepListViewController" bundle:nil]autorelease];
        gotosweeplist.usrid = [[dc getData]objectAtIndex:0];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:gotosweeplist];
    navController.navigationBar.hidden = YES;
    [menuController setRootController:navController animated:YES];
   

    
}

- (IBAction)gowinnerlist:(id)sender {
       
    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    WinnerlistViewController *gotowinner = [[[WinnerlistViewController alloc]initWithNibName:@"WinnerlistViewController" bundle:nil]autorelease];
    gotowinner.userid = [[dc getData]objectAtIndex:0];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:gotowinner];
    navController.navigationBar.hidden = YES;
    [menuController setRootController:navController animated:YES];
    
}

- (IBAction)gomyprofile:(id)sender {

    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
     MyprofileViewController *gotoprofile = [[[MyprofileViewController alloc]initWithNibName:@"MyprofileViewController" bundle:nil]autorelease];
        gotoprofile.userid = [[dc getData]objectAtIndex:0];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:gotoprofile];
    navController.navigationBar.hidden = YES;
    [menuController setRootController:navController animated:YES];
    
}

- (IBAction)gohowworks:(id)sender {

    NSDictionary *args = [[NSDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[[dc getData]objectAtIndex:0]], nil] forKeys:[NSArray arrayWithObjects:@"userid", nil]]];
    [Apsalar event:@"How It Works" withArgs:args];
    
    
    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    HowworksViewController *goworks = [[[HowworksViewController alloc]initWithNibName:@"HowworksViewController" bundle:nil]autorelease];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:goworks];
    navController.navigationBar.hidden = YES;
    [menuController setRootController:navController animated:YES];
    
}
@end
