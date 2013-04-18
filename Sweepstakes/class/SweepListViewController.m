//
//  SweepListViewController.m
//  Sweepstakes
//
//  Created by Peerbits Solution on 05/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "SweepListViewController.h"
#define IS_IPHONE_5 ( [ [ UIScreen mainScreen ] bounds ].size.height == 568 )
#import "DDMenuController.h"
#import "MenuViewController.h"
@interface SweepListViewController ()

@end

@implementation SweepListViewController

@synthesize creditlb;
@synthesize sortfilterlbl;
@synthesize view2;
@synthesize categorieslb;
@synthesize sortbylb;
@synthesize sweeplb;
@synthesize scrollview,usrid;
float x;
int i;
int j;
bool sortby;
bool sortbyprice;



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
    sweeplb.font = [UIFont fontWithName:@"Calibri-Italic" size:18];
    sortbylb.font = [UIFont fontWithName:@"Calibri-BoldItalic" size:16];
    categorieslb.font = [UIFont fontWithName:@"Calibri-BoldItalic" size:16];
    sortfilterlbl.tag = 1;
    giftcardbtn.tag =1;
    travelbtn.tag = 1;
    ticketbtn.tag =1;
    cashbtn.tag = 1;
    shoppingbtn.tag = 1;
    eventbtn.tag = 1;
    sortby = NO;
    sortbyprice = NO;
    credit.hidden = YES;
    plus.hidden = YES;
    catidstrarr = [[NSMutableArray alloc]init];
    dc = [[LLDataControll alloc]init];
    if( IS_IPHONE_5 )
    {
        [view2 setFrame:CGRectMake(0, 0, 320, 510)];
    }
     //UITapGestureRecognizer *Tapsweepstake = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tapsweepstack)] autorelease];
    //[sortfilterlbl addGestureRecognizer:Tapsweepstake];
        
    // NSMutableArray * viewControllers = [self.navigationController.viewControllers mutableCopy ];
   
  //  UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:[viewControllers objectAtIndex:0]];
  //  [navController setViewControllers:viewControllers];
  //  navController.navigationBarHidden = YES;
    
//    _menuController = [[DDMenuController alloc] initWithRootViewController:self.navigationController];
//    [_menuController setDelegate:self];
//    MenuViewController *leftController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
//    _menuController.leftViewController = leftController;
//    
//    
//  //  DELEGATE.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    DELEGATE.window.rootViewController = _menuController;
//    [DELEGATE.window makeKeyAndVisible];
    
    if (DELEGATE.isHostAvailable) {
        
        [mc getsweeplist:usrid selector:@selector(sweeplistresponse:)];
         //[mc getsweeplist:@"3463634" selector:@selector(sweeplistresponse:)];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Failed to connect to internet. Check internet connection!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    DELEGATE.menuController.delegate = self;
    // Do any additional setup after loading the view from its nib.
    
    
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer];
    [recognizer addTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer release];
}

- (void)viewWillAppear:(BOOL)animated {
    DELEGATE.nCurrentListItem = CURRENT_LIST_ITEM_SWEEP_STAKES_LIST;
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
        NSLog(@"Swipe received.");
    }
    
}
-(void)menuController:(DDMenuController *)controller willShowViewController:(UIViewController *)controllerr{
    
    if (controllerr == controller.leftViewController) {
        [_backbtn setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    }
    
    
}

-(void)sweeplistresponse:(NSDictionary *)results{
   // NSLog(@"%@",results);
    NSString *result = [NSString stringWithFormat:@"%@",[results valueForKey:@"successfull"]];
  
    
    if([result isEqualToString:@"true"])
    {
    imagearry = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"Sweepstakes"]valueForKey:@"image"]];
    titlenamearray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"Sweepstakes"]valueForKey:@"title"]];
    sweepidarray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"Sweepstakes"]valueForKey:@"sweepstakesid"]];
    productprizearray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"Sweepstakes"]valueForKey:@"product_prize"]];
    timearray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"Sweepstakes"]valueForKey:@"remainingtime"]];
    timestamparray = [[NSMutableArray alloc]initWithArray:[[results valueForKey:@"Sweepstakes"]valueForKey:@"time_stamp"]];
       catidarray = [[NSMutableArray alloc]initWithArray:[[[results valueForKey:@"Sweepstakes"]valueForKey:@"category"]valueForKey:@"category_id"]];     
        sweeplb.text = [NSString stringWithFormat:@"-- %d Sweepstakes --",[imagearry count]];
      //  [self Setthewholeview];
        [self filldatabase];
        
     
        
        
        NSMutableDictionary *counteDict;
        
        
        NSString *imageName = [NSString stringWithFormat:@"myPlistFile.plist"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
        //  NSLog(@"pathToFile-->%@",fullPathToFile);
        if ([fileManager fileExistsAtPath:fullPathToFile]) {
            
            NSLog(@"exist");
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask, YES);
            counteDict=[[NSMutableDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithContentsOfFile:[[paths objectAtIndex:0]stringByAppendingPathComponent:@"myPlistFile.plist"]]];
            
            for (NSString *sweepid in sweepidarray) {
                
                if (![[[DELEGATE cardCounter]allKeys] containsObject:sweepid]) {
                    
                    [counteDict setValue:[NSNumber numberWithInt:0] forKey:sweepid];
                    
                }
            }
            
        }
        else{
            NSLog(@"newone");
            counteDict=[[NSMutableDictionary alloc]init];
            
            for (NSString *sweepid in sweepidarray) {
                
                if (![[[DELEGATE cardCounter]allKeys] containsObject:sweepid]) {
                    
                    [counteDict setValue:[NSNumber numberWithInt:0] forKey:sweepid];
                    
                }
            }

            [counteDict writeToFile:fullPathToFile atomically:YES];
        }
        
        {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
            NSLog(@"---->plist-->%@",[[NSMutableDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithContentsOfFile:[[paths objectAtIndex:0]stringByAppendingPathComponent:@"myPlistFile.plist"]]]);
      
        }
        
        [DELEGATE setCardCounter:counteDict];
       
        // NSLog(@"%@",DELEGATE.cardCounter);
