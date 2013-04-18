//
//  WinnerlistViewController.m
//  Sweepstakes
//
//  Created by Peerbits Solution on 05/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "WinnerlistViewController.h"

@interface WinnerlistViewController ()

@end

@implementation WinnerlistViewController
@synthesize creditlb,userid;
int i;
float x;

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
    images = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"bluep.png"],[UIImage imageNamed:@"greenp.png"],[UIImage imageNamed:@"yellowp.png"],[UIImage imageNamed:@"violetp.png"],[UIImage imageNamed:@"lightyellowp.png"],[UIImage imageNamed:@"pinkp.png"],nil];
    [thiswkbtn setBackgroundImage:[UIImage imageNamed:@"weekpress.png"] forState:UIControlStateNormal];
    [lastwkbtn setBackgroundImage:[UIImage imageNamed:@"lastweek.png"] forState:UIControlStateNormal];
    [custwkbtn setBackgroundImage:[UIImage imageNamed:@"custdate.png"] forState:UIControlStateNormal];
    thiswkbtn.userInteractionEnabled = NO;
    winnerstableview.tag = 1;
    mc = [[ModelClass alloc]init];
    [mc setDelegate:self];
     DELEGATE.menuController.delegate = self;
//   _menuController = [[DDMenuController alloc] initWithRootViewController:self.navigationController];
//    [_menuController setDelegate:self];
//    MenuViewController *leftController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
//    _menuController.leftViewController = leftController;
//    
//    
//    //  DELEGATE.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    DELEGATE.window.rootViewController = _menuController;
//    [DELEGATE.window makeKeyAndVisible];
    if (DELEGATE.isHostAvailable) {
       
        [mc getwinnerlist:userid selector:@selector(winnerlistresponse:)];
        NSDictionary *args = [[NSDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userid, nil] forKeys:[NSArray arrayWithObjects:@"userid", nil]]];
        [Apsalar event:@"Winner List" withArgs:args];
    }else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }


    
    // Do any additional setup after loading the view from its nib.
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer];
    [recognizer addTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer release];
}