//        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self
//                                               selector:@selector(reload)
//                                               userInfo:nil
//                                                repeats:YES];

        [listingtable reloadData];
    }
    else if([[results valueForKey:@"message"]isEqualToString:@"User Does Not Exists"])
    {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:[results valueForKey:@"message"] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
        [dc deleteData];
        
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

    
}
-(void)reload{
    for (int i =0 ; i<[timestamparray count]; i++) {
        [timestamparray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d", [[timestamparray objectAtIndex:i]intValue]-1]];
    }
    [listingtable reloadData];
    
}
-(void)filldatabase{
    
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    
    BOOL d= [db executeUpdate:@ "Delete from sweepitemmaster"];
    if (!d)
    {
        NSLog(@"delete failed sweepitemmaster!!");
    }
    else {
        NSLog(@"successfully delete sweepitemmaster");
        
    }
    NSLog(@"Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    
    BOOL e= [db executeUpdate:@ "Delete from sweepcat"];
    if (!e)
    {
        NSLog(@"delete failed sweepcat!!");
    }
    else {
        NSLog(@"successfully delete sweepcat");
        
    }
    
    NSLog(@"Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    
    for (i=0; i<[sweepidarray count]; i++) 
    {
        for (j=0; j<[[catidarray objectAtIndex:i]count]; j++)
        {
            
            
            sqlite3_stmt *stmt;
            int x;
            char *update = "insert into sweepcat values(?,?,?);";
            x = sqlite3_prepare_v2(database, update, -1, &stmt, nil);
                       
            if (x == SQLITE_OK) 
            { 
                sqlite3_bind_text(stmt, 1, NULL,-1, NULL);	
                sqlite3_bind_text(stmt, 2, [[NSString stringWithFormat:@"%@",[sweepidarray objectAtIndex:i]] UTF8String],-1, NULL);
                sqlite3_bind_text(stmt, 3, [[NSString stringWithFormat:@"%@",[[catidarray objectAtIndex:i]objectAtIndex:j]]UTF8String],-1, NULL);
                
            }		
            if (sqlite3_step(stmt) != SQLITE_DONE){
                NSLog(@"error");
            }
            else 
            {
                 NSLog(@"Success");
            }
           
            sqlite3_finalize(stmt);
        }

    }
   
    for (i=0; i<[sweepidarray count]; i++)
    {
                
        sqlite3_stmt *stmt1;
        int x;
        char *update = "insert into sweepitemmaster values(?,?,?,?,?,?,?,?);";
        x = sqlite3_prepare_v2(database, update, -1, &stmt1, nil);
       
        
        if (x == SQLITE_OK) 
        { 
            sqlite3_bind_text(stmt1, 1, NULL,-1, NULL);	
            sqlite3_bind_text(stmt1, 2, [[NSString stringWithFormat:@"%@",[sweepidarray objectAtIndex:i]] UTF8String],-1, NULL);
            sqlite3_bind_text(stmt1, 3, [[titlenamearray objectAtIndex:i] UTF8String],-1, NULL);
            sqlite3_bind_text(stmt1, 4, [[imagearry objectAtIndex:i] UTF8String],-1, NULL);
            sqlite3_bind_text(stmt1, 5, [[titlenamearray objectAtIndex:i] UTF8String],-1, NULL);
            sqlite3_bind_text(stmt1, 6, [[NSString stringWithFormat:@"%@",[productprizearray objectAtIndex:i]] UTF8String],-1, NULL);
            sqlite3_bind_text(stmt1, 7, [[NSString stringWithFormat:@"%@",[timestamparray objectAtIndex:i]] UTF8String],-1, NULL);
            sqlite3_bind_text(stmt1, 8, [[timearray objectAtIndex:i] UTF8String],-1, NULL);
          
        }		
        if (sqlite3_step(stmt1) != SQLITE_DONE){
            NSLog(@"error");
        }
        else {
            NSLog(@"Success");
        }
        
        sqlite3_finalize(stmt1);

    }



}
/*
-(void)viewDidAppear:(BOOL)animated{

    creditlb.font = [UIFont fontWithName:@"Calibri-BoldItalic" size:18];
    sortfilterlbl.font = [UIFont fontWithName:@"Calibri-BoldItalic" size:16];
    
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    FMResultSet *results=[db executeQuery:@"SELECT * FROM login_master where rowid=1 "];
    while ([results next]) 
    {
      //  usrid = [[NSString alloc]initWithString:[results stringForColumn:@"userid"]];
      //  NSLog(@"----->%@",[results stringForColumn:@"userid"]) ;       
        creditlb.text = [NSString stringWithFormat:@"%@",[results stringForColumn:@"credits"]];
    }
    [db close];
    CGSize textSize = [creditlb.text sizeWithFont:[UIFont fontWithName:@"Calibri-BoldItalic" size:18]];
    x= textSize.width;
    if (plus) {
        CGRect frame = CGRectMake(268-x,5,10,20);
        plus.frame = frame;
    }
    else 
    {
        plus = [[UILabel alloc]initWithFrame:CGRectMake(268-x,5,10,20)];
        [plus setTextColor:[UIColor colorWithRed:67.0/255.0 green:113.0/255.0 blue:114.0/255.0 alpha:1.0]];
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
        [credit setTextColor:[UIColor colorWithRed:67.0/255.0 green:113.0/255.0 blue:114.0/255.0 alpha:1.0]];
        [credit setBackgroundColor:[UIColor clearColor]];
        credit.textAlignment = UITextAlignmentLeft;
        credit.font=[UIFont fontWithName:@"Calibri-BoldItalic" size:11];
        credit.text = @"Tickets";
        [self.view addSubview:credit];
        [credit release];
    } 

    
}
*/
- (void)imageDidLoad: (DTLazyImageView *) lazyImageView
{
    
}
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    return [sweepidarray count];
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
   
    UIView *uview=[[UIView alloc]initWithFrame:CGRectMake(0,0,320,194)];
    uview.layer.masksToBounds=YES;
    
    UIImageView *mainback =[[UIImageView alloc] initWithFrame:CGRectMake(7,0,305,194)]; 
    mainback.image = [UIImage imageNamed:@"Image_02tb.png"];
    [uview addSubview:mainback];
    [mainback release];
    
    UIImageView *priceback =[[UIImageView alloc] initWithFrame:CGRectMake(8,8,82,23)]; 
    priceback.image = [UIImage imageNamed:@"Image_04tb.png"];
    
    
   // UIImageView *watch =[[UIImageView alloc] initWithFrame:CGRectMake(170,9,20,20)];
     UIImageView *watch =[[UIImageView alloc] initWithFrame:CGRectMake(190,9,20,20)]; 
    watch.image = [UIImage imageNamed:@"Image_03tb.png"];
    [uview addSubview:watch];
    [watch release];
    
    UIImageView *imgback =[[UIImageView alloc] initWithFrame:CGRectMake(15,35,288,115)]; 
    imgback.contentMode = UIViewContentModeScaleAspectFill;
    
    UIView *uviewimg=[[UIView alloc]initWithFrame:CGRectMake(0,0,288,115)];
    uviewimg.layer.masksToBounds=YES;
    uviewimg.layer.cornerRadius = 10.0;
    uviewimg.layer.borderColor = [[UIColor clearColor]CGColor];
    uviewimg.layer.borderWidth = 2.0;
   
    UIView *transperent=[[UIView alloc]initWithFrame:CGRectMake(0,90,288,25)];
    transperent.layer.masksToBounds=YES;
    transperent.backgroundColor =[UIColor colorWithRed:99.0/255.0 green:163.0/255.0 blue:164.0/255.0 alpha:0.7]; 
    
    UILabel *mainlb = [[UILabel alloc]initWithFrame:CGRectMake(2,3,288,25)];
    [mainlb setTextColor:[UIColor whiteColor]];
    [mainlb setBackgroundColor:[UIColor clearColor]];
    mainlb.textAlignment = UITextAlignmentCenter;
    mainlb.font=[UIFont fontWithName:@"Calibri-Italic" size:16];
    mainlb.text = @"VIEW SWEEPSTAKES";
    [transperent addSubview:mainlb];
    [mainlb release];
   
    lazyImageView = [[DTLazyImageView alloc] initWithFrame:CGRectMake(0, 0,288,115)];
    lazyImageView.delegate = self;
    lazyImageView.tag = indexPath.row;
   // lazyImageView.contentMode = UIViewContentModeScaleAspectFill;
    lazyImageView.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGPATH,[imagearry objectAtIndex:indexPath.row]]];
    [uviewimg addSubview:lazyImageView];
    [uviewimg addSubview:transperent];
    [imgback addSubview:uviewimg];

    if (! lazyImageView.image) {
        [lazyImageView startLoading];
        lazyImageView.actv.frame = CGRectMake(130, 27, 30, 30);
    }
    [uview addSubview:imgback];
    [transperent release];
    [uviewimg release];
    [imgback release];
   
    UILabel *pricelb = [[UILabel alloc]initWithFrame:CGRectMake(10,0,50,27)];
    [pricelb  setTextColor:[UIColor colorWithRed:63.0/255.0 green:97.0/255.0 blue:98.0/255.0 alpha:1.0]];
    [pricelb  setBackgroundColor:[UIColor clearColor]];    
    pricelb .textAlignment = UITextAlignmentCenter;
    pricelb.font=[UIFont fontWithName:@"Consolas-Bold" size:16];
    pricelb.adjustsFontSizeToFitWidth = YES;
    pricelb .text =[NSString stringWithFormat:@"$%@",[productprizearray objectAtIndex:indexPath.row]];
    [priceback addSubview:pricelb];
    [uview addSubview:priceback];
    [pricelb release];
    [priceback release];
    
    UILabel *cardname = [[UILabel alloc]initWithFrame:CGRectMake(10,153,302,30)];
    [cardname setTextColor:[UIColor colorWithRed:99.0/255.0 green:92.0/255.0 blue:84.0/255.0 alpha:1.0]];
    [cardname setBackgroundColor:[UIColor clearColor]];
    cardname.textAlignment = UITextAlignmentCenter;
    cardname.font=[UIFont fontWithName:@"Ebrima" size:17];
    cardname.text = [titlenamearray objectAtIndex:indexPath.row];
    [uview addSubview:cardname];
    [cardname release];
    
    
    UILabel *detaillb = [[UILabel alloc]initWithFrame:CGRectMake(210,6,100,25)];
    [detaillb setTextColor:[UIColor colorWithRed:121.0/255.0 green:116.0/255.0 blue:112.0/255.0 alpha:1.0]];
    [detaillb setBackgroundColor:[UIColor clearColor]];
    detaillb.font=[UIFont fontWithName:@"Ebrima-Bold" size:14];
    detaillb.text =[NSString stringWithFormat:@" %@",[timearray objectAtIndex:indexPath.row]];
//    if ([[timestamparray objectAtIndex:indexPath.row]intValue]>0) {
//    NSInteger totalminut=[[timestamparray objectAtIndex:indexPath.row]intValue]/60;
//    NSInteger totalhour=totalminut/60;
//    NSInteger minut=totalminut%60;
//    NSInteger day=totalhour/24;
//    NSInteger hour=totalhour%24;
//    NSInteger seconds=[[timestamparray objectAtIndex:indexPath.row]intValue]%60;
//    detaillb.text =[NSString stringWithFormat:@"%d Days, %.2d:%.2d:%.2d",day,hour,minut,seconds];
//    }
//    else{
//    detaillb.text =@"0 Days, 00:00:00";
//    }
    [uview addSubview:detaillb];
    [detaillb release];
    [cell addSubview:uview];
    [uview release];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{   
    [listingtable deselectRowAtIndexPath:indexPath animated:YES];
   
    SweepDetailViewController *godetail = [[SweepDetailViewController alloc]initWithNibName:@"SweepDetailViewController" bundle:nil];
   // NSLog(@"-->%@ -->%@",[sweepidarray objectAtIndex:indexPath.row],[titlenamearray objectAtIndex:indexPath.row]);
    
    godetail.selectedsweepid =[sweepidarray objectAtIndex:indexPath.row];
    
    /*********ALSO AT THIS POINT SAVE THIS DATA IN USER DEFAULTS***********/
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:godetail.selectedsweepid forKey:@"currentSweepsid"];
    /**********************************************************************/
    
    godetail.userid = usrid;
    [self.navigationController pushViewController:godetail animated:YES];
    
    DELEGATE.tempNav = self.navigationController;
}


-(void)Tapsweepstack{

    if (sortfilterlbl.tag==1) {
        sortfilterlbl.tag = 2;
    [self.view addSubview:view2];
       

       
    }else 
    {
        sortfilterlbl.tag=1;
        [self sorting];
         [view2 removeFromSuperview];
        
    }
}
-(void)sorting{
       
        if ([catidstrarr count]==0 && sortby == YES) 
        {
            
            [imagearry removeAllObjects];
            [titlenamearray removeAllObjects];
            [sweepidarray removeAllObjects];
            [productprizearray removeAllObjects];
            [timearray removeAllObjects];
           
            FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
            [db open]; 
            FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"SELECT * FROM sweepitemmaster order by %@",pricetime]];
            while ([results next])
            {
            [imagearry addObject:[results stringForColumn:@"imageurl"]]; 
            [titlenamearray addObject:[results stringForColumn:@"title"]];
            [sweepidarray addObject:[results stringForColumn:@"sweepid"]];
            [productprizearray addObject:[results stringForColumn:@"productprize"]];
            [timearray  addObject:[results stringForColumn:@"remainingtime"]];
            }
        
        }
        
        else if ([catidstrarr count]>0 && sortby == YES)
        {
            FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
            [db open]; 
            NSString *idstring = [NSString stringWithFormat:@"catid="];
            for (i=0; i<[catidstrarr count]-1; i++)
            {
                idstring = [NSString stringWithFormat:@"%@%@ or catid=",idstring,[catidstrarr objectAtIndex:i]];
            }
            idstring = [NSString stringWithFormat:@"%@%@",idstring,[catidstrarr lastObject]];
        
            [imagearry removeAllObjects];
            [titlenamearray removeAllObjects];
            [sweepidarray removeAllObjects];
            [productprizearray removeAllObjects];
            [timearray removeAllObjects];
            filtersweepidarr = [[NSMutableArray alloc]init];
        
            FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"SELECT DISTINCT sweepid from  sweepcat  where %@",idstring]];
            while ([results next])
            {
                [filtersweepidarr addObject:[results stringForColumn:@"sweepid"]];
               
            }
        
            if ([filtersweepidarr count]>0) {
                
            
             NSString *sweepstring = [NSString stringWithFormat:@"sweepid="];
            for (i=0; i<[filtersweepidarr count]-1; i++) 
            {
               sweepstring = [NSString stringWithFormat:@"%@%@ or sweepid=",sweepstring,[filtersweepidarr objectAtIndex:i]];
            } 
           sweepstring = [NSString stringWithFormat:@"%@%@",sweepstring,[filtersweepidarr lastObject]];
                
            FMResultSet *results1 = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM sweepitemmaster where  %@ order by %@",sweepstring,pricetime]];
                while ([results1 next])
                {
                    [imagearry addObject:[results1 stringForColumn:@"imageurl"]]; 
                    [titlenamearray addObject:[results1 stringForColumn:@"title"]];
                    [sweepidarray addObject:[results1 stringForColumn:@"sweepid"]];
                    [productprizearray addObject:[results1 stringForColumn:@"productprize"]];
                    [timearray  addObject:[results1 stringForColumn:@"remainingtime"]];
                }
            }
        }
        else if ([catidstrarr count]==0 && sortbyprice == YES) 
        {
            
            [imagearry removeAllObjects];
            [titlenamearray removeAllObjects];
            [sweepidarray removeAllObjects];
            [productprizearray removeAllObjects];
            [timearray removeAllObjects];
            
            FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
            [db open]; 
            FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"SELECT * FROM sweepitemmaster order by CAST(%@ AS DOUBLE)  desc",pricetime]];
            while ([results next])
            {
                [imagearry addObject:[results stringForColumn:@"imageurl"]]; 
                [titlenamearray addObject:[results stringForColumn:@"title"]];
                [sweepidarray addObject:[results stringForColumn:@"sweepid"]];
                [productprizearray addObject:[results stringForColumn:@"productprize"]];
                [timearray  addObject:[results stringForColumn:@"remainingtime"]];
            }
            
        }
        
        else if ([catidstrarr count]>0 && sortbyprice == YES)
        {
            FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
            [db open]; 
            NSString *idstring = [NSString stringWithFormat:@"catid="];
            for (i=0; i<[catidstrarr count]-1; i++)
            {
                idstring = [NSString stringWithFormat:@"%@%@ or catid=",idstring,[catidstrarr objectAtIndex:i]];
            }
            idstring = [NSString stringWithFormat:@"%@%@",idstring,[catidstrarr lastObject]];
            
            [imagearry removeAllObjects];
            [titlenamearray removeAllObjects];
            [sweepidarray removeAllObjects];
            [productprizearray removeAllObjects];
            [timearray removeAllObjects];
            filtersweepidarr = [[NSMutableArray alloc]init];
            
            FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"SELECT DISTINCT sweepid from  sweepcat  where %@",idstring]];
            while ([results next])
            {
                [filtersweepidarr addObject:[results stringForColumn:@"sweepid"]];
                
            }
           
            if ([filtersweepidarr count]>0) {
                
                
                NSString *sweepstring = [NSString stringWithFormat:@"sweepid="];
                for (i=0; i<[filtersweepidarr count]-1; i++) 
                {
                    sweepstring = [NSString stringWithFormat:@"%@%@ or sweepid=",sweepstring,[filtersweepidarr objectAtIndex:i]];
                } 
                sweepstring = [NSString stringWithFormat:@"%@%@",sweepstring,[filtersweepidarr lastObject]];
              
                
                FMResultSet *results1 = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM sweepitemmaster where  %@ order by CAST(%@ AS DOUBLE) desc",sweepstring,pricetime]];
                while ([results1 next])
                {
                    [imagearry addObject:[results1 stringForColumn:@"imageurl"]]; 
                    [titlenamearray addObject:[results1 stringForColumn:@"title"]];
                    [sweepidarray addObject:[results1 stringForColumn:@"sweepid"]];
                    [productprizearray addObject:[results1 stringForColumn:@"productprize"]];
                    [timearray  addObject:[results1 stringForColumn:@"remainingtime"]];
                }
            }
        }
    
        else if([catidstrarr count]>0 && sortby == NO && sortbyprice ==NO) 
        {
            
            FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
            [db open]; 
            NSString *idstring = [NSString stringWithFormat:@"catid="];
            for (i=0; i<[catidstrarr count]-1; i++)
            {
                idstring = [NSString stringWithFormat:@"%@%@ or catid=",idstring,[catidstrarr objectAtIndex:i]];
            }
            idstring = [NSString stringWithFormat:@"%@%@",idstring,[catidstrarr lastObject]];
            
            [imagearry removeAllObjects];
            [titlenamearray removeAllObjects];
            [sweepidarray removeAllObjects];
            [productprizearray removeAllObjects];
            [timearray removeAllObjects];
            filtersweepidarr = [[NSMutableArray alloc]init];
            
            FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"SELECT DISTINCT sweepid from  sweepcat  where %@",idstring]];
            while ([results next])
            {
                [filtersweepidarr addObject:[results stringForColumn:@"sweepid"]];
                
            }
          
            if ([filtersweepidarr count]>0) 
            {
                
                
                NSString *sweepstring = [NSString stringWithFormat:@"sweepid="];
                for (i=0; i<[filtersweepidarr count]-1; i++) 
                {
                    sweepstring = [NSString stringWithFormat:@"%@%@ or sweepid=",sweepstring,[filtersweepidarr objectAtIndex:i]];
                } 
                sweepstring = [NSString stringWithFormat:@"%@%@",sweepstring,[filtersweepidarr lastObject]];
                              
                FMResultSet *results1 = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM sweepitemmaster where %@",sweepstring]];
                while ([results1 next])
                {
                    [imagearry addObject:[results1 stringForColumn:@"imageurl"]]; 
                    [titlenamearray addObject:[results1 stringForColumn:@"title"]];
                    [sweepidarray addObject:[results1 stringForColumn:@"sweepid"]];
                    [productprizearray addObject:[results1 stringForColumn:@"productprize"]];
                    [timearray  addObject:[results1 stringForColumn:@"remainingtime"]];
                }
            }
        }
     //   [self Setthewholeview];  
    [listingtable reloadData];
       
        }
        