- (void)viewWillAppear:(BOOL)animated {
    DELEGATE.nCurrentListItem = CURRENT_LIST_ITEM_WINNERS_LIST;
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
-(void)menuController:(DDMenuController *)controller willShowViewController:(UIViewController *)controllerr{
    
    if (controllerr == controller.leftViewController) {
        [_backbtn setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    }
    
    
}

/*
-(void)viewDidAppear:(BOOL)animated{
        
    creditlb.font = [UIFont fontWithName:@"Calibri-BoldItalic" size:18];
    
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results=[db executeQuery:@"SELECT * FROM login_master where rowid=1"];
    while ([results next]) 
    {
        
         
       creditlb.text = [NSString stringWithFormat:@"%@",[results stringForColumn:@"credits"]];
       
        
    }
    [db close];
    CGSize textSize = [creditlb.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
    x= textSize.width;
    plus = [[UILabel alloc]initWithFrame:CGRectMake(268-x,5,10,20)];
    [plus setTextColor:[UIColor colorWithRed:28.0/255.0 green:107.0/255.0 blue:130.0/255.0 alpha:1.0]];
    [plus setBackgroundColor:[UIColor clearColor]];
    plus.textAlignment = UITextAlignmentRight;
    plus.font=[UIFont fontWithName:@"Calibri-BoldItalic" size:12];
    plus.text = @"+";
    [self.view addSubview:plus];
    [plus release];

        
        credit = [[UILabel alloc]initWithFrame:CGRectMake(277,13,40,20)];
        [credit setTextColor:[UIColor colorWithRed:28.0/255.0 green:107.0/255.0 blue:130.0/255.0 alpha:1.0]];
        [credit setBackgroundColor:[UIColor clearColor]];
        credit.textAlignment = UITextAlignmentLeft;
        credit.font=[UIFont fontWithName:@"Calibri-BoldItalic" size:11];
        credit.text = @"Tickets";
        [self.view addSubview:credit];
        [credit release];
}
*/
-(void)winnerlistresponse:(NSDictionary *)results{
  
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
 //   NSLog(@"--->%@",result);
    
    if([result isEqualToString:@"true"]){
        lastmonthcount = [[NSString alloc]initWithFormat:@"%@",[results valueForKey:@"lastmonthcount"]];
        lastweekcount= [[NSString alloc]initWithFormat:@"%@",[results valueForKey:@"lastweekcount"]];;
        thisweekcount= [[NSString alloc]initWithFormat:@"%@",[results valueForKey:@"thisweekcount"]];
        
    
    if ([lastmonthcount intValue]>0) 
    {
        
        lmnamearray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"lastmonth"]valueForKey:@"name"]];
        lmprizearray =[[NSMutableArray alloc]initWithArray:[[results valueForKey:@"lastmonth"]valueForKey:@"prize"]];
        lmtimearray =[[NSMutableArray alloc]initWithArray:[[results valueForKey:@"lastmonth"]valueForKey:@"time"]];
        lmtitlearray =[[NSMutableArray alloc]initWithArray:[[results valueForKey:@"lastmonth"]valueForKey:@"title"]]; 
    }
    if ([lastweekcount intValue]>0) {
        
        lwnamearray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"lastweek"]valueForKey:@"name"]];
        lwprizearray =[[NSMutableArray alloc]initWithArray:[[results valueForKey:@"lastweek"]valueForKey:@"prize"]];
        lwtimearray =[[NSMutableArray alloc]initWithArray:[[results valueForKey:@"lastweek"]valueForKey:@"time"]];
        lwtitlearray =[[NSMutableArray alloc]initWithArray:[[results valueForKey:@"lastweek"]valueForKey:@"title"]]; 
    }
    if ([thisweekcount intValue]>0) {
        twnamearray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"thisweek"]valueForKey:@"name"]];
        twprizearray =[[NSMutableArray alloc]initWithArray:[[results valueForKey:@"thisweek"]valueForKey:@"prize"]];
        twtimearray =[[NSMutableArray alloc]initWithArray:[[results valueForKey:@"thisweek"]valueForKey:@"time"]];
        twtitlearray =[[NSMutableArray alloc]initWithArray:[[results valueForKey:@"thisweek"]valueForKey:@"title"]]; 
    }
    }else if([[results valueForKey:@"message"]isEqualToString:@"User Does Not Exists"]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:[results valueForKey:@"message"] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open];
        dc = [[LLDataControll alloc]init];
        [dc deleteData];
        BOOL d= [db executeUpdate:@ "Delete from login_master"];
        if (!d)
        {
            NSLog(@"delete failed login_master!!");
        }
        else {
            NSLog(@"successfully delete login_master");
            
        }
        
        NSLog(@"Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        /*
        creditlb.text = @"0";
        CGSize textSize = [creditlb.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
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

    
    [winnerstableview reloadData];

}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    if (winnerstableview.tag == 1) {
        return [twnamearray count];
    }
    else if(winnerstableview.tag == 2) {
        return [lwnamearray count];
    }
    else {
        return [lmnamearray count];
    }
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
   
    UIView *uview=[[UIView alloc]initWithFrame:CGRectMake(6,2,309,69)];
    uview.layer.masksToBounds=YES;
    
    
    
    UIImageView *cellbackgrond =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,309,69)]; 
    cellbackgrond.image=[[UIImage alloc]init];
    cellbackgrond.image = [UIImage imageNamed:@"cellback.png"];
    [uview addSubview:cellbackgrond];
    [cellbackgrond release];
    if (indexPath.row<[images count]) {
        
    UIImageView *color =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,9,65)]; 
    color.image=[[UIImage alloc]init];
    color.image = [images objectAtIndex:indexPath.row];
    [uview addSubview:color];
    [color release];
    }
    
    else if (indexPath.row >=[images count]){
        
        i= indexPath.row;
        while (i>=[images count]) {
            i=i-[images count];
        }
        UIImageView *color =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,9,65)]; 
        color.image=[[UIImage alloc]init];
        color.image = [images objectAtIndex:i];
        [uview addSubview:color];
        [color release];
        
    } 
    
    UILabel *mainlb = [[UILabel alloc]initWithFrame:CGRectMake(20,7,265,22)];
    [mainlb setTextColor:[UIColor colorWithRed:73.0/255.0 green:73.0/255.0 blue:73.0/255.0 alpha:1.0]];
    [mainlb setBackgroundColor:[UIColor clearColor]];
    mainlb.textAlignment = UITextAlignmentLeft;
    mainlb.font=[UIFont fontWithName:@"Calibri-BoldItalic" size:17];
    
    UILabel *detaillb = [[UILabel alloc]initWithFrame:CGRectMake(20,25,240,25)];
    [detaillb setTextColor:[UIColor colorWithRed:176.0/255.0 green:176.0/255.0 blue:176.0/255.0 alpha:1.0]];
    [detaillb setBackgroundColor:[UIColor clearColor]];
    detaillb.textAlignment = UITextAlignmentLeft;
    detaillb.font=[UIFont fontWithName:@"Calibri" size:15];
    
    UILabel *detaillb2 = [[UILabel alloc]initWithFrame:CGRectMake(20,40,240,25)];
    [detaillb2 setTextColor:[UIColor colorWithRed:176.0/255.0 green:176.0/255.0 blue:176.0/255.0 alpha:1.0]];
    [detaillb2 setBackgroundColor:[UIColor clearColor]];
    detaillb2.textAlignment = UITextAlignmentLeft;
    detaillb2.font=[UIFont fontWithName:@"Calibri" size:15];
    
    if (winnerstableview.tag == 1) {
        mainlb.text = [NSString stringWithFormat:@"$%@ %@",[twprizearray objectAtIndex:indexPath.row],[twtitlearray objectAtIndex:indexPath.row]];
        detaillb.text =[NSString stringWithFormat:@" Ends: %@",[twtimearray objectAtIndex:indexPath.row]];
        detaillb2.text = [NSString stringWithFormat:@" Winner: %@",[twnamearray objectAtIndex:indexPath.row]];
        
    }
    else if (winnerstableview.tag == 2){
        
        mainlb.text = [NSString stringWithFormat:@"$%@ %@",[lwprizearray objectAtIndex:indexPath.row],[lwtitlearray objectAtIndex:indexPath.row]];
        detaillb.text =[NSString stringWithFormat:@" Ends: %@",[lwtimearray objectAtIndex:indexPath.row]];
        detaillb2.text = [NSString stringWithFormat:@" Winner: %@",[lwnamearray objectAtIndex:indexPath.row]];
    }
    else {
        mainlb.text = [NSString stringWithFormat:@"$%@ %@",[lmprizearray objectAtIndex:indexPath.row],[lmtitlearray objectAtIndex:indexPath.row]];
        detaillb.text =[NSString stringWithFormat:@" Ends: %@",[lmtimearray objectAtIndex:indexPath.row]];
        detaillb2.text = [NSString stringWithFormat:@" Winner: %@",[lmnamearray objectAtIndex:indexPath.row]];
        
    }
   
    
    [uview addSubview:mainlb];
    [mainlb release];
    [uview addSubview:detaillb];
    [detaillb release];
    [uview addSubview:detaillb2];
    [detaillb2 release];
    
    [cell addSubview:uview];
    [uview release];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{   
    [winnerstableview deselectRowAtIndexPath:indexPath animated:YES];
    
    
}