- (void)viewDidUnload
{
    [self setScrollview:nil];
    [self setCreditlb:nil];
    [self setSortfilterlbl:nil];
    [self setSweeplb:nil];
    [self setSortbylb:nil];
   
    [self setCategorieslb:nil];
    [self setView2:nil];
    [pricebtn release];
    pricebtn = nil;
    [timebtn release];
    timebtn = nil;
    [giftcardbtn release];
    giftcardbtn = nil;
    [travelbtn release];
    travelbtn = nil;
    [ticketbtn release];
    ticketbtn = nil;
    [cashbtn release];
    cashbtn = nil;
    [shoppingbtn release];
    shoppingbtn = nil;
    [eventbtn release];
    eventbtn = nil;
    [listingtable release];
    listingtable = nil;
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
    [scrollview release];
    [creditlb release];
    [sortfilterlbl release];
    [sweeplb release];
    [sortbylb release];
    [categorieslb release];
    [view2 release];
    [pricebtn release];
    [timebtn release];
    [giftcardbtn release];
    [travelbtn release];
    [ticketbtn release];
    [cashbtn release];
    [shoppingbtn release];
    [eventbtn release];
    [listingtable release];
    [_backbtn release];
    [super dealloc];
}
- (IBAction)goback:(id)sender {
    // Display Slide Menu View
    
    CGRect frame = _backbtn.frame;
    frame.size.width = 41;
    _backbtn.frame = frame;

    [_backbtn setImage:[UIImage imageNamed:@"menu_open.png"] forState:UIControlStateNormal];
    [DELEGATE.menuController showLeftController:YES];

    
    // if (timer != nil)
     //   [timer invalidate];
   // timer = nil;
    
      // [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)priceaction:(id)sender {
  
    pricebtn.userInteractionEnabled = NO;
    timebtn.userInteractionEnabled = YES;
    [pricebtn setImage:[UIImage imageNamed:@"sortpriceclk.png"] forState:UIControlStateNormal];
    [timebtn setImage:[UIImage imageNamed:@"sorttime.png"] forState:UIControlStateNormal];
   // sortby = YES; 
    pricetime = [[NSString alloc]initWithString:@"productprize"];
    sortby = NO;
    sortbyprice = YES;
    [self sorting];
   
  
}

- (IBAction)timeaction:(id)sender {
    pricebtn.userInteractionEnabled = YES;
    timebtn.userInteractionEnabled = NO;
    [timebtn setImage:[UIImage imageNamed:@"sorttimeclk.png"] forState:UIControlStateNormal];
    [pricebtn setImage:[UIImage imageNamed:@"sortprice.png"] forState:UIControlStateNormal];
    sortby = YES;
    sortbyprice = NO;
    pricetime = [[NSString alloc]initWithString:@"timestamp"];
    [self sorting];
        
}

- (IBAction)giftcardaction:(id)sender {
    if (giftcardbtn.tag==1) {
        giftcardbtn.tag = 2;
        [giftcardbtn setImage:[UIImage imageNamed:@"sortgiftcardclk"] forState:UIControlStateNormal];
        [catidstrarr addObject:[NSString stringWithFormat:@"14"]];
    }else {
        giftcardbtn.tag=1;
         [giftcardbtn setImage:[UIImage imageNamed:@"sortgiftcard"] forState:UIControlStateNormal];
        [catidstrarr removeObject:[NSString stringWithFormat:@"14"]]; 
        
    }
    [self sorting];
   
    
}

- (IBAction)travelaction:(id)sender {
    if (travelbtn.tag==1) {
        travelbtn.tag = 2;
        [travelbtn setImage:[UIImage imageNamed:@"sorttravelclk"] forState:UIControlStateNormal];
        [catidstrarr addObject:[NSString stringWithFormat:@"15"]];
    }else {
        travelbtn.tag=1;
        [travelbtn setImage:[UIImage imageNamed:@"sorttravel"] forState:UIControlStateNormal];
        [catidstrarr removeObject:[NSString stringWithFormat:@"15"]]; 
    }
    [self sorting];
    
}