- (void)viewDidUnload
{
    [winnerstableview release];
    winnerstableview = nil;
    [thiswkbtn release];
    thiswkbtn = nil;
    [lastwkbtn release];
    lastwkbtn = nil;
    [custwkbtn release];
    custwkbtn = nil;
   
    [self setCreditlb:nil];
    [self setBackbtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [winnerstableview release];
    [thiswkbtn release];
    [lastwkbtn release];
    [custwkbtn release];
    [creditlb release];
    [_backbtn release];
    [super dealloc];
}
- (IBAction)thisweekpress:(id)sender {
    [thiswkbtn setBackgroundImage:[UIImage imageNamed:@"weekpress.png"] forState:UIControlStateNormal];
    [lastwkbtn setBackgroundImage:[UIImage imageNamed:@"lastweek.png"] forState:UIControlStateNormal];
    [custwkbtn setBackgroundImage:[UIImage imageNamed:@"custdate.png"] forState:UIControlStateNormal];
    thiswkbtn.userInteractionEnabled = NO;
    lastwkbtn.userInteractionEnabled = YES;
    custwkbtn.userInteractionEnabled = YES;
    winnerstableview.tag = 1;
    [winnerstableview reloadData];

}

- (IBAction)lastweekpress:(id)sender {
    [thiswkbtn setBackgroundImage:[UIImage imageNamed:@"week.png"] forState:UIControlStateNormal];
    [lastwkbtn setBackgroundImage:[UIImage imageNamed:@"lastweekpress.png"] forState:UIControlStateNormal];
    [custwkbtn setBackgroundImage:[UIImage imageNamed:@"custdate.png"] forState:UIControlStateNormal];
    thiswkbtn.userInteractionEnabled = YES;
    lastwkbtn.userInteractionEnabled = NO;
    custwkbtn.userInteractionEnabled = YES;
    winnerstableview.tag = 2;
    [winnerstableview reloadData];
    
    
}

- (IBAction)customweekpress:(id)sender {
    [thiswkbtn setBackgroundImage:[UIImage imageNamed:@"week.png"] forState:UIControlStateNormal];
    [lastwkbtn setBackgroundImage:[UIImage imageNamed:@"lastweek.png"] forState:UIControlStateNormal];
    [custwkbtn setBackgroundImage:[UIImage imageNamed:@"cusdatepress.png"] forState:UIControlStateNormal];
    thiswkbtn.userInteractionEnabled = YES;
    lastwkbtn.userInteractionEnabled = YES;
    custwkbtn.userInteractionEnabled = NO;
    winnerstableview.tag = 3;
    [winnerstableview reloadData];
    
    
}

- (IBAction)goback:(id)sender {
    // Display Slide Menu View
    
    CGRect frame = _backbtn.frame;
    frame.size.width = 41;
    _backbtn.frame = frame;

    [_backbtn setImage:[UIImage imageNamed:@"menu_open.png"] forState:UIControlStateNormal];
    [DELEGATE.menuController showLeftController:YES];
    // [self.navigationController popViewControllerAnimated:YES];
}
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
    if ([[alertView title] isEqualToString:@"User Does Not Exists"])
	{ 
      //  ViewController *gotorootview = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
       // [self.navigationController pushViewController:gotorootview animated:YES];
       // [self.navigationController popToRootViewControllerAnimated:YES];
        LoginViewController *gotorootview = [[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil]autorelease];
        [self.navigationController pushViewController:gotorootview animated:YES];
        
	}
}    

@end