- (IBAction)ticketaction:(id)sender {
    if (ticketbtn.tag==1) {
        ticketbtn.tag = 2;
        [ticketbtn setImage:[UIImage imageNamed:@"sortticketclk"] forState:UIControlStateNormal];
        [catidstrarr addObject:[NSString stringWithFormat:@"20"]];
    }else {
        ticketbtn.tag=1;
        [ticketbtn setImage:[UIImage imageNamed:@"sortticket"] forState:UIControlStateNormal];
        [catidstrarr removeObject:[NSString stringWithFormat:@"20"]]; 
    }
    [self sorting];
}

- (IBAction)cashaction:(id)sender {
    if (cashbtn.tag==1) {
        cashbtn.tag = 2;
        [cashbtn setImage:[UIImage imageNamed:@"sortcashclk"] forState:UIControlStateNormal];
        [catidstrarr addObject:[NSString stringWithFormat:@"17"]];
    }else {
        cashbtn.tag=1;
        [cashbtn setImage:[UIImage imageNamed:@"sortcash"] forState:UIControlStateNormal];
        [catidstrarr removeObject:[NSString stringWithFormat:@"17"]]; 
    }
    [self sorting];
}

- (IBAction)shoppingaction:(id)sender {
    if (shoppingbtn.tag==1) {
        shoppingbtn.tag = 2;
        [shoppingbtn setImage:[UIImage imageNamed:@"sortshopingclk"] forState:UIControlStateNormal];
        [catidstrarr addObject:[NSString stringWithFormat:@"18"]];
    }else {
        shoppingbtn.tag=1;
        [shoppingbtn setImage:[UIImage imageNamed:@"sortshoping"] forState:UIControlStateNormal];
        [catidstrarr removeObject:[NSString stringWithFormat:@"18"]]; 
    }
    [self sorting];
    
}

- (IBAction)eventsaction:(id)sender {
    if (eventbtn.tag==1) {
        eventbtn.tag = 2;
        [eventbtn setImage:[UIImage imageNamed:@"sorteventclk"] forState:UIControlStateNormal];
        [catidstrarr addObject:[NSString stringWithFormat:@"19"]];
    }else {
        eventbtn.tag=1;
        [eventbtn setImage:[UIImage imageNamed:@"sortevent"] forState:UIControlStateNormal];
        [catidstrarr removeObject:[NSString stringWithFormat:@"19"]]; 
    }
    [self sorting];

    
}

- (IBAction)sortclose:(id)sender {
    
    
    [imagearry removeAllObjects];
    [titlenamearray removeAllObjects];
    [sweepidarray removeAllObjects];
    [productprizearray removeAllObjects];
    [timearray removeAllObjects];
    [catidstrarr removeAllObjects];
    
    FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open]; 
    FMResultSet *results = [db executeQuery:@"SELECT * FROM sweepitemmaster order by timestamp"];
    while ([results next])
    {
        [imagearry addObject:[results stringForColumn:@"imageurl"]]; 
        [titlenamearray addObject:[results stringForColumn:@"title"]];
        [sweepidarray addObject:[results stringForColumn:@"sweepid"]];
        [productprizearray addObject:[results stringForColumn:@"productprize"]];
        [timearray  addObject:[results stringForColumn:@"remainingtime"]];
    }
    [listingtable reloadData];
    sortfilterlbl.tag=1;
    [view2 removeFromSuperview];
    [timebtn setImage:[UIImage imageNamed:@"sorttime.png"] forState:UIControlStateNormal];
    [pricebtn setImage:[UIImage imageNamed:@"sortprice.png"] forState:UIControlStateNormal];
    giftcardbtn.tag=1;
    [giftcardbtn setImage:[UIImage imageNamed:@"sortgiftcard"] forState:UIControlStateNormal];
    travelbtn.tag=1;
    [travelbtn setImage:[UIImage imageNamed:@"sorttravel"] forState:UIControlStateNormal];
    ticketbtn.tag=1;
    [ticketbtn setImage:[UIImage imageNamed:@"sortticket"] forState:UIControlStateNormal];
    cashbtn.tag=1;
    [cashbtn setImage:[UIImage imageNamed:@"sortcash"] forState:UIControlStateNormal];
    shoppingbtn.tag=1;
    [shoppingbtn setImage:[UIImage imageNamed:@"sortshoping"] forState:UIControlStateNormal];
    eventbtn.tag=1;
    [eventbtn setImage:[UIImage imageNamed:@"sortevent"] forState:UIControlStateNormal];
    sortby = NO;
    sortbyprice = NO;
    pricebtn.userInteractionEnabled = YES;
    timebtn.userInteractionEnabled = YES;

}

- (IBAction)refreshresult:(id)sender {
    sortfilterlbl.tag=1;
    [view2 removeFromSuperview];
    
}
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
    if ([[alertView title] isEqualToString:@"User Does Not Exists"])
	{
       // [self.navigationController popToRootViewControllerAnimated:YES];
//        ViewController *gotorootview = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
//        [self.navigationController pushViewController:gotorootview animated:YES];
        LoginViewController *gotorootview = [[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil]autorelease];
        [self.navigationController pushViewController:gotorootview animated:YES];
        
        
	}
}    


@end
